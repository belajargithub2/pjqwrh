import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/controllers/optimus_add_or_update_source_application_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/controllers/optimus_source_application_controller.dart';

class OptimusSourceApplicationBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => OptimusDrawerCustomController());
    Get.lazyPut(() => OptimusSourceApplicationController());
    Get.lazyPut(() => OptimusAddOrUpdateSourceApplicationController());
  }
}