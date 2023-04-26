library deasy_dialog_wrapper;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeasyDialogWrapper {
  Future dialog(Widget? widget, [VoidCallback? onFinished]) {
    return Get.dialog(widget!);
  }
}
