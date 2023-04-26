import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/controllers/optimus_email_verification_controller.dart';

class OptimusEmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());

    Get.lazyPut<LoadingController>(() => LoadingController());

    Get.lazyPut(() => OptimusEmailVerificationController(
      authRepository: Get.find(),
      deepLinkRepository: Get.find(),
      dynamicLinkConfig: Get.find(),
      loadingController: Get.find()
    ));
  }
}