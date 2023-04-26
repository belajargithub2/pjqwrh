import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/controllers/bumblebee_notification_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/repositories/bumblebee_notification_repository.dart';

class BumblebeeNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeNotificationRepository());
    Get.lazyPut(
      () => BumblebeeNotificationController(
        notificationRepository: Get.find(),
      ),
    );
  }
}
