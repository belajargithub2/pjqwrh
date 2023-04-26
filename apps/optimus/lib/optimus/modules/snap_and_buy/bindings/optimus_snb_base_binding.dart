import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/repositories/optimus_login_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_permission_location_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_show_qr_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_asset_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_media_image_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';

class OptimusSnapAndBuyBaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusSnapNBuyRepository>(() => OptimusSnapNBuyRepository());
    Get.lazyPut<OptimusAssetRepository>(() => OptimusAssetRepository());
    Get.lazyPut<OptimusMediaImageRepository>(
        () => OptimusMediaImageRepository());
    Get.lazyPut<OptimusLoginRepository>(() => OptimusLoginRepository());

    Get.lazyPut<OptimusDrawerCustomController>(
        () => OptimusDrawerCustomController());
    Get.lazyPut<OptimusSnapAndBuyBaseController>(
        () => OptimusSnapAndBuyBaseController());
    Get.lazyPut<OptimusSubmissionSectionController>(
        () => OptimusSubmissionSectionController());
    Get.lazyPut<OptimusShowQrCodeController>(
        () => OptimusShowQrCodeController());
    Get.lazyPut<OptimusPromoMarketingController>(
        () => OptimusPromoMarketingController());
    Get.lazyPut<OptimusPermissionLocationController>(
        () => OptimusPermissionLocationController());
  }
}
