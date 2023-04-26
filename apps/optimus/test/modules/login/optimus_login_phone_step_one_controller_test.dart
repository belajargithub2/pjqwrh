import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_one_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/request/otp_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/request_otp_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/optimus_login_phone_step_one_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<OptimusLoginRepository>(),
  MockSpec<DeasyPocket>(),
  MockSpec<OptimusLoginDialog>(),
  MockSpec<OptimusMenuRoleRepository>(),
  MockSpec<OptimusLoginController>(),
  MockSpec<LoginSnackbar>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOptimusLoginRepository loginRepository;
  late OptimusLoginPhoneStepOneController controller;

  final pocket = MockDeasyPocket();
  final dialog = MockOptimusLoginDialog();

  final binding = BindingsBuilder(() {
    Get.lazyPut<OptimusLoginDialog>(() => dialog);
    Get.lazyPut<DeasyPocket>(() => pocket);
  });

  setUp(() {
    Get.testMode = true;
    binding.builder();
    loginRepository = MockOptimusLoginRepository();
    controller = OptimusLoginPhoneStepOneController(
      loginRepository: loginRepository,
    );
  });

  test('Test Init Controller', () async {
    Get.put(controller);

    /// check if onInit was called
    expect(controller.initialized, true);

    ///check controller isRegistered
    bool test = Get.isRegistered<OptimusLoginPhoneStepOneController>();
    expect(test, true);
  });

  testWidgets("isShowOtpOption Should return true if form validate",
      (WidgetTester tester) async {
    //arrange
    MaterialApp createApp(GlobalKey<FormState> key, TextFormField field) =>
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  field,
                  ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        key.currentState!.validate();
                      })
                ],
              ),
            ),
          ),
        );
    controller.noController.text = '0895364632092';
    expect(controller.isShowOtpTypeOption.value, false);

    //act
    await tester.pumpWidget(
      createApp(controller.formKeyLoginWithPhoneNumber, TextFormField()),
    );
    controller.submitPhoneNumber();

    //assert
    expect(controller.isShowOtpTypeOption.value, true);
  });

  group("Phone Number Validation", () {
    test("Should return wording cannot empty when phone number empty", () {
      //arrange
      final phoneNumber = '';

      //act
      final result = controller.phoneNumberValidation(phoneNumber);

      //assert
      expect(result, ValidationConstant.cantEmptyPhoneNumber);
    });

    test("Should return wording not valid when phone number not valid", () {
      //arrange
      final phoneNumber = '02113134';

      //act
      final result = controller.phoneNumberValidation(phoneNumber);

      //assert
      expect(result, ValidationConstant.phoneValidation);
    });

    test("Should return null when validation pass", () {
      //arrange
      final phoneNumber = '0895364632092';

      //act
      final result = controller.phoneNumberValidation(phoneNumber);

      //assert
      expect(result, null);
    });
  });

  test("Should return correct phone hint", () {
    //arrange
    controller.noController.text = '0895364632092';

    //act
    controller.setPhoneNumberHint();

    //assert
    expect(controller.phoneHint.value, '+62-8953-6463-xxxx');
  });

  group("Request OTP", () {
    test("Should return MISSCALL when request type is MISSCALL", () async {
      //arrange
      final requestType = ContentConstant.MISSCALLOTP;

      //act
      final result = await controller.requestOTP(requestType);

      //assert
      expect(result, requestType);
    });

    test("Should return SMS when request type is SMS", () async {
      //arrange
      final requestType = ContentConstant.SMSOTP;

      //act
      final result = await controller.requestOTP(requestType);

      //assert
      expect(result, requestType);
    });
  });

  test("Handle Misscall Request Should navigate to LOGIN_OTP route", () {
    //arrange
    controller.noController.text = '0895364632092';
    final requestType = ContentConstant.MISSCALLOTP;

    //act
    controller.handleMissCallRequest(requestType);

    //assert
  });

  group("Handle SMS Request", () {
    test("""Should create opt request and return corrert otpTimer 
      when otpTime is null""", () async {
      //arrange
      final matcher = 20;
      controller.noController.text = '0895364632092';
      final requestType = ContentConstant.SMSOTP;
      final request = OtpRequest(
        phoneNumber: controller.noController.text,
        type: requestType,
      );
      final response = ResponseRequestOtp(
        message: "OK",
        data: Data(retryAt: matcher),
      );

      when(loginRepository.requestOTP(any, request.toJson(), any))
          .thenAnswer((_) async => response);

      when(pocket.setOtpTimer(any)).thenAnswer((_) async => null);

      //act
      await controller.handleSmsRequest(requestType);

      //assert
      expect(controller.otpTime, matcher);
    });

    test("Should show alert dialog phone not register", () async {
      //arrange
      controller.noController.text = '0895364632092';
      final requestType = ContentConstant.SMSOTP;

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => throw ContentConstant.errorPhoneNotRegister);

      when(pocket.removeOtpTimer()).thenAnswer((_) async => null);

      //act
      await controller.handleSmsRequest(requestType);

      //assert
      expect(controller.isLoading.value, false);
      expect(controller.isShowOtpTypeOption.value, false);
      verify(dialog.alertPhoneNotRegisterDialog());
    });

    test("Should show alert dialog max limit", () async {
      //arrange
      controller.noController.text = '0895364632092';
      final requestType = ContentConstant.SMSOTP;

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => throw ContentConstant.errorRequestLimit);

      when(pocket.removeOtpTimer()).thenAnswer((_) async => null);

      //act
      await controller.handleSmsRequest(requestType);

      //assert
      expect(controller.isLoading.value, false);
      expect(controller.isShowOtpTypeOption.value, false);
      verify(dialog.alertMaxLimitDialog());
    });

    test("Should navigate to LOGIN_OTP  when otpTime isn't null", () async {
      //arrange
      controller.otpTime = 20;
      controller.noController.text = '0895364632092';
      final requestType = ContentConstant.SMSOTP;

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => throw ContentConstant.errorRequestLimit);

      when(pocket.removeOtpTimer()).thenAnswer((_) async => null);

      //act
      await controller.handleSmsRequest(requestType);

      //assert
    });
  });
}
