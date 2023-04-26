import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/controllers/merchant_add_user_management_controller.dart';
import 'package:deasy_repository/deasy_repository.dart' as dr;
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/controllers/merchant_user_management_controller.dart';

class MerchantUserManagementAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<dr.UserRepository>(() => dr.UserRepository());
    Get.lazyPut(() => MerchantAddUserManagementController(
          userRepository: Get.find(),
        ));
    Get.lazyPut<dr.AuthRepository>(() => dr.AuthRepository());
    Get.lazyPut<dr.RoleManagementRepository>(
        () => dr.RoleManagementRepository());
    Get.lazyPut<dr.RoleManagementRepository>(
        () => dr.RoleManagementRepository());
    Get.lazyPut<dr.DeepLinkRepository>(() => dr.DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());


    Get.lazyPut(() => MerchantUserManagementController(
        authRepository: Get.find(),
        deepLinkRepository: Get.find(),
        dynamicLinkConfig: Get.find(),
        roleManagementRepository: Get.find(),
        userRepository: Get.find()));
    Get.lazyPut(() => OptimusDrawerCustomController());
  }
}
