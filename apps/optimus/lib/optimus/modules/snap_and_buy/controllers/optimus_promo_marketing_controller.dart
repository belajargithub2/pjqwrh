import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_permission_location_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_asset_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_calculate_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_create_snap_n_buy_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_tenor_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';

class OptimusPromoMarketingController extends GetxController {
  final OptimusSnapNBuyRepository snapNBuyRepository = Get.find<OptimusSnapNBuyRepository>();

  final formKey = GlobalKey<FormState>();
  final dpController = TextEditingController();
  final promoController = TextEditingController();
  final promoFocusNode = FocusNode();
  final Rx<TenorModel> tenorModel = TenorModel().obs;

  final inputDp = 0.obs;
  final minDp = 0.obs;
  final isShowErrorTenor = false.obs;
  final isShowUsageLimitCard = false.obs;
  final dpIsValid = true.obs;
  final isShowTextFieldDp = false.obs;
  final isShowTextFieldTenor = false.obs;
  final isShowButtonTenor = false.obs;
  final isShowShoppingSummaryMobile = false.obs;

  final RxList<TenorModel> listTenor = <TenorModel>[].obs;
  final indexTenor = Rx<int?>(null);
  final Rx<CalculateRequest> calculateRequest = CalculateRequest().obs;
  final Rx<CreateSnapNBuyResponse> createSnapNBuyResponse =
      CreateSnapNBuyResponse().obs;
  final Rx<Program> programSelected = Program().obs;
  static const String minimumMethodPercentage = 'percentage';
  static const String minimumMethodAmount = 'amount';
  final btnTenorIsEdit = false.obs;
  final btnSubmitIsValid = false.obs;
  final extraTextDp = ''.obs;
  final extraTextDpIsRedColor = false.obs;

  final snapAndBuyWebController = Get.find<OptimusSnapAndBuyBaseController>();
  final submissionSectionController = Get.find<OptimusSubmissionSectionController>();
  final _permissionLocController = Get.find<OptimusPermissionLocationController>();
  @override
  void onInit() async {
    DeasySizeConfigUtils().init(context: Get.context);
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void submit() async {
    if (btnSubmitIsValid.value) {
      snapAndBuyWebController.turnOnLoading();
      await _permissionLocController.postApiHistoryLogin().then((_) async {
        await createSnapAndBuy();
      });
      snapAndBuyWebController.turnOffLoading();
    }
  }

  CalculateRequest getCalculateRequest() {
    var customer = snapAndBuyWebController
        .listPromoMarketingResponse.value.data!.customerStatus!;
    calculateRequest.value.programId = programSelected.value.programId;
    calculateRequest.value.customerId = customer.customerId;
    calculateRequest.value.dpAmount = inputDp.value;
    calculateRequest.value.totalOtr =
        submissionSectionController.realPrice.value;
    calculateRequest.value.insuranceShippingFee = 0;
    calculateRequest.value.shippingFee = 0;
    return calculateRequest.value;
  }

  submitTenor() async {
    if (dpIsValid.isFalse) {
      return;
    }

    if (btnTenorIsEdit.isFalse) {
      calculateInstallment();
    } else {
      editTenor();
    }
    snapAndBuyWebController.hiddenSubsection();
    dpIsValid.value = checkValidDp();
  }

  calculateInstallment() async {
    showLoading();
    AnalyticConfig().sendEventStart("SNB_Customer_Status");
    listTenor.clear();
    indexTenor.value = null;
    isShowErrorTenor.value = false;
    await snapNBuyRepository
        .postApiCalculateInstallment(
            Get.context, getCalculateRequest().toJson(), "SNB_Installment")
        .then((value) {
      hideLoading();
      if (value.data!.isNotEmpty) {
        btnTenorIsEdit.toggle();

        value.data!.forEach((element) {
          listTenor.add(TenorModel(
            status: false,
            firstInstallment: element.firstInstallment,
            installmentAmount: element.installmentAmount,
            insuranceFee: element.insuranceFee,
            rate: element.rate,
            tenor: element.tenor,
            tenorLimit: element.tenorLimit,
            adminFee: element.adminFee,
            totalPaymentAmount: element.totalPaymentAmount,
            payToDealerAmount: element.payToDealerAmount,
            totalOtr: element.totalOtr,
            af: element.af,
            ntf: element.ntf,
            subsidyDealer: element.subsidyDealer,
            subsidyAdminDealer: element.subsidyAdminDealer,
            subsidyRateDealer: element.subsidyRateDealer,
            productId: element.productId,
            productOfferingId: element.productOfferingId,
            isAdminAsLoan: element.isAdminAsLoan,
            sessionId: element.sessionId,
          ));
        });
      }
    }).catchError((_) {
      hideLoading();
      AnalyticConfig().sendEventFailed("SNB_Installment");
    });
  }

  Future<void> createSnapAndBuy() async {
    await snapNBuyRepository
        .postApiCreateOrderSnapNBuy(
            Get.context,
            getSnbRequest(calculateRequest.value,
                    submissionSectionController.assetModel.value)
                .toJson(),
            "SNB_Create_Order")
        .then((response) async {
      AnalyticConfig().sendEventSuccess("SNB_Create_Order");
      createSnapNBuyResponse.value = response;
      snapAndBuyWebController.goToQrCodeSection();
      return response;
    }).catchError((_) async {
      snapAndBuyWebController.turnOffLoading();
      AnalyticConfig().sendEventFailed("SNB_Create_Order");
    });
  }

  CreateSnapNBuyRequest getSnbRequest(
      CalculateRequest product, AssetData assetData) {
    var application = Application(
      adminFee: tenorModel.value.adminFee,
      af: tenorModel.value.af,
      aoId: "NONE",
      firstInstallment: tenorModel.value.firstInstallment,
      installmentAmount: tenorModel.value.installmentAmount,
      insuranceFee: tenorModel.value.insuranceFee,
      isAdminAsLoan: tenorModel.value.isAdminAsLoan,
      miNumber: programSelected.value.miNumber,
      ntf: tenorModel.value.ntf,
      payToDealerAmount: tenorModel.value.payToDealerAmount,
      productId: tenorModel.value.productId,
      productOfferingId: tenorModel.value.productOfferingId,
      rate: tenorModel.value.rate,
      sessionId: tenorModel.value.sessionId,
      subsidiDealer: tenorModel.value.subsidyDealer,
      tenor: tenorModel.value.tenor,
      tenorLimit: tenorModel.value.tenorLimit,
      totalOtr: tenorModel.value.totalOtr,
      totalPayment: tenorModel.value.totalPaymentAmount,
      programId: programSelected.value.programId,
    );

    var assets = [
      Asset(
          assetCode: assetData.assetCode,
          assetType: assetData.assetType,
          categoryCode: assetData.categoryCode,
          categoryName: assetData.categoryName,
          discountAmount: 0,
          dpAmount: inputDp.value,
          insuranceAmount: 0,
          itemDescription: assetData.assetName,
          otr: submissionSectionController.realPrice.value,
          productId: tenorModel.value.productId,
          quantity: 1)
    ];

    return CreateSnapNBuyRequest(
      application: application,
      assets: assets,
      prospectId: snapAndBuyWebController.prospectId.value,
      mobilePhone: submissionSectionController.phoneNumberController.text,
      shippingCost: 0,
    );
  }

  void onTapTenor(int index) {
    listTenor.forEach((element) {
      element.status = false;
    });
    tenorModel.value = listTenor[index];
    listTenor[index].status = true;
    isShowErrorTenor(false);
    if (indexTenor.value == index) {
      indexTenor(-1);
      btnSubmitIsValid(false);
    } else {
      indexTenor(index);
      btnSubmitIsValid(true);
    }
    checkShoppingSummaryMobile(isShow: true);

    if (!DeasySizeConfigUtils.isMobile) {
      snapAndBuyWebController.activeSubSection.value = SUB_SECTION.USAGE_LIMIT_SUB_SECTION;
      isShowUsageLimitCard(true);
    }
  }

  void onChangePromo(Program result) {
    programSelected.value = result;
    promoController.text = result.programName!;
    if (snapAndBuyWebController.isShowDp.isTrue) {
      isShowTextFieldDp.value = true;
      if (result.minimumDpMethod!
          .isContainIgnoreCase(minimumMethodPercentage)) {
        minDp.value = (submissionSectionController.realPrice.value *
                result.minimumDpPercentage!) ~/
            100;
      } else {
        minDp.value = result.minimumDpAmount!;
      }
    }
    cleanUpPromo();
  }

  void editTenor() {
    inputDp.value = 0;
    dpController.clear();
    btnTenorIsEdit.toggle();
    listTenor.clear();
    btnSubmitIsValid.value = false;
    isShowErrorTenor.value = false;
    checkShoppingSummaryMobile(isShow: false);
  }

  void cleanUpTenor() {
    inputDp.value = 0;
    dpController.clear();
    btnTenorIsEdit.toggle();
    listTenor.clear();
    btnSubmitIsValid.value = false;
    isShowErrorTenor.value = false;
    programSelected.value = Program();
    promoController.clear();
    checkShoppingSummaryMobile(isShow: false);
  }

  void cleanUpPromo() {
    isShowButtonTenor.value = true;
    isShowErrorTenor.value = false;
    btnTenorIsEdit.value = false;
    btnSubmitIsValid.value = false;
    inputDp.value = 0;
    dpController.clear();
    listTenor.clear();
    dpIsValid.value = checkValidDp();
    snapAndBuyWebController.hiddenSubsection();
    checkShoppingSummaryMobile(isShow: false);
    refreshExtraDp();
  }

  Future<List<Program>> filterListPromo(String filter) async {
    List<Program> list = [];
    for (var item in snapAndBuyWebController.responseListProgram) {
      if (item.programName!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  selectPromoValidation(String value) {
    if (value.isEmpty) {
      return "${ValidationConstant.emptyPromo}";
    }
    return null;
  }

  Future<void> refreshProspectId() async {
    await snapAndBuyWebController.generateProspectId();
  }

  onChangePriceProduct(String value) {
    inputDp.value = 0;

    if (value.isNotEmpty) {
      inputDp.value = int.parse(value.toString());
      value = value.toString().toCurrency();
      dpController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );

      dpIsValid.value = checkValidDp();
    }
    refreshExtraDp();
  }

  void checkShoppingSummaryMobile({bool? isShow}) {
    if (isShow.isBlank!) {
      return;
    }

    if (DeasySizeConfigUtils.isMobile) {
      isShowShoppingSummaryMobile.value = isShow!;
    }
  }

  bool checkValidDp() {
    if (snapAndBuyWebController.isShowDp.isTrue) {
      if (inputDp.value >= submissionSectionController.realPrice.value) {
        return false;
      } else if (inputDp.value < minDp.value && inputDp.value != 0) {
        return false;
      } else if (minDp.value != 0 && inputDp.value == 0) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  bool getExtraColorDp(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      if (inputDp.value <= submissionSectionController.realPrice.value &&
          inputDp.value >= minDp.value) {
        return false;
      } else {
        return true;
      }
    }
  }

  void refreshExtraDp() {
    if (inputDp.value >= submissionSectionController.realPrice.value) {
      extraTextDp.value = ContentConstant.dpShouldBeSmallerThanProductPrice;
      extraTextDpIsRedColor.value = true;
      btnSubmitIsValid.value = false;
    } else if (inputDp.value < minDp.value && inputDp.value != 0) {
      extraTextDp.value = '${ContentConstant.minDp} ${minDp.toString().toCurrency()}';
      extraTextDpIsRedColor.value = true;
      btnSubmitIsValid.value = false;
    } else {
      extraTextDp.value = '${ContentConstant.minDp} ${minDp.toString().toCurrency()}';
      extraTextDpIsRedColor.value = false;
    }
  }

  void backToSubmission() {
    cleanUpTenor();
    cleanUpPromo();
    submissionSectionController.goToSubmissionSection();
  }

  void showLoading() {
    snapAndBuyWebController.turnOnLoading();
  }

  void hideLoading() {
    snapAndBuyWebController.turnOffLoading();
  }
}
