import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

successResendVerificationEmailDialog(String email, Function onPressButtonOk) {
  DeasyBaseDialogs.getInstance().iconDialog(
      barrierDismissible: false,
      context: Get.context!,
      height: 49.h,
      radius: 12.0,
      width: 36.w,
      title: ContentConstant.successSendVerificationEmail,
      fontSizeTitle: 2.73.h,
      customSubtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: ContentConstant.checkEmailInbox,
              style: TextStyle(
                color: DeasyColor.neutral400,
                fontFamily: getFontFamily(FontFamily.medium),
                fontSize: 3.4.w,
                height: 1.6
              ),
              children: [
                TextSpan(
                  text: email,
                  style: TextStyle(
                    color: DeasyColor.neutral900,
                    fontFamily: getFontFamily(FontFamily.medium),
                    fontSize: 3.4.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: DialogConstant.dialogBtnOke,
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