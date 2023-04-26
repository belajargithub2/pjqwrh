import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class ContentDialogWithTwoButtonsWidget extends GetView {
  final String leftButtonText;
  final String rightButtonText;
  final String contentTitle;
  final String contentSubTitle;
  final void Function() leftBtnOnPress;
  final void Function() rightBtnOnPress;

  ContentDialogWithTwoButtonsWidget({
    required this.leftButtonText,
    required this.rightButtonText,
    required this.contentTitle,
    required this.contentSubTitle,
    required this.leftBtnOnPress,
    required this.rightBtnOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          IconConstant.RESOURCES_ICON_WARNING_PATH,
        ),
        SizedBox(
          height: 24,
        ),
        DeasyTextView(
          text: contentTitle,
          fontSize: 20,
          fontColor: DeasyColor.neutral900,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DeasyTextView(
            text: contentSubTitle,
            fontSize: 16,
            fontColor: DeasyColor.neutral900.withOpacity(0.4),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: DeasyCustomElevatedButton(
                  text: leftButtonText,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  paddingButton: 12,
                  onPress: leftBtnOnPress),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: DeasyCustomElevatedButton(
                  text: rightButtonText,
                  paddingButton: 12,
                  textColor: DeasyColor.kpYellow500,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.neutral000,
                  onPress: rightBtnOnPress),
            )
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
