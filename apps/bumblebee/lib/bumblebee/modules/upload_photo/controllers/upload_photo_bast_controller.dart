import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:intl/intl.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/documents_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadPhotoBastController extends GetxController {
  final RxList<BastModel> listBast = <BastModel>[].obs;
  final uploadPhotoRepository = Get.find<BumblebeeUploadPhotoRepository>();
  final transactionRepository = new BumblebeeTransactionRepository();
  final homePageController = Get.find<BumblebeeHomePageController>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchBast();
    super.onInit();
  }

  void fetchBast() async {
    isLoading(true);
    listBast.clear();
    await uploadPhotoRepository
        .fetchListUpload(Get.context, createRequest(), "BAST_list")
        .then((value) {
      value.data!.bast!.forEach((element) {
        String _price =
            element.otr != null ? element.otr.toString().toRupiah() : "-";
        listBast.add(new BastModel(
            name: ContentConstant.documentBast,
            date:
                DateFormat(DateConstant.dateFormat4).format(element.orderDate!),
            id: element.prospectId,
            price: _price));
      });
      isLoading(false);
    });
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, String>();
    request["document_type"] = ContentConstant.documentBast;
    return request;
  }

  void checkOrder(String? prospectId, String? price, String? date) {
    var requestBody = Map<String, dynamic>();
    requestBody["prospect_id"] = prospectId;
    transactionRepository
        .fetchApiAllOrders(Get.context, requestBody)
        .then((value) {
      var data = value.data!.first;
      if (data.sourceApplication!
              .isContainIgnoreCase(ContentConstant.snbSourceApp) ||
          data.sourceApplication!
              .isContainIgnoreCase(ContentConstant.eformSourceApp)) {
        if (data.customerReceiptPhotoUrl!.isEmpty) {
          navigateToCamera(prospectId, price, date, true);
        } else {
          navigateToCamera(prospectId, price, date, false);
        }
      } else {
        navigateToCamera(prospectId, price, date, false);
      }
    });
  }

  void navigateToCamera(
      String? prospectId, String? price, String? date, bool isEmptyReceipt) {
    Get.toNamed(Routes.UPLOAD_PHOTO_CAMERA, arguments: {
      "price": price,
      "id": prospectId,
      "date": date,
      "flag": ContentConstant.documentBast,
      "is_empty_cust_receipt": isEmptyReceipt
    })!
        .then((value) {
      fetchBast();
      homePageController.refreshData();
    });
  }

  Future<dynamic> showDialog() {
    return Get.defaultDialog(
        backgroundColor: DeasyColor.neutral000,
        title: "Tidak Dapat Upload BAST",
        titleStyle: TextStyle(color: DeasyColor.neutral900),
        contentPadding: EdgeInsets.all(8),
        confirm: Container(
          width: DeasySizeConfigUtils.screenWidth! / 2,
          child: DeasyCustomButton(
            onPressed: () {
              Get.back();
            },
            text: 'Kembali',
          ),
        ),
        onConfirm: () {
          AnalyticConfig().sendEventFailed("Bast_Upload_Req_Photo_Receipt");
          Get.back();
        },
        content: Text("Silahkan upload dokumen bukti terima terlebih dahulu"));
  }
}
