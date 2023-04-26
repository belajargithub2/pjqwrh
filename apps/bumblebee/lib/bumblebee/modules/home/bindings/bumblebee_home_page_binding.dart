import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';

class BumblebeeHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeHomePageController());
  }
}
