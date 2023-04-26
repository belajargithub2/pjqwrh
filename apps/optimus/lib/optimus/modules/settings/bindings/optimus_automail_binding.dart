import 'package:get/get.dart';
import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:kreditplus_deasy_website/core/utils/url_dart_html_wrapper.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_automail_repository.dart';

class OptimusAutomailBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => OptimusAutomailRepository());
    Get.lazyPut(() => DashboardRepository());

    Get.lazyPut(() => OptimusAutomailController(
        optimusAutomailRepository: Get.find(),
        dashboardRepository: Get.find()));
    Get.lazyPut<OptimusDrawerCustomController>(
      () => OptimusDrawerCustomController(),
    );
    Get.lazyPut<DeasyDialogWrapper>(
      () => DeasyDialogWrapper(),
    );

    Get.lazyPut<UrlDartHtmlWrapper>(() => UrlDartHtmlWrapper());
  }
}
