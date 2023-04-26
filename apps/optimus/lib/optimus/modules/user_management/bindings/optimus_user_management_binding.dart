import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/controllers/optimus_user_management_controller.dart';

class OptimusUserManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoleManagementRepository());
    Get.lazyPut(() => UserRepository());

    Get.lazyPut<OptimusDrawerCustomController>(
      () => OptimusDrawerCustomController(),
    );
    Get.lazyPut<OptimusUserManagementController>(
      () => OptimusUserManagementController(
        userRepository: Get.find(),
        roleManagementRepository: Get.find(),
      ),
    );
  }
}
