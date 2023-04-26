import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_create_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_list_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/repositories/optimus_e_commerce_client_key_repository.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:select_dialog/select_dialog.dart';

class OptimusCreateOUpdateEcommerceClientKeyWebController
    extends GetxController {
  late OptimusECommerceClientKeyRepository eCommerceClientKeyRepository;
  OptimusECommerceClientKeyCreateRequest? request;
  String? parameterSupplierId;
  final supplierId = "".obs;
  final supplierIDFormLogin = "".obs;
  final isEdit = false.obs;
  final role = ''.obs;
  final userId = ''.obs;
  final flag = 0.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final merchantController = TextEditingController();
  final keyTextController = TextEditingController();
  final callbackStatusTextController = TextEditingController();
  final callbackOrderTextController = TextEditingController();
  ECommerceClientKeyData? eCommerceClientKeyData = new ECommerceClientKeyData();
  late MerchantRepository merchantRepository;
  final RxList<MerchantData> listMerchant = <MerchantData>[].obs;
  final isShowDialog = false.obs;
  final loadingController = Get.find<LoadingController>();

  @override
  void onInit() {
    request = OptimusECommerceClientKeyCreateRequest();
    eCommerceClientKeyRepository = OptimusECommerceClientKeyRepository();
    merchantRepository = MerchantRepository();
    parameterSupplierId = Get.parameters["data"];
    getAllMerchant();
    DeasyPocket().getSupplierId().then((value) {
      supplierIDFormLogin.value = value;
      update();
    });

    DeasyPocket().getRole().then((value) {
      role.value = value;
      if (role.value != 'super admin') {
        isEdit.value = true;
        update();
        fetchEcommerceBySupplierId(supplierIDFormLogin.value);
        flag.value = 0;
      } else {
        if (parameterSupplierId == null) {
          isEdit.value = false;
          flag.value = 1;
          update();
        } else {
          isEdit.value = true;
          update();
          flag.value = 2;
          fetchEcommerceBySupplierId(parameterSupplierId!);
        }
      }
    });
    super.onInit();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      OptimusECommerceClientKeyCreateRequest request =
          OptimusECommerceClientKeyCreateRequest();
      request.name = nameController.text;
      request.supplierId = supplierId.value;
      request.key = keyTextController.text;
      request.supplierName = merchantController.text;
      request.callbackUrlOrder = callbackOrderTextController.text;
      request.callbackUrlStatus = callbackStatusTextController.text;
      postCreateUpdateClientKey(request.generateRequest());
    }
  }

  void postCreateUpdateClientKey(Map<String, dynamic> requestBody) async {
    if (isEdit.isTrue) {
      eCommerceClientKeyRepository
          .postApiUpdateECommerceClientKey(
              Get.context, requestBody, "ECommerce_Client_Key_Update")
          .then((value) {
        AnalyticConfig().sendEventSuccess("ECommerce_Client_Key_Update");
        showDialogWeb(true);
      }).catchError((onError) {
        AnalyticConfig().sendEventFailed("ECommerce_Client_Key_Update");
        DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
      });
    } else {
      eCommerceClientKeyRepository
          .postApiCreateECommerceClientKey(Get.context, requestBody)
          .then((value) {
        showDialogWeb(false);
      }).catchError((onError) {
        DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllMerchant() {
    merchantRepository.getAllMerchant(Get.context, null).then((value) {
      listMerchant.addAll(value.merchantData!);
      if (isShowDialog.isTrue) {
        isShowDialog.toggle();
        Get.back();
        merchantListDialog();
      }
      update();
    }).catchError((onError) {});
  }

  Future<List<MerchantData>> filterListMerchant(String filter) async {
    List<MerchantData> list = [];
    for (var item in listMerchant.value) {
      if (item.name!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  void setValue({
    required String name,
    required String newSupplierId,
    required String key,
    required String merchantName,
    required String callbackStatus,
    required String callbackOrder,
  }) {
    nameController.text = name;
    supplierId.value = newSupplierId;
    keyTextController.text = key;
    merchantController.text = merchantName;
    callbackStatusTextController.text = callbackStatus;
    callbackOrderTextController.text = callbackOrder;
  }

  Future<void> fetchEcommerceBySupplierId(String paramSupplierId) async {
    loadingController.isLoading = true;
    await eCommerceClientKeyRepository
        .fetchApClientBySupplierKey(Get.context, null, paramSupplierId)
        .then((value) {
      setValue(
        name: value.data!.name!,
        newSupplierId: paramSupplierId,
        key: value.data!.key!,
        merchantName: value.data!.merchantName!,
        callbackStatus: value.data!.callbackUrlStatus!,
        callbackOrder: value.data!.callbackUrlOrder!,
      );
    }).catchError((onError) {});
    loadingController.isLoading = false;
  }

  merchantListDialog() {
    isShowDialog.toggle();
    SelectDialog.showModal<MerchantData>(
      Get.context!,
      items: listMerchant.value,
      backgroundColor: DeasyColor.neutral000,
      label: ContentConstant.userManagementSearchByMerchantName,
      titleStyle: TextStyle(color: DeasyColor.neutral900),
      searchBoxDecoration: InputDecoration(
        hintText: ContentConstant.searchHint,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      emptyBuilder: (_) => Container(
        child:
            Image.asset(ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION),
        width: Get.width / 10,
        alignment: Alignment.center,
      ),
      onFind: (String filter) => filterListMerchant(filter),
      itemBuilder: (BuildContext context, MerchantData item, bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item.name!),
          ),
        );
      },
      onChange: (MerchantData result) {
        supplierId.value = result.supplierId!;
        merchantController.text = result.name!;
      },
    );
  }

  showDialogWeb(bool isEdit) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              backgroundColor: DeasyColor.neutral000,
              content: Container(
                width: Get.width / 2.7,
                height: Get.height / 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.clear,
                              color: DeasyColor.neutral400, size: 28),
                          onPressed: () {
                            Get.offNamedUntil(
                              OptimusRoutes.ECOMMERCE_CLIENT_KEY,
                              ModalRoute.withName(Routes.DASHBOARD_WEB),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        "resources/images/success_verif.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          isEdit
                              ? ContentConstant.ecommerceEditSucces
                              : ContentConstant.ecommerceAddSucces,
                          style: TextStyle(
                              fontSize: 20,
                              color: DeasyColor.neutral900,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  String? urlValidator(String value) {
    if (value.isEmpty || value.isBlank!) {
      return ContentConstant.urlCantBeNull;
    } else if (!value.urlValidation()) {
      return ContentConstant.urlNotValid;
    }
    return null;
  }
}
