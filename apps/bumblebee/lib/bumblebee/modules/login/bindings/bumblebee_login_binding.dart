import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_email_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_landing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/widgets/bumblebee_login_dialog.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';

class BumblebeeLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<BumblebeeLoginDialog>(() => BumblebeeLoginDialog());
    
    Get.lazyPut<BumblebeeSnapNBuyRepository>(
      () => BumblebeeSnapNBuyRepository(),
    );
    Get.lazyPut<MenuRoleRepository>(
      () => MenuRoleRepository(),
    );
    Get.lazyPut<BumblebeeLoginRepository>(
      () => BumblebeeLoginRepository(),
    );
    Get.lazyPut<UserRepository>(
      () => UserRepository(),
    );
    Get.lazyPut<DeasyDeviceInfo>(
      () => DeasyDeviceInfo(),
    );

    Get.lazyPut(() => BumblebeeLoginController(
        snapNBuyRepository: Get.find<BumblebeeSnapNBuyRepository>(),
        userRepository: Get.find<UserRepository>()));

    Get.lazyPut(() => BumblebeeLoginEmailController(
          loginRepository: Get.find<BumblebeeLoginRepository>(),
          menuRoleRepository: Get.find<MenuRoleRepository>(),
        ));

    Get.lazyPut(() => BumblebeeLoginPhoneController(
          authRepository: Get.find<AuthRepository>(),
          deepLinkRepository: Get.find<DeepLinkRepository>(),
          dynamicLinkConfig: Get.find<DynamicLinkConfig>(),
          loginRepository: Get.find<BumblebeeLoginRepository>(),
          menuRoleRepository: Get.find<MenuRoleRepository>(),
        ));

    Get.lazyPut(
      () => BumblebeeLoginOTPController(
        phoneNumberController: Get.find<BumblebeeLoginPhoneController>(),
      ),
    );

    Get.lazyPut(() => BumblebeeLoginOTPLandingController());
  }
}
