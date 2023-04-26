import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/controllers/optimus_callback_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/controllers/optimus_callback_detail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/repositories/optimus_callback_repository.dart';

class OptimusCallbackBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<OptimusCallbackController>(() => OptimusCallbackController());
    Get.lazyPut<OptimusCallbackRepository>(() => OptimusCallbackRepository());
    Get.lazyPut<OptimusCallbackDetailController>(() => OptimusCallbackDetailController());
    Get.lazyPut<OptimusDrawerCustomController>(() => OptimusDrawerCustomController());
  }
}