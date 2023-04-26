import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class DeasyOptimusIconDialogTwoButtons extends StatelessWidget {
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
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final double? radius;
  final double? fontSizeTitle;
  final double? fontSizeSubTitle;


  const DeasyOptimusIconDialogTwoButtons({
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
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.radius,
    this.icon,
    this.fontSizeTitle,
    this.fontSizeSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.all(24),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: mainAxisAlignment!,
                  crossAxisAlignment: crossAxisAlignment!,
                  children: [
                    icon!,
                    SizedBox(height: 30),
                    DeasyTextView(
                        text: title,
                        fontSize: fontSizeTitle!,
                        fontColor: DeasyColor.neutral800,
                        maxLines: 2,
                        textAlign: subTitleTextAlign!,
                        fontFamily: FontFamily.medium),
                    SizedBox(height: 20),
                    DeasyTextView(
                        text: subTitle,
                        fontSize: fontSizeSubTitle!,
                        textAlign: subTitleTextAlign!,
                        fontColor: DeasyColor.neutral400,
                        maxLines: 4),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 40,
                right: 40,
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints.tightForFinite(width: 200),
                      child: DeasyCustomElevatedButton(
                        primary: DeasyColor.kpYellow500,
                        borderColor: DeasyColor.kpYellow500,
                        onPress: onPressButtonOk,
                        paddingButton: 9,
                        fontSize: 16.0,
                        text: buttonOkText,
                        textColor: DeasyColor.neutral000,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightForFinite(width: 200),
                        child: DeasyCustomElevatedButton(
                          primary: secondaryButtonColor,
                          borderColor: primaryButtonColor,
                          paddingButton: 9,
                          onPress: onPressButtonCancel,
                          fontSize: 16.0,
                          text: buttonCancelText,
                          textColor: primaryButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
