import 'dart:async';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_asset_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_request.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_asset_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeSubmissionSectionController extends GetxController {
  final bumblebeeAssetRepository = Get.find<BumblebeeAssetRepository>();
  final bumblebeeSnapAndBuyBaseController = Get.find<BumblebeeSnapAndBuyBaseController>();

  Timer? debounce;
  ScrollController? scrollControllerProductOffering;
  final formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;
  final searchControllerAsset = TextEditingController();

  final listviewController = ScrollController();
  final priceController = TextEditingController();
  final priceFocusNode = FocusNode();
  final dpFocusNode = FocusNode();
  final phoneNumberController = TextEditingController();
  final phoneNumberFocusNode = FocusNode();
  final productController = TextEditingController();
  final productFocusNode = FocusNode();
  final Rx<AssetData> assetModel = AssetData().obs;
  final Rx<ListPromoMarketingRequest> listPromoMarketingRequest = ListPromoMarketingRequest().obs;
  final realPrice = 0.obs;
  final minDP = 0.obs;
  final countAsset = 0.obs;
  final nextPageAsset = 1.obs;
  final listAssetVisible = false.obs;
  final isLoadMore = false.obs;
  final isFirstAsset = true.obs;
  final RxList<AssetData> assetDropdownList = <AssetData>[].obs;

  @override
  void onInit() async {
    fetchApiAsset();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onTapAsset(AssetData item) {
    listAssetVisible.value = false;
    assetModel.value = item;
    productController.text = item.assetName!;
  }

  onSearchTextChangedAsset(String text) {
    fetchApiAsset(assetName: text);
  }

  Future<bool> loadMore() async {
    if (isLoadMore.isTrue) {
      await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
      if (searchControllerAsset.text.isNotEmpty) {
        fetchApiAsset(
            page: nextPageAsset.value, assetName: searchControllerAsset.text);
      } else {
        fetchApiAsset(page: nextPageAsset.value);
      }
      return true;
    } else {
      return false;
    }
  }

  void onProductTap() {
    listAssetVisible.toggle();

    if (listAssetVisible.isTrue && listviewController.hasClients) {
      listviewController.animateTo(
          listviewController.position.maxScrollExtent + 325,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500));
    }
  }

  void checkValidation() {
    autoValidate.value = AutovalidateMode.always;
    if (formKey.currentState!.validate()) {
      bumblebeeSnapAndBuyBaseController.turnOnLoading();
      listPromoMarketingRequest.value.assets = [getAsset()];
      listPromoMarketingRequest.value.mobilePhone = phoneNumberController.text;
      bumblebeeSnapAndBuyBaseController.submitSubmission(listPromoMarketingRequest.value);
    }
  }

  Asset getAsset() {
    return Asset(
      assetNumber: 1,
      assetCode: assetModel.value.assetCode,
      categoryCode: assetModel.value.categoryCode,
      categoryName: assetModel.value.categoryName,
      otr: realPrice.value,
    );
  }

  fetchApiAsset({int page = 1, String assetName = ""}) async {
    var requestBody = <String, dynamic>{
      "limit": 10,
      "page": page,
      if (assetName.isNotEmpty) "name": assetName
    };

    await bumblebeeAssetRepository
        .postApiMasterAsset(Get.context, requestBody, "SNB_Assets")
        .then((value) {
      AnalyticConfig().sendEventSuccess("SNB_Assets");
      if (value.data!.length > 0) {
        nextPageAsset.value++;
        countAsset.value = value.pageInfo!.totalRecord!;
        assetDropdownList.addAll(value.data!);
        assetDropdownList.toSet().toList();
        assetDropdownList.refresh();
        isLoadMore.value = true;
      } else {
        isLoadMore.value = false;
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("SNB_Assets");
      nextPageAsset.value = 1;
      isLoadMore.value = false;
      assetDropdownList.clear();
    });
  }

  searchAsset(String value) async {
    assetDropdownList.clear();
    assetDropdownList.refresh();
    fetchApiAsset(assetName: value);
  }

  Future<void> refreshAsset() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    assetDropdownList.clear();
    if (searchControllerAsset.text.isEmpty) {
      fetchApiAsset();
    } else {
      fetchApiAsset(assetName: searchControllerAsset.text);
    }
  }

  phoneNumberValidation(String value) {
    if (value.length < 9 || value.length > 14) {
      return "${ContentConstant.phoneValidation}";
    } else {
      return null;
    }
  }

  priceGoodValidation(String value) {
    if (value.isEmpty) {
      return "${ContentConstant.correctPriceGood}";
    } else if (value.length > 4) {
      String result = value.substring(3).toCleanString();
      if (int.parse(result) < 1500000) {
        return "${ContentConstant.minimumGoodPrice}";
      } else {
        return null;
      }
    } else {
      return "${ContentConstant.correctPriceGood}";
    }
  }

  void onChangeFindAsset(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      assetDropdownList.clear();
      assetDropdownList.refresh();
      nextPageAsset.value = 1;
      if (text.isEmpty) {
        if (isFirstAsset.isTrue) {
          fetchApiAsset();
          isFirstAsset.toggle();
        } else {
          fetchApiAsset(page: nextPageAsset.value);
        }
      } else {
        searchAsset(text);
      }
    });
  }

  onChangePriceProduct(String value) {
    if (value.isNotEmpty) {
      realPrice.value = int.parse("$value");
      value = "Rp. ${value.toDecimalFormat()}";
      priceController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
  }

  selectItemValidation(String value) {
    if (value.isEmpty) {
      return "${ContentConstant.emptyProduct}";
    }
    return null;
  }

  void goToSubmissionSection() {
    phoneNumberController.clear();
    priceController.clear();
    productController.clear();
    realPrice(0);

    bumblebeeSnapAndBuyBaseController.stepIndex(0);
    bumblebeeSnapAndBuyBaseController.activeMainSection(SECTION.SUBMISSION_SECTION);
    bumblebeeSnapAndBuyBaseController.activeSubSection(SUB_SECTION.NULL_SUB_SECTION);
  }
}
