import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_calculate_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_request.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_prospect_id_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

enum SECTION {
  PROMO_MARKETING_SECTION,
  SHOW_QR_CODE_SECTION,
  SUBMISSION_SECTION
}

enum SUB_SECTION { NULL_SUB_SECTION, USAGE_LIMIT_SUB_SECTION, HOW_TO_SCAN }

class BumblebeeSnapAndBuyBaseController extends GetxController {
  final bumblebeeSnapNBuyRepository = Get.find<BumblebeeSnapNBuyRepository>();

  final Rx<CalculateRequest> calculateRequest = CalculateRequest().obs;
  final Rx<ListPromoMarketingResponse> listPromoMarketingResponse =
      ListPromoMarketingResponse().obs;

  final stepIndex = 0.obs;
  final prospectId = ''.obs;
  final Rx<SUB_SECTION> activeSubSection = SUB_SECTION.NULL_SUB_SECTION.obs;
  final Rx<SECTION> activeMainSection = SECTION.SUBMISSION_SECTION.obs;
  final isShowDialogPhoneNumberNotFound = false.obs;
  final isShowDialogNullDataInstallment = false.obs;
  final isShowDialogNeedVerification = false.obs;
  final isShowDialogLimitQrCode = false.obs;
  final isShowDialogInsufficientLimit = false.obs;
  final isShowDialogLimitCategory = false.obs;
  final RxList<Program> responseListProgram = <Program>[].obs;
  ScrollController? scrollController;
  final isShowDp = false.obs;
  final isLoading = false.obs;

  static const String STATUS_NEW = "NEW";
  static const String STATUS_VERIFY = "VERIFY";

  static const String PROMO_MARKETING_SECTION = "PROMO_MARKETING_SECTION";
  static const String SHOW_QR_CODE_SECTION = "SHOW_QR_CODE_SECTION";
  static const String SUBMISSION_SECTION = "SUBMISSION_SECTION";
  static const String USAGE_LIMIT_SUB_SECTION = "USAGE_LIMIT_SUB_SECTION";

  @override
  void onInit() async {
    DeasySizeConfigUtils().init();
    scrollController = ScrollController();
    isShowDp.value = await DeasyPocket().getShowDp();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  submitSubmission(ListPromoMarketingRequest listPromoMarketingRequest) async {
    await getListPromoMarketing(listPromoMarketingRequest);
  }

  getListPromoMarketing(
      ListPromoMarketingRequest listPromoMarketingRequest) async {
    await bumblebeeSnapNBuyRepository
        .getListPromoMarketing(Get.context, listPromoMarketingRequest.toJson())
        .then((value) {
      var customerStatus = value.data!.customerStatus!;

      if (customerStatus.isRegisteredKreditmu == false &&
          customerStatus.customerRegisterStatus == STATUS_NEW) {
        isShowDialogPhoneNumberNotFound(true);
        turnOffLoading();
        return;
      }

      if (customerStatus.customerRegisterStatus != STATUS_NEW &&
          customerStatus.limitStatus != STATUS_VERIFY &&
          customerStatus.dataVerification == false &&
          customerStatus.faceVerification == false) {
        isShowDialogNeedVerification(true);
        turnOffLoading();
        return;
      }

      if(customerStatus.limitCategory == LimitType.BLUE){
        isShowDialogLimitCategory(true);
        turnOffLoading();
        return;
      }

      generateProspectId();
      responseListProgram.value = value.data!.programs!;
      listPromoMarketingResponse.value = value;
      turnOffLoading();
      activeMainSection.value = SECTION.PROMO_MARKETING_SECTION;
      stepIndex(1);
    }).catchError((e) {
      turnOffLoading();
    });
  }

  void backToPromoMarketingSection() {
    stepIndex.value = 1;
    activeMainSection.value = SECTION.PROMO_MARKETING_SECTION;
    activeSubSection.value = SUB_SECTION.NULL_SUB_SECTION;
  }

  void goToQrCodeSection() {
    stepIndex.value = 2;
    activeMainSection.value = SECTION.SHOW_QR_CODE_SECTION;
    activeSubSection.value = SUB_SECTION.HOW_TO_SCAN;
  }

  void goToSubmissionSection() {
    stepIndex(0);
    activeMainSection(SECTION.SUBMISSION_SECTION);
    activeSubSection(SUB_SECTION.NULL_SUB_SECTION);
  }

  void gotoDashboard() {
    Get.back();
    Get.back();
  }

  void turnOnLoading() {
    isLoading.value = true;
  }

  generateProspectId() async {
    ProspectIdResponse prospectIdResponse =
        await bumblebeeSnapNBuyRepository.generateProspectId(Get.context, null);
    prospectId.value = prospectIdResponse.data!.prospectId!;
  }

  void turnOffLoading() {
    isLoading.value = false;
  }

  void hiddenSubsection() {
    activeSubSection.value = SUB_SECTION.NULL_SUB_SECTION;
  }
}
