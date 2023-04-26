import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/account_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/change_password_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/delete_account_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/ecommerce_client_key_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/input_current_password_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/qr_refferal_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrRefferalController>(() => QrRefferalController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<SettingsRepository>(
        () => SettingsRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<ECommerceClientKeyRepository>(
        () => ECommerceClientKeyRepository());
    Get.lazyPut<IdentifierTransaksiRepository>(
        () => IdentifierTransaksiRepository());
    Get.lazyPut<RoleManagementRepository>(() => RoleManagementRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    Get.lazyPut<InputCurrentPasswordController>(
        () => InputCurrentPasswordController(
              userRepository: Get.find(),
            ));
    Get.lazyPut(() => DeleteAccountController(
        settingsRepository: Get.find(),
        userRepository: Get.find(),
        dynamicLinkConfig: Get.find(),
        deepLinkRepository: Get.find(),
        authRepository: Get.find()));
    Get.lazyPut(() => EcommerceClientKeyController());
  }
}
