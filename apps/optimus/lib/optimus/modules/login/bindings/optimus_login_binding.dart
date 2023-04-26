import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:get/get.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_email_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_one_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/optimus_login_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';

class OptimusLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusSnapNBuyRepository>(() => OptimusSnapNBuyRepository());
    Get.lazyPut<OptimusMenuRoleRepository>(() => OptimusMenuRoleRepository());
    Get.lazyPut<OptimusLoginRepository>(() => OptimusLoginRepository());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut(() => UserRepository());
    Get.lazyPut<DeasyDeviceInfo>(() => DeasyDeviceInfo());
    Get.lazyPut(() => OptimusLoginDialog());
    Get.lazyPut(() => DeasyPocket());
    Get.lazyPut(() => LoginSnackbar());

    Get.lazyPut(() => OptimusLoginController(
        snapNBuyRepository: Get.find<OptimusSnapNBuyRepository>(),
        userRepository: Get.find()));

    Get.lazyPut(() => OptimusLoginEmailController(
          loginRepository: Get.find<OptimusLoginRepository>(),
          menuRoleRepository: Get.find<OptimusMenuRoleRepository>(),
        ));

    Get.lazyPut(() => OptimusLoginPhoneStepOneController(
          authRepository: Get.find(),
          deepLinkRepository: Get.find(),
          dynamicLinkConfig: Get.find(),
          loginRepository: Get.find(),
        ));

    Get.lazyPut(() => OptimusLoginPhoneStepTwoController(
          loginRepository: Get.find(),
          loginController: Get.find(),
          menuRoleRepository: Get.find(),
        ));
  }
}
