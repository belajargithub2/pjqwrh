import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_maintenance_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_maintenance_repository.dart';

class OptimusMaintenanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusMaintenanceRepository>(
      () => OptimusMaintenanceRepository(),
    );
    Get.lazyPut<OptimusDrawerCustomController>(
      () => OptimusDrawerCustomController(),
    );
    Get.lazyPut<OptimusMaintenanceController>(
      () => OptimusMaintenanceController(
        maintenanceRepo: Get.find(),
      ),
    );
  }
}
