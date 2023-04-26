
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';


class OptimusRoleManagementBinding implements Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => OptimusRoleManagementController());
  Get.lazyPut<OptimusDrawerCustomController>(
    () => OptimusDrawerCustomController(),
  );
  }

}