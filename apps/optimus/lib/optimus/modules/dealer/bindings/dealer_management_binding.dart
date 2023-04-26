import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/controllers/dealer_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/controllers/edit_dealer_management_controller.dart';

class DealerManagementBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => DealerManagementController());
    Get.lazyPut(() => EditDealerMangementController());
    Get.lazyPut(() => OptimusDrawerCustomController());
  }
}