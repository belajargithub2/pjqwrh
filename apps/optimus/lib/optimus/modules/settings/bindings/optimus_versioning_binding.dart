import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_versioning_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_versioning_repository.dart';

class OptimusVersioningBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusVersioningRepository>(
      () => OptimusVersioningRepository(),
    );
    Get.lazyPut<OptimusDrawerCustomController>(
      () => OptimusDrawerCustomController(),
    );
    Get.lazyPut<OptimusVersioningController>(
      () => OptimusVersioningController(
        versioningRepo: Get.find(),
      ),
    );
  }
}
