import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EcommerceClientKeyController extends GetxController {
  final appVersion = ''.obs;
  final supplierID = ''.obs;
  final nameController = TextEditingController();
  final merchantNameController = TextEditingController();
  final keyController = TextEditingController();
  final callbackStatusController = TextEditingController();
  final callbackSignatureController = TextEditingController();
  final callbackOrderController = TextEditingController();
  final eCommerceClientKeyRepository = new ECommerceClientKeyRepository();
  late bool isSuccessGenerate;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void dispose() {
    callbackOrderController.clear();
    callbackStatusController.clear();
    keyController.clear();
    nameController.clear();
    merchantNameController.clear();
    super.dispose();
  }

  void init() {
    DeasyPocket().getSupplierId().then((value) {
      supplierID.value = value;
      update();
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion.value = packageInfo.version;
      update();
    });
  }

  void fetchEcommerceBySupplierId(BuildContext context,
      {Map<String, dynamic>? requestBody}) {
    Future.delayed(const Duration(milliseconds: 500), () {
      eCommerceClientKeyRepository
          .fetchApClientBySupplierKey(context, requestBody, supplierID.value)
          .then((value) {
        nameController.text = value.data!.name!;
        merchantNameController.text = value.data!.merchantName!;
        callbackOrderController.text = value.data!.callbackUrlOrder!;
        callbackStatusController.text = value.data!.callbackUrlStatus!;
        callbackSignatureController.text = value.data!.callbackUrlSignature!;
        keyController.text = value.data!.key!;
        update();
      }).catchError((onError) {
        print('$onError');
      });
    });
  }

  void GenerateKey() {
    keyController.text =
        nameController.text + '.' + DeasyStringHelper.getRandomString(length: 32);
    if (keyController.text.length <= 32) {
      isSuccessGenerate = false;
    } else if (keyController.text.length > 32) {
      isSuccessGenerate = true;
    }
    update();
  }

  void updateECommerceClientKey(BuildContext context) {
    eCommerceClientKeyRepository
        .postApiUpdateECommerceClientKey(
            context, createRequest(), "ECommerce_Client_Key_Update")
        .then((value) {
      Get.snackbar("Yeay", "Sukses Update Data",
          colorText: DeasyColor.neutral900);
      AnalyticConfig().sendEventSuccess("ECommerce_Client_Key_Update");
    }).catchError((onError) {
      print(onError);
      Get.snackbar("Ops ...", "$onError", colorText: DeasyColor.neutral900);
      AnalyticConfig().sendEventFailed("ECommerce_Client_Key_Update");
    });
  }

  Map<String, String> createRequest() {
    var request = Map<String, String>();
    request["callback_url_order"] = callbackOrderController.text;
    request["callback_url_signature"] = callbackSignatureController.text;
    request["callback_url_status"] = callbackStatusController.text;
    request["key"] = keyController.text;
    request["name"] = nameController.text;
    request["supplier_id"] = supplierID.value;
    return request;
  }
}
