import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/controllers/optimus_new_password_controller.dart';

class OptimusNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusNewPasswordController>(() => OptimusNewPasswordController());
  }
}
