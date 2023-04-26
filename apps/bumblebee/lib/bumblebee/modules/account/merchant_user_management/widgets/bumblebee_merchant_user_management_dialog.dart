import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

successResendEmailDialog(String email) {
  DeasyBaseDialogs.getInstance().iconDialog(
    context: Get.context!,
    height: 45.h,
    radius: 16.0,
    title: ContentConstant.successSendEmail,
    fontSizeTitle: 20,
    customSubtitleWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DeasyTextView(
          text: "Silakan periksa kotak masuk email:",
          fontColor: DeasyColor.neutral400,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        DeasyTextView(
          text: email,
          fontColor: DeasyColor.neutral900,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        DeasyTextView(
          text: "untuk melanjutkan proses verifikasi akun",
          fontColor: DeasyColor.neutral400,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    buttonOkText: ContentConstant.back,
    onPressButtonOk: () {
      Get.back();
    },
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(IconConstant.RESOURCES_ICON_SUCCESS_PATH),
    )
  );
}

deleteUserDialog(Function onDelete) {
  DeasyBaseDialogs.getInstance().iconDialog(
    context: Get.context!,
    radius: 16.0,
    height: 38.h,
    direction: Direction.horizontal,
    title: DialogConstant.dialogConfirmTitle,
    subTitle: ContentConstant.confirmDeleteUser,
    fontSizeTitle: 2.94.h,
    fontSizeSubTitle: 2.05.h,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    buttonOkText: DialogConstant.dialogBtnDelete,
    buttonCancelText: DialogConstant.dialogBtnCancel,
    onPressButtonOk: () {
      Get.back();
      onDelete();
    },
    onPressButtonCancel: () {
      Get.back();
    },
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(IconConstant.RESOURCES_ICON_WARNING_PATH),
    )
  );
}

successDeleteDialog() {
  DeasyBaseDialogs.getInstance().iconDialog(
    context: Get.context!,
    radius: 16.0,
    height: 27.h,
    title: ContentConstant.successDelete,
    fontSizeTitle: 2.94.h,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    buttonOkText: ContentConstant.back,
    onPressButtonOk: () {
      Get.back();
    },
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(IconConstant.RESOURCES_ICON_SUCCESS_PATH),
    )
  );
}

successAddUserDialog(String email, Function onFinished) {
  DeasyBaseDialogs.getInstance().iconDialog(
    context: Get.context!,
    height: 45.h,
    radius: 16.0,
    title: ContentConstant.successAddMerchantEmployee,
    fontSizeTitle: 20,
    customSubtitleWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DeasyTextView(
          text: "Silakan periksa kotak masuk email:",
          fontColor: DeasyColor.neutral400,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        DeasyTextView(
          text: email,
          fontColor: DeasyColor.neutral900,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        DeasyTextView(
          text: "untuk melanjutkan proses verifikasi akun",
          fontColor: DeasyColor.neutral400,
          fontSize: 16,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    buttonOkText: ContentConstant.back,
    onPressButtonOk: () {
      onFinished();
      Get.back();
      Get.back();
    },
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(IconConstant.RESOURCES_ICON_SUCCESS_PATH),
    )
  );
}