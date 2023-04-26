import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';

class OptimusDrawerCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OptimusDrawerCustomController(), permanent: true);
  }
}
