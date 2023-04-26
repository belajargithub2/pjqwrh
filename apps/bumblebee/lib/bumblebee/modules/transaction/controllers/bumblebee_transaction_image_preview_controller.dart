import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';

class BumblebeeTransactionImagePreviewController extends GetxController
    with StateMixin<Uint8List> {
  BumblebeeTransactionRepository _transactionRepository;
  final _arguments = Get.arguments;
  String? title = '';

  BumblebeeTransactionImagePreviewController(
      {required BumblebeeTransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  void onInit() {
    title = _arguments['title'];
    fetchImage(Get.context,
        flag: Get.arguments['type'], prospectId: Get.arguments['prospectId']);
    super.onInit();
  }

  void fetchImage(BuildContext? context,
      {required String? flag, required String? prospectId}) async {
    try {
      change(null, status: RxStatus.loading());

      Uint8List? imageByteData = await _transactionRepository.fetchDocument(
          context, null, prospectId, flag);

      imageByteData != null || imageByteData!.isNotEmpty
          ? change(imageByteData, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
