import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_cancel_request_controller.dart';

class DashboardCancelRequestWebBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => DashboardCancelRequestController());
  }
}