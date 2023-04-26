import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/controllers/bumblebee_email_verification_controller.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';

class BumblebeeEmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());

    Get.lazyPut(() => BumblebeeEmailVerificationController(
      authRepository: Get.find(),
      deepLinkRepository: Get.find(),
      dynamicLinkConfig: Get.find()
    ));
  }
}