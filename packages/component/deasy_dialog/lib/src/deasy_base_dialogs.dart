import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/src/utils/deasy_dialog_enum.dart';
import 'package:deasy_dialog/src/widgets/custom_dialog.dart';
import 'package:deasy_dialog/src/widgets/icon_dialog.dart';
import 'package:deasy_dialog/src/widgets/simple_dialog.dart';
import 'package:deasy_dialog/src/widgets/web/web_icon_dialog_two_buttons.dart';
import 'package:deasy_dialog/src/widgets/web/web_icon_single_button_dialog.dart';
import 'package:flutter/material.dart';

class DeasyBaseDialogs {
  static DeasyBaseDialogs? deaasyBaseDialog;

  static DeasyBaseDialogs getInstance() {
    if (deaasyBaseDialog == null) {
      deaasyBaseDialog = DeasyBaseDialogs();
    }

    return deaasyBaseDialog!;
  }

  iconDialog({
    required BuildContext context,
    required String title,
    required Widget icon,
    String? subTitle,
    bool barrierDismissible = true,
    double? width,
    double height = 250.0,
    double fontSizeTitle = 18.0,
    double fontSizeSubTitle = 18.0,
    TextAlign subTitleTextAlign = TextAlign.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Function? onPressButtonOk,
    Function? onPressButtonCancel,
    String? buttonOkText = 'OK',
    String? buttonCancelText = 'Cancel',
    double? buttonOkTextSize,
    double? buttonCancelTextSize,
    Color okPrimaryButtonColor = DeasyColor.kpYellow500,
    Color okBorderButtonColor = DeasyColor.kpYellow500,
    Color okTextButtonColor = DeasyColor.neutral000,
    Color cancelPrimaryButtonColor = DeasyColor.neutral000,
    Color cancelBorderButtonColor = DeasyColor.kpYellow500,
    Color cancelTextButtonColor = DeasyColor.kpYellow500,
    double radius = 10.0,
    Widget? customSubtitleWidget,
    Direction direction = Direction.vertical,
    int? maxlineSubtitle,
    double? dialogMargin,
    double? iconTopMargin,
    double? iconBottomMargin,
    double? titleBottomMargin,
  }) {
    Size screenSize = MediaQuery.of(context).size;
    double _width = screenSize.width / (screenSize.aspectRatio * 1.8);
    Widget dialog = WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: DeasyIconDialog(
        title: title,
        subTitle: subTitle,
        maxlineSubtitle: maxlineSubtitle,
        icon: icon,
        width: width ?? _width,
        height: height,
        subTitleTextAlign: subTitleTextAlign,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        onPressButtonOk: onPressButtonOk,
        onPressButtonCancel: onPressButtonCancel,
        buttonOkText: buttonOkText,
        buttonCancelText: buttonCancelText,
        buttonOkTextSize: buttonOkTextSize,
        buttonCancelTextSize: buttonCancelTextSize,
        okPrimaryButtonColor: okPrimaryButtonColor,
        okBorderButtonColor: okBorderButtonColor,
        okTextButtonColor: okTextButtonColor,
        cancelPrimaryButtonColor: cancelPrimaryButtonColor,
        cancelBorderButtonColor: cancelBorderButtonColor,
        cancelTextButtonColor: cancelTextButtonColor,
        radius: radius,
        fontSizeTitle: fontSizeTitle,
        fontSizeSubTitle: fontSizeSubTitle,
        customSubtitleWidget: customSubtitleWidget,
        direction: direction,
        dialogMargin: dialogMargin,
        iconTopMargin: iconTopMargin,
        iconBottomMargin: iconBottomMargin,
        titleBottomMargin: titleBottomMargin,
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  optimusIconDialog({
    required BuildContext context,
    required String title,
    required String? subTitle,
    required Widget icon,
    bool barrierDismissible = true,
    double width = 500.0,
    double height = 250.0,
    double fontSizeTitle = 18.0,
    double fontSizeSubTitle = 18.0,
    TextAlign subTitleTextAlign = TextAlign.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Function? onPressButtonOk,
    Function? onPressButtonCancel,
    String? buttonOkText = 'OK',
    String? buttonCancelText = 'Cancel',
    Color primaryButtonColor = DeasyColor.kpYellow500,
    Color secondaryButtonColor = DeasyColor.neutral000,
    double radius = 10.0,
  }) {
    Widget dialog = WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: DeasyOptimusIconDialogTwoButtons(
        title: title,
        subTitle: subTitle,
        icon: icon,
        width: width,
        height: height,
        subTitleTextAlign: subTitleTextAlign,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        onPressButtonOk: onPressButtonOk,
        onPressButtonCancel: onPressButtonCancel,
        buttonOkText: buttonOkText,
        buttonCancelText: buttonCancelText,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        radius: radius,
        fontSizeTitle: fontSizeTitle,
        fontSizeSubTitle: fontSizeSubTitle,
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  optimusIconSingleDialogDialog({
    required BuildContext context,
    required String title,
    required String? subTitle,
    required Widget icon,
    bool barrierDismissible = true,
    double width = 500.0,
    double height = 250.0,
    double fontSizeTitle = 18.0,
    double fontSizeSubTitle = 18.0,
    TextAlign subTitleTextAlign = TextAlign.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Function? onPressButtonOk,
    Function? onPressButtonCancel,
    String? buttonOkText = 'OK',
    String? buttonCancelText = 'Cancel',
    Color primaryButtonColor = DeasyColor.kpYellow500,
    Color secondaryButtonColor = DeasyColor.neutral000,
    double radius = 10.0,
  }) {
    Widget dialog = WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: DeasyOptimusIconSingleButtonDialog(
        title: title,
        subTitle: subTitle,
        icon: icon,
        width: width,
        height: height,
        subTitleTextAlign: subTitleTextAlign,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        onPressButtonOk: onPressButtonOk,
        onPressButtonCancel: onPressButtonCancel,
        buttonOkText: buttonOkText,
        buttonCancelText: buttonCancelText,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        radius: radius,
        fontSizeTitle: fontSizeTitle,
        fontSizeSubTitle: fontSizeSubTitle,
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  simpleDialog({
    required BuildContext context,
    required String title,
    required String? subTitle,
    double? width,
    double height = 200.0,
    TextAlign subTitleTextAlign = TextAlign.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Function? onPressButtonOk,
    Function? onPressButtonCancel,
    String? buttonOkText = 'OK',
    String? buttonCancelText = 'Cancel',
    Color primaryButtonColor = DeasyColor.kpYellow500,
    Color secondaryButtonColor = DeasyColor.neutral000,
    bool barrierDismissible = true,
    double radius = 10.0,
    double buttonOkTextSize = 16.0,
    double buttonCancelTextSize = 16.0,
    Direction direction = Direction.vertical,
  }) {
    Size screenSize = MediaQuery.of(context).size;
    double _width = screenSize.width / (screenSize.aspectRatio * 1.8);
    Widget dialog = WillPopScope(
        child: DeasySimpleDialog(
          height: height,
          width: width ?? _width,
          title: title,
          subTitleTextAlign: subTitleTextAlign,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          subTitle: subTitle,
          buttonOkText: buttonOkText,
          buttonCancelText: buttonCancelText,
          primaryButtonColor: primaryButtonColor,
          secondaryButtonColor: secondaryButtonColor,
          onPressButtonOk: onPressButtonOk,
          onPressButtonCancel: onPressButtonCancel,
          radius: radius,
          barrierDismissible: barrierDismissible,
          buttonOkTextSize: buttonOkTextSize,
          buttonCancelTextSize: buttonCancelTextSize,
          direction: direction,
        ),
        onWillPop: () => Future.value(barrierDismissible));

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  customContentDialog({
    required BuildContext context,
    required Widget content,
    double? width,
    double? height,
    bool barrierDismissible = true,
    double radius = 10.0,
  }) {
    Size screenSize = MediaQuery.of(context).size;
    double _width = screenSize.width / (screenSize.aspectRatio * 1.8);
    Widget dialog = WillPopScope(
        child: DeasyCustomContentDialog(
          height: height,
          width: width ?? _width,
          content: content,
          radius: radius,
        ),
        onWillPop: () => Future.value(barrierDismissible));

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
