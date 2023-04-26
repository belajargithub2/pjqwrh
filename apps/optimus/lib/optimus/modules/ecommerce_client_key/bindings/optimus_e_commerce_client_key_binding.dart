import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/controllers/optimus_e_commerce_client_key_controller.dart';


class OptimusECommerceClientKeyWebBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(OptimusECommerceClientKeyWebController());
  }
}

