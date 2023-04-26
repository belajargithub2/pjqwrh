import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

successAddUserDialog({
  required String email,
  bool isShowSuccessDialog = false,
}) {
  DeasyBaseDialogs.getInstance().iconDialog(
      barrierDismissible: false,
      context: Get.context!,
      height: 43.h,
      radius: 12.0,
      width: 36.w,
      title: DialogConstant.successAddMerchantEmployee,
      fontSizeTitle: 2.73.h,
      customSubtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeasyTextView(
            text: "Silakan periksa kotak masuk email:",
            fontColor: DeasyColor.neutral400,
            fontSize: 2.05.h,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DeasyTextView(
            text: email,
            fontColor: DeasyColor.neutral900,
            fontSize: 2.05.h,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DeasyTextView(
            text: "untuk melanjutkan proses verifikasi akun",
            fontColor: DeasyColor.neutral400,
            fontSize: 2.05.h,
          ),
        ],
      ),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ContentConstant.back,
      onPressButtonOk: () {
        isShowSuccessDialog = false;
        Get.back();
        Get.back();
      },
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_SUCCESS_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      ));
}

successResendEmailDialog(String email) {
  DeasyBaseDialogs.getInstance().iconDialog(
      barrierDismissible: false,
      context: Get.context!,
      height: 43.h,
      radius: 12.0,
      width: 36.w,
      title: ContentConstant.successSendEmail,
      fontSizeTitle: 2.73.h,
      customSubtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeasyTextView(
            text: "Silakan periksa kotak masuk email:",
            fontColor: DeasyColor.neutral400,
            fontSize: 2.05.h,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DeasyTextView(
            text: email,
            fontColor: DeasyColor.neutral900,
            fontSize: 2.05.h,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DeasyTextView(
            text: "untuk melanjutkan proses verifikasi akun",
            fontColor: DeasyColor.neutral400,
            fontSize: 2.05.h,
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
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_SUCCESS_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      )
  );
}

deleteUserDialog(Function onDelete) {
  DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      radius: 12.0,
      height: 36.h,
      width: 36.w,
      direction: Direction.horizontal,
      title: DialogConstant.dialogConfirmDeleteTitle,
      subTitle: DialogConstant.confirmDeleteUser,
      fontSizeTitle: 2.73.h,
      fontSizeSubTitle: 2.05.h,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ContentConstant.dialogBtnDelete,
      buttonCancelText: ContentConstant.dialogBtnCancel,
      onPressButtonOk: () {
        Get.back();
        onDelete();
      },
      onPressButtonCancel: () {
        Get.back();
      },
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

successDeleteDialog() {
  DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      radius: 12.0,
      height: 33.h,
      width: 36.w,
      title: DialogConstant.successDelete,
      fontSizeTitle: 2.73.h,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ButtonConstant.back,
      onPressButtonOk: () {
        Get.back();
      },
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_SUCCESS_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      ));
}

resendEmailDialog({required Function() ontap}) {
  DeasyBaseDialogs.getInstance().iconDialog(
      direction: Direction.horizontal,
      context: Get.context!,
      radius: 12.0,
      height: 37.h,
      width: 36.w,
      title: DialogConstant.resendEmail,
      subTitle: DialogConstant.resendEmailSubTitle,
      fontSizeTitle: 2.73.h,
      fontSizeSubTitle: 2.05.h,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonOkText: ButtonConstant.back,
      buttonCancelText: ButtonConstant.resend,
      okTextButtonColor: DeasyColor.kpYellow500,
      okBorderButtonColor: DeasyColor.kpYellow500,
      okPrimaryButtonColor: DeasyColor.neutral000,
      cancelTextButtonColor: DeasyColor.neutral000,
      cancelBorderButtonColor: DeasyColor.kpYellow500,
      cancelPrimaryButtonColor: DeasyColor.kpYellow500,
      onPressButtonOk: () {
        Get.back();
      },
      onPressButtonCancel: ontap,
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_WARNING_PATH,
          height: 8.5.h,
          width: 8.5.h,
        ),
      ));
}

waitingToResendEmailDialog() {
  DeasyBaseDialogs.getInstance().iconDialog(
      direction: Direction.horizontal,
      context: Get.context!,
      radius: 12.0,
      height: 40.h,
      width: 36.w,
      title: DialogConstant.tWaitingToResendEmail,
      subTitle: DialogConstant.stWaitingToResendEmail,
      fontSizeTitle: 2.73.h,
      fontSizeSubTitle: 2.05.h,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      buttonCancelText: ButtonConstant.back,
      onPressButtonCancel: () {
        Get.back();
      },
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: SvgPicture.asset(
          IconConstant.RESOURCES_ICON_WARNING_PATH,
          height: 64,
          width: 64,
        ),
      ));
}
