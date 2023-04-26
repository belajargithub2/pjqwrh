import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/controllers/bumblebee_forgot_password_controller.dart';

class BumblebeeForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<BumblebeeForgotPasswordController>(() => BumblebeeForgotPasswordController());
    Get.lazyPut<AnalyticConfig>(() => AnalyticConfig());
  }
}
