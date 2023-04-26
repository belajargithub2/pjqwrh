import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';


class TableTransactionController extends GetxController {
  onCopyToClipBoard(String? copyValue) {
    Clipboard.setData(new ClipboardData(text: copyValue));
    DeasySnackBarUtil.showSnackBar(Get.context!, "$copyValue berhasil di copy");
  }
}
