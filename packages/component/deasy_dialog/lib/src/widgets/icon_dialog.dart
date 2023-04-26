import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/src/utils/deasy_dialog_enum.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class DeasyIconDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? icon;
  final double? width;
  final double? height;
  final TextAlign? subTitleTextAlign;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Function? onPressButtonOk;
  final Function? onPressButtonCancel;
  final String? buttonOkText;
  final String? buttonCancelText;
  final double? buttonOkTextSize;
  final double? buttonCancelTextSize;
  final Color? okPrimaryButtonColor;
  final Color? okBorderButtonColor;
  final Color? okTextButtonColor;
  final Color? cancelPrimaryButtonColor;
  final Color? cancelBorderButtonColor;
  final Color? cancelTextButtonColor;
  final double? radius;
  final double? fontSizeTitle;
  final double? fontSizeSubTitle;
  final int? maxlineSubtitle;
  final Widget? customSubtitleWidget;
  final Direction? direction;
  final double? dialogMargin;
  final double? iconTopMargin;
  final double? iconBottomMargin;
  final double? titleBottomMargin;

  const DeasyIconDialog({
    this.title,
    this.subTitle,
    this.width,
    this.height,
    this.subTitleTextAlign,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.onPressButtonOk,
    this.onPressButtonCancel,
    this.buttonOkText,
    this.buttonCancelText,
    this.buttonOkTextSize,
    this.buttonCancelTextSize,
    this.okPrimaryButtonColor,
    this.okBorderButtonColor,
    this.okTextButtonColor,
    this.cancelPrimaryButtonColor,
    this.cancelBorderButtonColor,
    this.cancelTextButtonColor,
    this.radius,
    this.icon,
    this.fontSizeTitle,
    this.fontSizeSubTitle,
    this.maxlineSubtitle,
    this.customSubtitleWidget,
    this.direction = Direction.vertical,
    this.dialogMargin,
    this.iconTopMargin,
    this.iconBottomMargin,
    this.titleBottomMargin
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(dialogMargin ?? 24),
        child: direction == Direction.vertical
            ? verticalButton()
            : horizontalButton(),
      ),
    );
  }

  Widget verticalButton() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: mainAxisAlignment!,
            crossAxisAlignment: crossAxisAlignment!,
            children: [
              SizedBox(height: iconTopMargin ?? 10),
              icon!,
              SizedBox(height: iconBottomMargin ?? 30),
              DeasyTextView(
                  text: title,
                  fontSize: fontSizeTitle!,
                  fontColor: DeasyColor.neutral800,
                  maxLines: 2,
                  textAlign: subTitleTextAlign!,
                  fontFamily: FontFamily.medium),
              SizedBox(height: titleBottomMargin ?? 24),
              customSubtitleWidget != null
                ? customSubtitleWidget!
                : subTitle != null
                  ? DeasyTextView(
                      text: subTitle,
                      fontSize: fontSizeSubTitle!,
                      textAlign: subTitleTextAlign!,
                      fontColor: DeasyColor.neutral400,
                      maxLines: maxlineSubtitle ?? 4)
                  : SizedBox(),
              SizedBox(height: 30),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Column(
            children: [
              Visibility(
                visible: onPressButtonOk != null,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: DeasyCustomElevatedButton(
                    primary: okPrimaryButtonColor,
                    borderColor: okBorderButtonColor,
                    onPress: onPressButtonOk,
                    paddingButton: 9,
                    fontSize: buttonOkTextSize ?? 16.0,
                    text: buttonOkText,
                    textColor: okTextButtonColor,
                  ),
                ),
              ),
              Visibility(
                visible: onPressButtonCancel != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: double.infinity),
                    child: DeasyCustomElevatedButton(
                      primary: cancelPrimaryButtonColor,
                      borderColor: cancelBorderButtonColor,
                      paddingButton: 9,
                      onPress: onPressButtonCancel,
                      fontSize: buttonCancelTextSize ?? 16.0,
                      text: buttonCancelText,
                      textColor: cancelTextButtonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget horizontalButton() {
    return Column(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: crossAxisAlignment!,
      children: [
        SizedBox(height: iconTopMargin ?? 10),
        icon!,
        SizedBox(height: iconBottomMargin ?? 30),
        DeasyTextView(
            text: title,
            fontSize: fontSizeTitle!,
            fontColor: DeasyColor.neutral800,
            maxLines: 2,
            textAlign: subTitleTextAlign!,
            fontFamily: FontFamily.medium),
        SizedBox(height: titleBottomMargin ?? 24),
        DeasyTextView(
            text: subTitle,
            fontSize: fontSizeSubTitle!,
            textAlign: subTitleTextAlign!,
            fontColor: DeasyColor.neutral400,
            maxLines: maxlineSubtitle ?? 4),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: onPressButtonOk != null,
              child: Expanded(
                child: DeasyCustomElevatedButton(
                  primary: okPrimaryButtonColor,
                  borderColor: okBorderButtonColor,
                  onPress: onPressButtonOk,
                  paddingButton: 9,
                  fontSize: buttonOkTextSize ?? 16.0,
                  text: buttonOkText,
                  textColor: okTextButtonColor,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Visibility(
              visible: onPressButtonCancel != null,
              child: Expanded(
                child: DeasyCustomElevatedButton(
                  primary: cancelPrimaryButtonColor,
                  borderColor: cancelBorderButtonColor,
                  paddingButton: 9,
                  onPress: onPressButtonCancel,
                  fontSize: buttonCancelTextSize ?? 16.0,
                  text: buttonCancelText,
                  textColor: cancelTextButtonColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}