import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_add_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';

class BumblebeeMerchantUserManagementBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<RoleManagementRepository>(() => RoleManagementRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut(() => BumblebeeMerchantUserManagementController(
      authRepository: Get.find(),
      deepLinkRepository: Get.find(),
      dynamicLinkConfig: Get.find(),
      roleManagementRepository: Get.find(),
      userRepository: Get.find()
    ));
    Get.lazyPut(() => BumblebeeAddMerchantUserManagementController(
      userRepository: Get.find()
    ));
  }
}