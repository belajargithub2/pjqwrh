import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/controllers/bumblebee_on_boarding_controller.dart';

class BumblebeeOnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeOnBoardingController());
  }
}
