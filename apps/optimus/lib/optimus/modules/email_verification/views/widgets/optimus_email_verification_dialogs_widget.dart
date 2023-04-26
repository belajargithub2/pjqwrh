import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

successResendVerificationEmailDialog(String email, Function onPressButtonOk) {
  DeasyBaseDialogs.getInstance().iconDialog(
      barrierDismissible: false,
      context: Get.context!,
      height: 36.h,
      radius: 12.0,
      width: 36.w,
      dialogMargin: 1.66.w,
      iconTopMargin: 0,
      iconBottomMargin: 1.2.w,
      titleBottomMargin: 1.2.w,
      title: ContentConstant.successSendVerificationEmail,
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
        ],
      ),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ContentConstant.dialogBtnOke,
      onPressButtonOk: () => onPressButtonOk(),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_SUCCESS_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      )
  );
}
