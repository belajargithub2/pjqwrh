import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/bindings/bumblebee_login_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_landing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import '../../mocks/config/firebase_core_config_mock.dart';

class LoginRepositoryMock with Mock implements BumblebeeLoginRepository {}

class MenuRoleRepositoryMock with Mock implements MenuRoleRepository {}

class BumblebeeLoginPhoneControllerMock
    with Mock
    implements BumblebeeLoginPhoneController {}

class BumblebeeLoginOTPLandingControllerMock
    with Mock
    implements BumblebeeLoginOTPLandingController {}

void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();
  late BumblebeeLoginPhoneController phoneNumberController;
  late BumblebeeLoginOTPLandingController otpLandingController;

  // Dependencies Injection with mock repository
  BindingsBuilder binding = BindingsBuilder(() {
    BumblebeeLoginBinding().dependencies();
    Get.lazyReplace<BumblebeeLoginRepository>(
      () => LoginRepositoryMock(),
    );
    Get.lazyReplace<MenuRoleRepository>(
      () => MenuRoleRepositoryMock(),
    );
    Get.lazyReplace<BumblebeeLoginPhoneController>(
      () => BumblebeeLoginPhoneControllerMock(),
    );
    Get.lazyReplace<BumblebeeLoginOTPLandingController>(
      () => BumblebeeLoginOTPLandingControllerMock(),
    );
  });

  setUpAll(() {
    // Test mode true when using Navigation in controller that tested
    Get.testMode = true;
    binding.builder();
    phoneNumberController = Get.find<BumblebeeLoginPhoneController>();
    otpLandingController = Get.find<BumblebeeLoginOTPLandingController>();
  });

  tearDown(() {
    Get.delete<BumblebeeLoginPhoneController>();
    Get.delete<BumblebeeLoginOTPLandingControllerMock>();
  });

  group('Test Initialize BumblebeeLoginOtpLandingController', () {
    test("Test onInit Controller", () {
      expect(
        otpLandingController,
        isInstanceOf<BumblebeeLoginOTPLandingController>(),
      );

      expect(phoneNumberController.initialized, isTrue);
      expect(otpLandingController.initialized, isTrue);

      bool loginPhone = Get.isRegistered<BumblebeeLoginPhoneController>();
      expect(loginPhone, true);

      bool loginOtp = Get.isRegistered<BumblebeeLoginOTPLandingController>();
      expect(loginOtp, true);
    });
  });

  group('Test requestCall OTP', () {
    test('requestCallOtp success', () {
      phoneNumberController.noController.text = '089605874252';
      otpLandingController.requestCallOtp();
      expect(phoneNumberController.isRequestOTP, isFalse);
    });

    test('requestCallOtp failed', () async {
      phoneNumberController.noController.text = '081234567890';
      await otpLandingController.requestCallOtp();
      bool? isOpen = Get.isBottomSheetOpen;
      expect(isOpen, isTrue);
    });
  });
}
