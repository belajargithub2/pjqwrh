import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_timer/deasy_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/controllers/merchant_user_management_controller.dart';

class MerchantUserManagementStatusWidget
    extends GetView<MerchantUserManagementController> {
  final int index;
  final Duration? duration;

  MerchantUserManagementStatusWidget({
    required this.index,
    this.duration
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          controller.isActiveTimer[index] == false
              ? Icons.info_outline_rounded
              : Icons.access_time_outlined,
          color: DeasyColor.semanticWarning300,
          size: 1.76.h,
        ),
        SizedBox(width: 0.6.h),
        controller.isActiveTimer[index] == false
            ? DeasyTextView(
                text: ContentConstant.waitingForVerification,
                fontColor: DeasyColor.semanticWarning300,
                fontFamily: FontFamily.medium,
                fontSize: 1.76.h,
              )
            : DeasyMinutesTimerWidget(
                duration: duration!,
                fontColor: DeasyColor.semanticWarning300,
                fontFamily: FontFamily.medium,
                fontSize: 1.76.h,
                endTimerText: ContentConstant.waitingForVerification,
                onEnd: () {
                  controller.isActiveTimer[index] = false;
                },
              )
      ],
    );
  }
}
