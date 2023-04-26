import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/repositories/bumblebee_login_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_show_qr_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_asset_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_media_image_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_permission_location_controller.dart';

class BumblebeeSnapAndBuyBaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BumblebeeSnapNBuyRepository>(
        () => BumblebeeSnapNBuyRepository());
    Get.lazyPut<BumblebeeAssetRepository>(() => BumblebeeAssetRepository());
    Get.lazyPut<BumblebeeMediaImageRepository>(
        () => BumblebeeMediaImageRepository());
    Get.lazyPut<BumblebeeLoginRepository>(() => BumblebeeLoginRepository());
    Get.lazyPut<BumblebeeSnapAndBuyBaseController>(
        () => BumblebeeSnapAndBuyBaseController());
    Get.lazyPut<BumblebeeSubmissionSectionController>(
        () => BumblebeeSubmissionSectionController());
    Get.lazyPut<BumblebeeShowQrCodeController>(
        () => BumblebeeShowQrCodeController());
    Get.lazyPut<BumblebeePromoMarketingController>(
        () => BumblebeePromoMarketingController());
    Get.lazyPut<BumblebeePermissionLocationController>(
        () => BumblebeePermissionLocationController());
  }
}
