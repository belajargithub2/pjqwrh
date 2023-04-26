import 'dart:typed_data';

import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:get/get.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_media_image_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_dialog.dart';

class OptimusShowQrCodeController extends GetxController {
  OptimusMediaImageRepository mediaImageRepository = Get.find<OptimusMediaImageRepository>();
  OptimusSnapNBuyRepository snapNBuyRepository = Get.find<OptimusSnapNBuyRepository>();

  final Rx<CreateSnapNBuyData?> data = CreateSnapNBuyData().obs;
  final tryRetryCreateSnb = 0.obs;
  final retryGenerateQrCount = 0.obs;
  final timeHasEnded = false.obs;
  final qrCodeTimer = 0.obs;
  final qrCodeUrl = ''.obs;
  final isLoading = false.obs;
  Rxn<Uint8List> listImage = Rxn<Uint8List>();

  OptimusSnapAndBuyBaseController snapAndBuyWebController =
      Get.find<OptimusSnapAndBuyBaseController>();
  OptimusPromoMarketingController promoMarketingController =
      Get.find<OptimusPromoMarketingController>();
  OptimusSubmissionSectionController submissionSectionController =
      Get.find<OptimusSubmissionSectionController>();

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
    await mediaImageRepository
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
