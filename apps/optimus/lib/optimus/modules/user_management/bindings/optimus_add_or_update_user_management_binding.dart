import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/controllers/optimus_add_or_update_user_management_controller.dart';

class OptimusAddOrUpdateUserManagementBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<MerchantRepository>(() => MerchantRepository());
    Get.lazyPut<RoleManagementRepository>(() => RoleManagementRepository());
    Get.lazyPut<LoadingController>(() => LoadingController());

    Get.lazyPut<OptimusDrawerCustomController>(() => OptimusDrawerCustomController(),);
    Get.lazyPut<OptimusAddOrUpdateUserManagementController>(() => OptimusAddOrUpdateUserManagementController(
        dynamicLinkConfig: Get.find(),
        authRepository: Get.find(),
        deepLinkRepository: Get.find(),
        userRepository: Get.find(),
        merchantRepository: Get.find(),
        roleManagementRepository: Get.find(),
        loadingController: Get.find(),
        ),
    );
  }
}

