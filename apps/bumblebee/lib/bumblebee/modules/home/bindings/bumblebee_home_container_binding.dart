import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/controller/draft_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_daily_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_container_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_monthly_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_yearly_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_mobile_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/repositories/bumblebee_dashboard_report_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/repositories/bumblebee_notification_repository.dart';

class BumblebeeHomeContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeHomeContainerController());

    Get.lazyPut(() => BumblebeeDashboardReportRepository());
    Get.lazyPut(() => BumblebeeUploadPhotoRepository());
    Get.lazyPut(() => BumblebeeNotificationRepository());
    Get.lazyPut(() => SettingsRepository());
    Get.lazyPut(() => RoleManagementRepository());
    Get.lazyPut(() => BumblebeeLoginRepository());
    Get.lazyPut(() => BumblebeeDraftRepository());

    Get.lazyPut(() => BumblebeeHomePageController(
          homeContainerController: Get.find<BumblebeeHomeContainerController>(),
        ));

    Get.lazyPut(() => BumblebeeDailyPageController(
          homePageController: Get.find<BumblebeeHomePageController>(),
        ));

    Get.lazyPut(() => BumblebeeMonthlyPageController(
          homePageController: Get.find<BumblebeeHomePageController>(),
        ));

    Get.lazyPut(() => BumblebeeYearlyPageController(
          homePageController: Get.find<BumblebeeHomePageController>(),
        ));

    Get.lazyPut(() => BumblebeeTransactionMobileController());
    Get.lazyPut(() => DraftController(
          draftRepository: Get.find<BumblebeeDraftRepository>(),
          homeContainerController: Get.find<BumblebeeHomeContainerController>()
        ));
  }
}
