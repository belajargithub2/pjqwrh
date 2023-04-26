import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/controllers/optimus_forgot_password_controller.dart';

class OptimusForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<OptimusForgotPasswordController>(() => OptimusForgotPasswordController());
    Get.lazyPut<AnalyticConfig>(() => AnalyticConfig());
  }
}
