import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/no_internet_checker_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

import 'no_internet_checker_controller.dart';

class ConnectionCheckerWidget extends GetView<NoInternetCheckerController> {
  final Widget child;
  final void Function() onRefresh;

  ConnectionCheckerWidget({required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.isTrue
        ? FullScreenSpinner(showLoadingMessage: false)
        : controller.isConnected == false
            ? NoInternetCheckerWidget(onRefresh: onRefresh)
            : child);
  }
}
