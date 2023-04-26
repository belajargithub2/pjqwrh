import 'dart:typed_data';

import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_media_image_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_dialog.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class BumblebeeShowQrCodeController extends GetxController {
  BumblebeeMediaImageRepository bumblebeeMediaImageRepository = Get.find<BumblebeeMediaImageRepository>();
  BumblebeeSnapNBuyRepository bumblebeeSnapNBuyRepository = Get.find<BumblebeeSnapNBuyRepository>();

  final Rx<CreateSnapNBuyData?> data = CreateSnapNBuyData().obs;
  final tryRetryCreateSnb = 0.obs;
  final retryGenerateQrCount = 0.obs;
  final timeHasEnded = false.obs;
  final qrCodeTimer = 0.obs;
  final qrCodeUrl = ''.obs;
  final isLoading = false.obs;
  Rxn<Uint8List> listImage = Rxn<Uint8List>();

  BumblebeeSnapAndBuyBaseController snapAndBuyWebController =
      Get.find<BumblebeeSnapAndBuyBaseController>();
  BumblebeePromoMarketingController promoMarketingController =
      Get.find<BumblebeePromoMarketingController>();
  BumblebeeSubmissionSectionController submissionSectionController =
      Get.find<BumblebeeSubmissionSectionController>();

  @override
  void onInit() async {
    retryGenerateQrCount.value =
        await DeasyPocket().getRetryGenerateQrCount();
    qrCodeTimer.value = await DeasyPocket().getQrCodeTimer();
    fetchImageFromQRCodeUrl(
        promoMarketingController.createSnapNBuyResponse.value);
    super.onInit();
  }

  void refreshQr() {
    timeHasEnded.value = false;
    tryRetryCreateSnb.value += 1;
    isLoading.value = true;
    if (tryRetryCreateSnb.value > retryGenerateQrCount.value) {
      isLoading.value = false;
      promoMarketingController.cleanUpPromo();
      promoMarketingController.cleanUpTenor();
      if (DeasySizeConfigUtils.isDesktopOrWeb) {
        tryRetryCreateSnb.value = 0;
        snapAndBuyWebController.isShowDialogLimitQrCode(true);
        submissionSectionController.goToSubmissionSection();
      } else {
        dialogScanIsExpired(onReorderSnb: () {
          tryRetryCreateSnb.value = 0;
          Get.back();
          submissionSectionController.goToSubmissionSection();
        }, onBackToDashboard: () {
          Get.back();
          Get.back();
        });
      }
    } else {
      data.value = CreateSnapNBuyData();
      promoMarketingController.refreshProspectId().then((value) {
        promoMarketingController.createSnapAndBuy().then((value) {
          fetchImageFromQRCodeUrl(
              promoMarketingController.createSnapNBuyResponse.value);
          isLoading.value = true;
        }).catchError((onError) {
          isLoading.value = false;
        });
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchImageFromQRCodeUrl(CreateSnapNBuyResponse responseCreateOrder) async {
    listImage.value = null;
    isLoading.value = true;
    await bumblebeeMediaImageRepository
        .getImagesUint8List(Get.context, responseCreateOrder.data!.qrCodeUrl)
        .then((response) {
      data.value = responseCreateOrder.data;
      if (responseCreateOrder.data!.expiredAt != null &&
          responseCreateOrder.data!.timeNow != null) {
        isLoading.value = false;
      }
      Uint8List? imageData = response;
      listImage.value = imageData;
    }).catchError((onError) {
      isLoading.value = false;
    });
  }

  void onEnd() {
    timeHasEnded.value = true;
  }

  void backToPromoMarketingSection() {
    snapAndBuyWebController.backToPromoMarketingSection();
    promoMarketingController.refreshProspectId();
  }
}
