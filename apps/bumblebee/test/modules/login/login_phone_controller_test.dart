import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import '../../mocks/build_context_mock.dart';
import '../../mocks/repository/login_repository_mock.dart';

class LoginControllerMock extends GetxController with Mock implements BumblebeeLoginController {}
class MenuRoleRepositoryMock extends GetxController with Mock implements MenuRoleRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setFlavor(DevFlavorConfig());
  BumblebeeLoginPhoneController? phoneNumberController;

  //init mock login controller
  final loginControllerMock = LoginControllerMock();

  // Dependencies Injection with mock repository
  BindingsBuilder binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeLoginController>(
      () => loginControllerMock,
    );
    Get.lazyPut<BumblebeeLoginPhoneController>(
      () => BumblebeeLoginPhoneController(
        loginRepository: LoginRepositoryMock(),
        menuRoleRepository: MenuRoleRepositoryMock(),
      ),
    );
  });

  setUp(() {
    // Test mode true when using Navigation in controller that tested
    Get.testMode = true;

    binding.builder();

    phoneNumberController = Get.find<BumblebeeLoginPhoneController>();
  });

  tearDown(() {
    Get.delete<BumblebeeLoginController>();
    Get.delete<BumblebeeLoginPhoneController>();
  });

  group('Test BumblebeeLoginPhoneController', () {
    test("Test onInit Controller", () {
      expect(phoneNumberController, isInstanceOf<BumblebeeLoginPhoneController>());

      // check if onInit was called
      expect(phoneNumberController!.initialized, isTrue);

      //check controller isRegistered
      bool test = Get.isRegistered<BumblebeeLoginController>();
      expect(test, true);
    });

    test('requestOTP test', () async {
      phoneNumberController!.noController.text = '0987654312';
      final actual = await phoneNumberController!.requestOTP(true);
      expect(actual, 1);
    });

    group('Test phone number validation', () {
      test('phone number validation true', () {
        // phoneNumberController.noController.text = '081234567890';
        // expect(phoneNumberController.phoneNumberValidation(), isA<Null>());
      });

      test('phone number validation false', () {
        // phoneNumberController.noController.text = 'invalid input';
        // expect(phoneNumberController.phoneNumberValidation(), isA<String>());
      });

      test('Set phone number', () {
        phoneNumberController!.setPhoneNumber('08765432121');
        expect(phoneNumberController!.phoneNumber.value, '08765432121');
      });
    });

    //Test case still not working
    test('login test', () async {
      final _mockBuildContext = MockBuildContext();
      when(_mockBuildContext.owner).thenReturn(BuildOwner(focusManager: FocusManager()));

      //TODO(arrkariz): need equatable to compare with object returned from login_repository_mock
      // final tesResponse = LoginResponse();
      // when(loginControllerMock.checkRole(tesResponse)).thenReturn(true);

      await phoneNumberController!.login(_mockBuildContext);
      expect(phoneNumberController!.isLoading.value, isTrue);
    });

    //Test case still not working
    group('Test Submit', () {
      test('OTP is empty', () {
        phoneNumberController!.noController.text = '081234567890';
        phoneNumberController!.submit();
        expect(phoneNumberController!.isLoading.value, isTrue);
      });
      test('phoneNumber is empty', () {
        phoneNumberController!.otpController.text = 'otp';
        phoneNumberController!.submit();
        expect(phoneNumberController!.isLoading.value, isTrue);
      });
      test('Success', () {
        phoneNumberController!.noController.text = '081234567890';
        phoneNumberController!.otpController.text = 'otp';
        phoneNumberController!.submit();
        expect(phoneNumberController!.isLoading.value, isTrue);
      });
    });

    test('createRequesOTP test', () {
      expect(phoneNumberController!.createRequesOTP(), isMap);
    });

    test('Test navigate to register', () {
      phoneNumberController!.navigateToRegister();
    });

    group('Test preRequest OTP', () {
      //Test case still not working
      test('preRequestOTP success', () {
        phoneNumberController!.noController.text = '0876524131';
        phoneNumberController!.preRequestOTP();
        expect(phoneNumberController!.isRequestOTP, isFalse);
      });

      test('preRequestOTP failed', () {
        // phoneNumberController.noController.text = '0876524131';
        // phoneNumberController.countRequest.value = 5;
        // phoneNumberController.preRequestOTP(onFailed: () {});
        // expect(phoneNumberController.isRequestOTP, isFalse);
      });
    });

    group('Test handle request OTP', () {
      test('count request > 0', () {
        // phoneNumberController.countRequest.value = 1;
        // phoneNumberController.noController.text = '0876524131';
        // phoneNumberController.handleRequestOTP();
      });

      test('count request > 2', () {
        // phoneNumberController.countRequest.value = 3;
        // phoneNumberController.noController.text = '0876524131';
        // phoneNumberController.handleRequestOTP(popup: () {});
      });

      test('count request < 0', () {
        // phoneNumberController.isRequestOTP.value = false;
        // phoneNumberController.countRequest.value = -0;
        // phoneNumberController.noController.text = '0876524131';
        // phoneNumberController.handleRequestOTP(popup: () {});
      });
    });
  });
}
