import 'dart:async';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/transaction_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/model/cancel_reason_response.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';

class DashboardCancelRequestController extends GetxController {
  Timer? debounce;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  RxBool isActiveReason = false.obs;
  ScrollController? reasonScrollController;
  TextEditingController? cancelOrderTextController, searchReasonTextController;
  String? orderId;
  late TransactionRepository transactionRepository;
  final Rx<CancelReasonResponse> reasonListResponse = CancelReasonResponse().obs;
  final searchReasonList = [].obs;
  final reasonList = [].obs;
  RxString reason = ''.obs;
  static const FIVE_HUNDRED_MILLISECOND = 500;
  final searchValue = ''.obs;

  @override
  void onInit() {
    transactionRepository = TransactionRepository();
    reasonScrollController = ScrollController();
    cancelOrderTextController = TextEditingController();
    searchReasonTextController = TextEditingController();
    orderId = Get.arguments == null ? '' : Get.arguments['id'];
    fetchApiReasonList();
    super.onInit();
  }

  @override
  void onClose() {
    debounce?.cancel();
    super.onClose();
  }

  fetchApiReasonList() {
    transactionRepository.fetchApiCancelReasonList(Get.context, null).then((value) {
      reasonListResponse.value = value;
      reasonList.value = value.data!;
    });
  }

  onReasonSearchTextChanged(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: FIVE_HUNDRED_MILLISECOND), () async {
      searchReasonList.clear();
      searchValue.value = text;
      reasonList.forEach((reason) {
        if (reason.toString().isContainIgnoreCase(text)) {
          searchReasonList.add(reason);
        }
      });
    });
  }

  submitCancelRequest() {
    showLoading();
    var requestBody = <String, dynamic> {"prospect_id": orderId, "reason": reason.value};
    transactionRepository.putApiCancelOrder(Get.context, requestBody).then((value) {
      hideLoading();
      if (value.message == "OK") {
        DeasySnackBarUtil.showSnackBar(Get.context!, "Pembatalan Berhasil dilakukan");
        Future.delayed(const Duration(milliseconds: 800), () {
          Get.back();
          Get.back();
          Get.back();
        });
      }
    }).catchError((onError){
      hideLoading();
      DeasySnackBarUtil.showFlushBarError(Get.context!, "$onError");
    });
  }

  void showLoading() {
    Get.find<OptimusDrawerCustomController>().showLoading();
  }

  void hideLoading() {
    Get.find<OptimusDrawerCustomController>().hideLoading();
  }

}
