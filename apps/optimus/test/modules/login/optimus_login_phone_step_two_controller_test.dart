import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/request_otp_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/optimus_login_phone_step_one_controller_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBuildContext context;
  late MockOptimusLoginRepository loginRepository;
  late MockOptimusLoginController loginController;
  late MockOptimusMenuRoleRepository menuRoleRepository;
  late OptimusLoginPhoneStepTwoController controller;

  final pocket = MockDeasyPocket();
  final dialog = MockOptimusLoginDialog();
  final snackbar = MockLoginSnackbar();

  final binding = BindingsBuilder(() {
    Get.lazyPut<OptimusLoginDialog>(() => dialog);
    Get.lazyPut<DeasyPocket>(() => pocket);
    Get.lazyPut<LoginSnackbar>(() => snackbar);
  });

  setUp(() {
    Get.testMode = true;
    binding.builder();
    context = MockBuildContext();
    loginRepository = MockOptimusLoginRepository();
    loginController = MockOptimusLoginController();
    menuRoleRepository = MockOptimusMenuRoleRepository();

    controller = OptimusLoginPhoneStepTwoController(
      loginRepository: loginRepository,
      loginController: loginController,
      menuRoleRepository: menuRoleRepository,
    );
  });

  tearDown(() {
    Get.delete<OptimusLoginPhoneStepTwoController>();
  });

  group("Controller Initialize", () {
    test("Should be initialize and registered", () {
      //arrange

      //act
      Get.put(controller);

      //assert
      expect(controller.initialized, true);
      expect(Get.isRegistered<OptimusLoginPhoneStepTwoController>(), true);
    });

    test("Should navigate to LOGIN route when Get.argument is null ", () {
      //arrange

      //act
      Get.put(controller);
      controller.onReady();

      //assert
    });
  });

  group("Check request type otp", () {
    test("""Should return SMS & isOnBoardingShow false 
    when request type is SMS""", () {
      //arrange
      controller.phoneNumber.value = '0895364632092';
      final requestType = ContentConstant.SMSOTP;

      //act
      controller.checkRequestOtpType(requestType: requestType);

      //assert
      expect(controller.isOnBoardingShow.value, false);
      expect(controller.requestOtpType.value, requestType);
    });

    test("""Should return MISSCALL & isOnBoardingShow true 
    when request type is MISSCALL""", () {
      //arrange
      final requestType = ContentConstant.MISSCALLOTP;

      //act
      controller.checkRequestOtpType(requestType: requestType);

      //assert
      expect(controller.isOnBoardingShow.value, true);
      expect(controller.requestOtpType.value, requestType);
    });
  });

  test("Should return correct phone hint", () {
    //arrange
    controller.phoneNumber.value = '0895364632092';

    //act
    controller.setPhoneNumberHint();

    //assert
    expect(controller.phoneHint.value, '+62-8953-6463-xxxx');
  });

  test("Should return correct last request otp time", () async {
    //arrange
    final matcher = 20;
    when(pocket.getOtpTimer()).thenAnswer((_) async => matcher);

    //act
    await controller.getTimerCache();

    //assert
    expect(controller.lastRequestOtp.value, matcher);
  });

  test("Initialize Focus Node", () {
    //act
    controller.initFocusNodeListener();
  });

  testWidgets("Add focus listener", (WidgetTester tester) async {
    //arrange

    final fieldController = TextEditingController();
    fieldController.text = '0';
    final focusNode = FocusNode();

    final matcher = TextSelection(
      baseOffset: 0,
      extentOffset: fieldController.text.length,
    );

    MaterialApp createApp(BuildContext context) => MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(focusNode);
                    controller.addFocusNodeListener(fieldController, focusNode);
                  },
                )
              ],
            ),
          ),
        );

    //act
    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return createApp(context);
    }));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    //assert
    expect(fieldController.selection, matcher);
  });

  test("Should return corrert value when setTimer", () {
    //arrange
    final lastRequest = 20;
    final currentDate = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(lastRequest * 1000);
    final matcher = date.difference(currentDate);

    //act
    controller.setTimer(lastRequest);

    //assert
    expect(controller.otpTimer.value.inSeconds, matcher.inSeconds);
  });

  group("Check OTP Text", () {
    test("Should return 6 when otp is empty", () {
      //arrange
      controller.otpArray.value = ['', '', '', '', '', ''];

      //act
      final result = controller.checkOTPText(context);

      //assert
      expect(result, 6);
    });

    testWidgets(
        "Should return correct OTP code and do login when otp is filled",
        (WidgetTester tester) async {
      //arrange
      controller.otpArray.value = ['1', '2', '3', '4', '5', '6'];

      final response = OptimusLoginResponse(
        data: LoginData(code: ContentConstant.LOGIN_PHONE_NUMBER_IS_MUTIPLE),
      );

      MaterialApp createApp(BuildContext context) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      controller.checkOTPText(context);
                    },
                  )
                ],
              ),
            ),
          );

      //act
      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return createApp(context);
      }));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //assert
      expect(controller.otpCode.value, "123456");
    });
  });

  group("Request Call Otp", () {
    test("Should show onboarding page when no otpTimer cache", () {
      //arrange

      //act
      controller.requestCallOtp();

      //assert
      expect(controller.isOnBoardingShow.value, true);
    });

    test("Should not show onboarding page when no las request otp cache", () {
      //arrange
      controller.lastRequestOtp.value = 20;

      //act
      controller.requestCallOtp();

      //assert
      expect(controller.isOnBoardingShow.value, false);
    });
  });

  group("Request OTP", () {
    test("Should set otp timer and hide onboarding page when succces",
        () async {
      //arrange
      controller.phoneNumber.value = "0895364632092";
      controller.requestOtpType.value = ContentConstant.SMSOTP;

      final matcher = 20;
      final response = ResponseRequestOtp(
        message: "OK",
        data: Data(retryAt: matcher),
      );

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => response);

      when(pocket.setOtpTimer(any)).thenAnswer((_) async => null);

      //act
      await controller.requestOTP();

      //assert
      verify(pocket.setOtpTimer(response.data!.retryAt));
      expect(controller.isOnBoardingShow.value, false);
      expect(controller.canRequestOTP.value, false);
    });

    test("Should show alert dialog phone not register", () async {
      //arrange
      controller.phoneNumber.value = "0895364632092";
      controller.requestOtpType.value = ContentConstant.SMSOTP;

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => throw ContentConstant.errorPhoneNotRegister);

      when(pocket.removeOtpTimer()).thenAnswer((_) async => null);

      //act
      await controller.requestOTP();

      //assert
      verify(dialog.alertPhoneNotRegisterDialog());
      verify(pocket.removeOtpTimer());
    });

    test("Should show alert dialog max limit", () async {
      //arrange
      controller.phoneNumber.value = "0895364632092";

      when(loginRepository.requestOTP(any, any, any))
          .thenAnswer((_) async => throw ContentConstant.errorRequestLimit);

      when(pocket.removeOtpTimer()).thenAnswer((_) async => null);

      //act
      await controller.requestOTP();

      //assert
      verify(dialog.alertMaxLimitDialog());
      verify(pocket.removeOtpTimer());
    });
  });

  group("Login", () {
    testWidgets("Error", (WidgetTester tester) async {
      //arrange
      when(loginRepository.postApiLoginUsePhoneNumber(
        context,
        otsCode: anyNamed('otsCode'),
        phoneNumber: anyNamed('phoneNumber'),
        deviceId: anyNamed('deviceId'),
      )).thenAnswer((_) async => throw Exception());

      MaterialApp createApp(BuildContext context) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      controller.login(context);
                    },
                  )
                ],
              ),
            ),
          );

      //act
      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return createApp(context);
      }));

      //assert
    });

    testWidgets(
        "Should show error flush bar account already login on another device",
        (WidgetTester tester) async {
      //arrange
      controller.phoneNumber.value = '0895364632092';
      controller.otpCode.value = '123456';

      final response = OptimusLoginResponse(
        data: LoginData(code: ContentConstant.LOGIN_PHONE_NUMBER_IS_MUTIPLE),
      );

      when(loginController.deviceId).thenReturn("test");
      when(loginRepository.postApiLoginUsePhoneNumber(
        any,
        otsCode: anyNamed('otsCode'),
        phoneNumber: anyNamed('phoneNumber'),
        deviceId: anyNamed('deviceId'),
        eventName: anyNamed('eventName'),
      )).thenAnswer((_) async => response);

      when(snackbar.showFlushbarError(
        any,
        ContentConstant.hasLogin,
      )).thenReturn(null);

      MaterialApp createApp(BuildContext context) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      controller.login(context);
                    },
                  )
                ],
              ),
            ),
          );

      //act
      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return createApp(context);
      }));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //assert
      verify(snackbar.showFlushbarError(
        any,
        ContentConstant.hasLogin,
      ));
    });

    testWidgets("Should show error flush bar error role access",
        (WidgetTester tester) async {
      //arrange
      controller.phoneNumber.value = '0895364632092';
      controller.otpCode.value = '123456';

      final response = OptimusLoginResponse(
        data: LoginData(code: "test"),
      );

      when(loginController.deviceId).thenReturn("test");
      when(loginController.checkRoleForWeb(any)).thenReturn(false);
      when(loginRepository.postApiLoginUsePhoneNumber(
        any,
        otsCode: anyNamed('otsCode'),
        phoneNumber: anyNamed('phoneNumber'),
        deviceId: anyNamed('deviceId'),
        eventName: anyNamed('eventName'),
      )).thenAnswer((_) async => response);

      when(snackbar.showFlushbarError(
        any,
        ContentConstant.errorRoleAccessForWeb,
      )).thenReturn(null);

      MaterialApp createApp(BuildContext context) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      controller.login(context);
                    },
                  )
                ],
              ),
            ),
          );

      //act
      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return createApp(context);
      }));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //assert
      verify(snackbar.showFlushbarError(
        any,
        ContentConstant.errorRoleAccessForWeb,
      ));
    });

    testWidgets("Success", (WidgetTester tester) async {
      //arrange
      controller.phoneNumber.value = '0895364632092';
      controller.otpCode.value = '123456';

      final response = OptimusLoginResponse(
        data: LoginData(code: "test"),
      );

      final responseMenuRepo = OptimusRoleDetailResponse(
        data: RoleData(
          dashboardPermission: DashboardPermission(),
          menuPermission: MenuPermission(),
        ),
      );

      when(loginController.deviceId).thenReturn("test");
      when(loginController.checkRoleForWeb(any)).thenReturn(true);
      when(loginController.navigateToHome()).thenReturn(null);
      when(loginRepository.postApiLoginUsePhoneNumber(
        any,
        otsCode: anyNamed('otsCode'),
        phoneNumber: anyNamed('phoneNumber'),
        deviceId: anyNamed('deviceId'),
        eventName: anyNamed('eventName'),
      )).thenAnswer((_) async => response);

      when(menuRoleRepository.getDetailRole(
        any,
        any,
      )).thenAnswer((_) async => responseMenuRepo);

      MaterialApp createApp(BuildContext context) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      controller.login(context);
                    },
                  )
                ],
              ),
            ),
          );

      //act
      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return createApp(context);
      }));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //assert
      verify(loginController.navigateToHome());
    });
  });

  test("On Login Success", () async {
    //arrange
    final response = OptimusRoleDetailResponse(
      data: RoleData(
        dashboardPermission: DashboardPermission(),
        menuPermission: MenuPermission(),
      ),
    );

    when(pocket.removeOtpTimer()).thenAnswer((_) async => null);
    when(loginController.saveDataToLocalAfterDoLogin(
      response: anyNamed('response'),
      isLoginByEmail: anyNamed('isLoginByEmail'),
    )).thenAnswer((_) async => null);
    when(menuRoleRepository.getDetailRole(
      any,
      any,
    )).thenAnswer((_) async => response);

    //act
    await controller.onLoginSuccess(LoginData());

    //assert
    verify(pocket.removeOtpTimer());
    verify(loginController.saveDataToLocalAfterDoLogin(
        response: anyNamed('response'),
        isLoginByEmail: anyNamed('isLoginByEmail')));
    verify(menuRoleRepository.getDetailRole(any, any));
  });
}
