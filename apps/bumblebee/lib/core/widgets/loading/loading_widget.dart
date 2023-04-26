import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

import 'loading_controller.dart';

class LoadingWidget extends GetWidget<LoadingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading
          ? WillPopScope(
              onWillPop: () => Future.value(false),
              child: FullScreenSpinner(),
            )
          : const SizedBox();
    });
  }
}
