import 'dart:async';

import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:newwg/config/auth_config.dart';
import 'package:newwg/config/data_config.dart';
import 'package:order/data/constants/image_constant.dart';
import 'package:order/data/constants/string_constant.dart';
import 'package:order/data/mappers/mapper.dart';
import 'package:order/data/model/get_group_category_model.dart' as m;
import 'package:order/data/model/get_order_model.dart';
import 'package:order/data/model/get_white_goods_model.dart' as mwg;
import 'package:order/data/model/multi_asset_model.dart';
import 'package:order/data/request/get_order_request.dart';
import 'package:order/data/request/submit_order_request.dart';
import 'package:order/utils/get_permissions.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/controller/stepper_container_controller.dart';

class OrderController extends GetxController {
  final NewWgRepositoryImpl? repository;

  OrderController({this.repository});

  Timer? debounce;
  final stepper = Get.find<StepperContainerController>();
  late GetPermission getPermission;
  final formKey = GlobalKey<FormState>();
  final formKeyProductType = GlobalKey<FormState>();
  final productTypeController = TextEditingController();
  final selectProductController = TextEditingController();
  final priceProductController = TextEditingController();
  final searchController = TextEditingController();
  final isShowProductByCategory = false.obs;
  final isOpenProductType = false.obs;
  final isAgree = false.obs;
  final countSubmit = 0.obs;
  final listAsset = <MultiAssetModel>[].obs;
  final getGroupCategoryModel = m.GetGroupCategoryModel().obs;
  final getWhiteGoodsModel = mwg.GetWhiteGoodsModel().obs;
  final listWhiteGoods = <mwg.WhiteGoods>[].obs;
  final submitOrderRequest = SubmitOrderRequest().obs;
  final isMultiAsset = false.obs;
  final isDisableDetailProduct = true.obs;
  final isLoading = false.obs;
  final minimumPrice = 150000.obs;
  final initialPage = 1.obs;
  final limit = 10.obs;
  final groupCategoryId = 0.obs;
  final groupCategoryCode = ''.obs;
  final groupCategoryName = ''.obs;
  final isLoadMore = false.obs;
  final nextPageProduct = 1.obs;
  final countRecord = 0.obs;
  final isSuccessOrder = false.obs;
  double lat = 0.0;
  double lng = 0.0;
  final prospectId = 0.obs;
  final isEmptyProduct = false.obs;
  GetOrderModel? existingOrder;
  final scrollController = ScrollController();
  final isKeyboardShow = false.obs;
  final estimatedAdditionalScrollingHeight = 250.0;
  final maxInputPriceLength = 9;
  final aesEncryptor = AesHelper(key: KeyConstant.platformKey);

  @override
  void onInit() {
    getPermission = GetPermission();
    getLocation();
    fetchDataTypes();
    addNewAsset();
    checkIfEditOrder();
    super.onInit();
  }

  void keyboardListener(BuildContext context) {
    isKeyboardShow.value = MediaQuery.of(context).viewInsets.bottom != 0;
    if (isKeyboardShow.isTrue) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + estimatedAdditionalScrollingHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> getLocation() async {
    final status = await getPermission.status();

    if (!status) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    lng = position.longitude;
  }

  Future<void> fetchDataTypes() async {
    isLoading.value = true;
    await repository?.getAssetGroupCategories(Get.context!).then((data) {
      getGroupCategoryModel.value = data.toModel();
    }).whenComplete(() => isLoading.value = false);
  }

  void onTapProductType(m.GroupCategory type) {
    listAsset.clear();

    if (isDisableDetailProduct.value) {
      isDisableDetailProduct.value = false;
    }

    if (type.isAllowMultiAsset!) {
      isMultiAsset.value = true;
    } else {
      isMultiAsset.value = false;
    }

    addNewAsset();
    formKey.currentState?.reset();
    productTypeController.text = type.name!;
    groupCategoryId.value = type.id!;
    groupCategoryCode.value = type.code!;
    groupCategoryName.value = type.name!;
    isOpenProductType.toggle();
  }

  void addNewAsset() {
    listAsset.add(MultiAssetModel(
      qty: 1,
      price: 0,
      name: TextEditingController(),
      priceController: TextEditingController(),
    ));
  }

  void deleteAsset(int index) {
    listAsset.removeAt(index);
  }

  void addQty(int index) {
    listAsset[index].qty = listAsset[index].qty! + 1;
    listAsset.refresh();
  }

  void minusQty(int index) {
    if (listAsset[index].qty! > 1) {
      listAsset[index].qty = listAsset[index].qty! - 1;
    }
    listAsset.refresh();
  }

  String? productValidation(String value) {
    if (value.isEmpty) {
      return StringConstant.productCantBeNull;
    }

    return null;
  }

  String? productTypeValidation(String value) {
    if (value.isEmpty) {
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, StringConstant.productTypeCantBeNull);
      return "";
    }

    return null;
  }

  void submit() async {
    countSubmit.value++;

    if (formKeyProductType.currentContext != null){
      if (!formKeyProductType.currentState!.validate()) {
        return;
      }
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (isAgree.isFalse) {
      return;
    }

    isLoading.value = true;

    if (DataConfig.instance.isEditOrder) {
      await repository
          ?.editOrder(Get.context!, setRequestEditOrder().toJson(),
          AuthConfig.instance.xSourceToken)
          .then((value) {
        isSuccessOrder.value = true;
        resetConfigIsEdit();
      }).catchError((onError){ isLoading.value = false; });
      return;
    }

    await repository
        ?.submitOrder(Get.context!, setRequestSubmitOrder().toJson(),
        AuthConfig.instance.xSourceToken)
        .then((value) {
      isSuccessOrder.value = true;
    }).catchError((onError){ isLoading.value = false; });

    isLoading.value = false;
  }

  SubmitOrderRequest setRequestSubmitOrder() {
    final asset = listAsset
        .map((e) => Asset(
      code: e.assetCode,
      description: e.description,
      categoryId: e.categoryId,
      categoryName: e.categoryName,
      otr: e.price,
      qty: e.qty,
    ))
        .toList();

    SubmitOrderRequest request = SubmitOrderRequest()
      ..prospectId = DataConfig.instance.prospectId
      ..groupCategoryId = groupCategoryId.value
      ..groupCategoryCode = groupCategoryCode.value
      ..groupCategoryName = groupCategoryName.value
      ..assets = asset
      ..croId = DataConfig.instance.croId
      ..croName = DataConfig.instance.croName
      ..supplierId = DataConfig.instance.supplierId
      ..supplierName = DataConfig.instance.supplierName
      ..supplierAddress = DataConfig.instance.supplierAddress
      ..supplierKey = DataConfig.instance.supplierKey
      ..customerId = aesEncryptor.encrypt("${stepper.customerId.value}")
      ..customerName = stepper.customerName.value
      ..customerLimitCategory = stepper.limitType.value
      ..customerMobilePhone = stepper.phoneNumber.value
      ..latitude = lat.toString()
      ..longitude = lng.toString()
      ..sourceApplication = AuthConfig.instance.appSource
      ..branchId = DataConfig.instance.branchId
      ..isNearCustomer = isAgree.value
      ..isNewWg = DataConfig.instance.isNewWg;
    return request;
  }

  String? priceValidation(String value, int i) {
    if (value.isEmpty) {
      return StringConstant.priceCantBeNull;
    } else if (listAsset[i].price! < minimumPrice.value) {
      return '${StringConstant.minPriceLabel} ${minimumPrice.value.toString().toDecimalFormat()}';
    }

    return null;
  }

  void onTapProduct(int index) {
    listAsset
        .where((element) => element.isSearchProduct == true)
        .forEach((element) {
      if (element.isSearchProduct != listAsset[index].isSearchProduct) {
        element.isSearchProduct = false;
      }
    });

    listAsset[index].isSearchProduct = !listAsset[index].isSearchProduct!;
    if (listAsset[index].isSearchProduct == false) {
      nextPageProduct.value = 1;
      searchController.text = '';
      listWhiteGoods.clear();
    } else {
      getProductByGroupCategory();
    }

    listAsset.refresh();
  }

  Future<void> getProductByGroupCategory(
      {page = 1, limit = 10, search = 'xiaomi'}) async {
    isEmptyProduct.value = false;
    await repository
        ?.getWhiteGoods(
      Get.context!,
      groupCategoryId.value,
      search,
      page,
      limit,)
        .then((data) {
      getWhiteGoodsModel.value = data.toModel();
      listWhiteGoods.addAll(getWhiteGoodsModel.value.data!);
      countRecord.value = getWhiteGoodsModel.value.pageInfo!.totalRecord ?? 0;
      nextPageProduct.value = getWhiteGoodsModel.value.pageInfo!.nextPage ?? 0;

      if (getWhiteGoodsModel.value.data!.isNotEmpty) {
        isLoadMore.value = true;
      } else {
        isEmptyProduct.value = true;
        isLoadMore.value = false;
      }
    }).catchError((onError) {
      nextPageProduct.value = 1;
      isLoadMore.value = false;
      isEmptyProduct.value = true;
    });
    
  }

  Future<bool> loadMore() async {
    if (isLoadMore.isTrue) {
      await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
      if (searchController.text.isNotEmpty) {
        getProductByGroupCategory(
            page: nextPageProduct.value, search: searchController.text);
      } else {
        getProductByGroupCategory(page: nextPageProduct.value);
      }
      return true;
    } else {
      return false;
    }
  }

  void onchangeProduct(String text) {
    listWhiteGoods.clear();

    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (text.isNotEmpty) {
        getProductByGroupCategory(search: text);
      } else {
        listWhiteGoods.clear();
      }
    });
  }

  void selectProduct(mwg.WhiteGoods listWhiteGood, int i) {
    listAsset[i].name!.text = listWhiteGood.description!;
    listAsset[i].assetCode = listWhiteGood.assetCode!;
    listAsset[i].description = listWhiteGood.description!;
    listAsset[i].categoryId = listWhiteGood.categoryId!;
    listAsset[i].categoryName = listWhiteGood.categoryName!;
    listAsset[i].isSearchProduct = false;

    listWhiteGoods.clear();
    searchController.text = '';
    listAsset.refresh();
  }

  Future<void> checkIfEditOrder() async {
    if (DataConfig.instance.isEditOrder) {
      isDisableDetailProduct.value = false;

      final authConfig = await DeasyPocket().getNewWgAuthConfig();
      authConfig != null ? AuthConfig.instance.fromJson(authConfig) : null;
      
      final dataConfig = await DeasyPocket().getNewWgDataConfig();
      dataConfig != null ? DataConfig.instance.fromJson(dataConfig) : null;
      getCustomerOrder(DataConfig.instance.prospectId);
    }
  }

  Future<void> getCustomerOrder(String prospectId) async {
    isLoading.value = true;

    final getOrderRequest = GetOrderRequest(
      prospectId: prospectId,
      sourceApplication: AuthConfig.instance.appSource,
    ).toJson();

    repository
        ?.getOrder(
        Get.context!, getOrderRequest, AuthConfig.instance.xSourceToken)
        .then((value) {
      existingOrder = GetOrderModel.fromJson(value.toJson());
      final data = existingOrder!.data!;

      productTypeController.text = data.groupCategoryName ?? "";
      groupCategoryId.value = data.groupCategoryId ?? 1;
      groupCategoryCode.value = data.groupCategoryCode ?? "";
      groupCategoryName.value = data.groupCategoryName ?? "";
      listAsset.value = data.assets!
          .map((e) => MultiAssetModel(
        assetCode: e.code,
        qty: e.qty,
        price: e.otr,
        description: e.description,
        categoryId: e.categoryId,
        categoryName: e.categoryName,
        name: TextEditingController(text: e.description),
        priceController:
        TextEditingController(text: e.otr.toString().toRupiah()),
      ))
          .toList();

      if (data.isEditable == false) {
        dialogFailedToEdit();
      }

      isLoading.value = false;
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  SubmitOrderRequest setRequestEditOrder() {
    final orderData = existingOrder!.data!;

    final asset = listAsset
        .map((e) => Asset(
      code: e.assetCode,
      description: e.description,
      categoryId: e.categoryId,
      categoryName: e.categoryName,
      otr: e.price,
      qty: e.qty,
    ))
        .toList();

    SubmitOrderRequest request = SubmitOrderRequest()
      ..prospectId = orderData.prospectId
      ..groupCategoryId = groupCategoryId.value
      ..groupCategoryCode = groupCategoryCode.value
      ..groupCategoryName = groupCategoryName.value
      ..assets = asset
      ..croId = orderData.croId
      ..croName = orderData.croName
      ..supplierId = orderData.supplierId
      ..supplierName = orderData.supplierName
      ..supplierAddress = orderData.supplierAddress
      ..supplierKey = DataConfig.instance.supplierKey
      ..customerId = orderData.customerId
      ..customerName = orderData.customerName
      ..customerLimitCategory = orderData.customerLimitCategory
      ..customerMobilePhone = orderData.customerMobilePhone
      ..latitude = lat.toString()
      ..longitude = lng.toString()
      ..sourceApplication = orderData.sourceApplication
      ..branchId = DataConfig.instance.branchId
      ..isNearCustomer = isAgree.value
      ..isNewWg = orderData.isNewWg;
    return request;
  }

  dialogFailedToEdit() {
    DeasyBaseDialogs.getInstance().iconDialog(
        context: Get.context!,
        barrierDismissible: false,
        width: 500,
        height: 300,
        fontSizeTitle: 18,
        fontSizeSubTitle: 16,
        title: StringConstant.cantEditTitleOrder,
        subTitle: StringConstant.cantEditSubTitleOrder,
        icon: SvgPicture.asset(ImageConstant.icDialog),
        onPressButtonOk: (){
          resetConfigIsEdit();
          if (stepper.isLibrary.isTrue){
            SystemNavigator.pop(animated: true);
          } else {
            Get.back();
            Get.back();
          }
        });
  }

  void onBackToDashboard() {
    resetConfigIsEdit();
    if (stepper.isLibrary.isTrue){
      SystemNavigator.pop(animated: true);
    } else {
      Get.back();
      Get.back();
      Get.back();
    }
  }

  void resetConfigIsEdit() {
    DataConfig.instance.isEditOrder = false;
    DataConfig.instance.isShowIndicator = true;
  }
}
