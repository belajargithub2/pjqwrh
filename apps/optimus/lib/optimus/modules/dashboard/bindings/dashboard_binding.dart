import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_transaction_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/merchant_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/statistic_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/table_transaction_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';
import 'package:kreditplus_deasy_website/core/utils/url_dart_html_wrapper.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/transaction_repository.dart';

class DashboardBinding extends Bindings {
  DashboardRepository _dashboardRepository = DashboardRepository();
  MerchantRepository _merchantRepository = MerchantRepository();
  TransactionRepository _transactionRepository = TransactionRepository();

  @override
  void dependencies() {
    Get.lazyPut<DeasyDialogWrapper>(() => DeasyDialogWrapper());
    Get.lazyPut<UrlDartHtmlWrapper>(() => UrlDartHtmlWrapper());
    Get.lazyPut<DashboardTransactionController>(() =>
        DashboardTransactionController(
            dashboardRepository: _dashboardRepository));
    Get.lazyPut<DashboardMainController>(() => DashboardMainController(
        dashboardRepository: _dashboardRepository,
        transactionRepository: _transactionRepository));
    Get.lazyPut<StatisticController>(
        () => StatisticController(dashboardRepository: _dashboardRepository));
    Get.lazyPut<MerchantController>(
        () => MerchantController(merchantRepository: _merchantRepository));
    Get.lazyPut(() => TableTransactionController());
    Get.lazyPut<DeasyDeviceInfo>(() => DeasyDeviceInfo());
  }
}
