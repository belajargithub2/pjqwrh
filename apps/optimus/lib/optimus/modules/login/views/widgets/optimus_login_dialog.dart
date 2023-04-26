import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusLoginDialog {
  alertMaxLimitDialog() {
    DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      icon: Icon(
        Icons.cancel_outlined,
        color: Colors.red,
        size: 60,
      ),
      title: DialogConstant.requestOTPLimitTitle,
      subTitle: DialogConstant.tryAgainIn15Menutes,
      buttonOkText: ButtonConstant.ok,
      onPressButtonOk: () {
        Get.back();
      },
    );
  }

  alertPhoneNotRegisterDialog() {
    DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      icon: Icon(
        Icons.cancel_outlined,
        color: Colors.red,
        size: 60,
      ),
      title: ContentConstant.errorPhoneNotRegister,
      subTitle: ContentConstant.yourPhoneNotRegister,
      subTitleTextAlign: TextAlign.center,
      buttonOkText: ButtonConstant.ok,
      onPressButtonOk: () {
        Get.back();
      },
    );
  }

  verifyAccountDialog(String email, Function onPressButtonOk) {
    DeasyBaseDialogs.getInstance().iconDialog(
      barrierDismissible: false,
      context: Get.context!,
      height: 44.h,
      radius: 12.0,
      width: 36.w,
      title: DialogConstant.accountNotVerified,
      fontSizeTitle: 2.73.h,
      customSubtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeasyTextView(
            text: ContentConstant.checkEmailInbox1,
            fontColor: DeasyColor.neutral500,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 0.58.h,
          ),
          DeasyTextView(
            text: ContentConstant.checkEmailInbox2,
            fontColor: DeasyColor.neutral500,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 0.58.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeasyTextView(
                text: ContentConstant.checkEmailInbox3,
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral500,
                fontSize: 0.97.w,
                fontFamily: FontFamily.medium,
              ),
              SizedBox(
                width: 0.3.w,
              ),
              DeasyTextView(
                text: email,
                fontSize: 0.97.w,
                fontFamily: FontFamily.medium,
              ),
            ],
          ),
          SizedBox(
            height: 4.09.h,
          ),
          DeasyTextView(
            text: ContentConstant.hasReceiveEmail,
            fontColor: DeasyColor.neutral300,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
        ],
      ),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ButtonConstant.resendVerificationEmail,
      onPressButtonOk: () => onPressButtonOk(),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_WARNING_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      )
    );
  }
}
