import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_add_or_update_controller.dart';

class OptimusRoleManagementAddOrUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptimusRoleManagementAddOrUpdateController());
  }
}
