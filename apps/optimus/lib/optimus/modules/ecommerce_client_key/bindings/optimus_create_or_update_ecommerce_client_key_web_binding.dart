import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/controllers/optimus_create_or_update_ecommerce_client_key_web_controller.dart';

class OptimusCreateOrUpdateEcommerceClientKeyWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(() => LoadingController());
    Get.lazyPut<OptimusDrawerCustomController>(() => OptimusDrawerCustomController());
    Get.put(OptimusCreateOUpdateEcommerceClientKeyWebController());
  }
}
