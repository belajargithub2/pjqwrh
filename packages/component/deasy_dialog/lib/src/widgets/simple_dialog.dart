import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/src/utils/deasy_dialog_enum.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class DeasySimpleDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final double width;
  final double height;
  final TextAlign subTitleTextAlign;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Function? onPressButtonOk;
  final Function? onPressButtonCancel;
  final String? buttonOkText;
  final String? buttonCancelText;
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final bool barrierDismissible;
  final double radius;
  final double buttonOkTextSize;
  final double buttonCancelTextSize;
  final Direction? direction;

  const DeasySimpleDialog({
    this.title,
    this.subTitle,
    this.width = 300.0,
    this.height = 190.0,
    this.subTitleTextAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onPressButtonOk,
    this.onPressButtonCancel,
    this.buttonOkText = 'OK',
    this.buttonCancelText = 'Cancel',
    this.primaryButtonColor = DeasyColor.kpYellow500,
    this.secondaryButtonColor = DeasyColor.neutral000,
    this.barrierDismissible = true,
    this.radius = 10.0,
    this.buttonOkTextSize = 16.0,
    this.buttonCancelTextSize = 16.0,
    this.direction = Direction.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(24),
        child: direction == Direction.vertical
            ? verticalButton()
            : horizontalButton(),
      ),
    );
  }

  Widget verticalButton() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            SizedBox(height: 20),
            DeasyTextView(
                text: title,
                fontSize: 24,
                fontColor: DeasyColor.neutral800,
                fontFamily: FontFamily.medium),
            SizedBox(height: 16),
            DeasyTextView(
                text: subTitle,
                fontSize: 16,
                textAlign: subTitleTextAlign,
                fontColor: DeasyColor.neutral400,
                maxLines: 4),
            SizedBox(height: 30),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DeasyCustomElevatedButton(
                          primary: primaryButtonColor,
                          borderColor: primaryButtonColor,
                          onPress: onPressButtonOk,
                          fontSize: buttonOkTextSize,
                          text: buttonOkText,
                          textColor: DeasyColor.neutral000,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: onPressButtonCancel != null,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DeasyCustomElevatedButton(
                            primary: secondaryButtonColor,
                            borderColor: primaryButtonColor,
                            onPress: onPressButtonCancel,
                            fontSize: buttonCancelTextSize,
                            text: buttonCancelText,
                            textColor: primaryButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget horizontalButton() {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SizedBox(height: 20),
        DeasyTextView(
            text: title,
            fontSize: 24,
            fontColor: DeasyColor.neutral800,
            fontFamily: FontFamily.medium),
        SizedBox(height: 16),
        DeasyTextView(
            text: subTitle,
            fontSize: 16,
            textAlign: subTitleTextAlign,
            fontColor: DeasyColor.neutral400,
            maxLines: 4),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: onPressButtonOk != null,
              child: Expanded(
                child: DeasyCustomElevatedButton(
                  primary: DeasyColor.kpYellow500,
                  borderColor: DeasyColor.kpYellow500,
                  onPress: onPressButtonOk,
                  paddingButton: 6,
                  fontSize: 16.0,
                  text: buttonOkText,
                  textColor: DeasyColor.neutral000,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Visibility(
              visible: onPressButtonCancel != null,
              child: Expanded(
                child: DeasyCustomElevatedButton(
                  primary: secondaryButtonColor,
                  borderColor: primaryButtonColor,
                  paddingButton: 6,
                  onPress: onPressButtonCancel,
                  fontSize: 16.0,
                  text: buttonCancelText,
                  textColor: primaryButtonColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
