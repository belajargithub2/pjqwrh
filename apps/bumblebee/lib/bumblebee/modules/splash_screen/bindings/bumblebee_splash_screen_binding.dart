import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/controllers/bumblebee_splash_screen_controller.dart';

class BumblebeeSplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeSplashScreenController());
  }
}
