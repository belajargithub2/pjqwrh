import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';

class DialogContentOneButtonWidget extends GetView {
  final String buttonText;
  final String icon;
  final String contentTitle;
  final String? contentSubTitle;
  final void Function() btnPress;

  DialogContentOneButtonWidget({
    required this.buttonText,
    required this.icon,
    required this.contentTitle,
    required this.contentSubTitle,
    required this.btnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        SizedBox(
          height: 30,
        ),
        DeasyTextView(
          text: contentTitle,
          maxLines: 2,
          textAlign: TextAlign.center,
          fontSize: 20,
          fontColor: DeasyColor.neutral900,
          fontFamily: FontFamily.medium,
          margin: EdgeInsets.symmetric(horizontal: 30),
        ),
        SizedBox(
          height: 5,
        ),
        DeasyTextView(
          margin: EdgeInsets.all(12),
          text: contentSubTitle,
          fontSize: 14,
          fontColor: DeasyColor.neutral900.withOpacity(0.4),
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            width: Get.width * 0.6,
            height: Get.height * 0.06,
            child: BouncingWidget(
              duration: Duration(milliseconds: 100),
              scaleFactor: 1.5,
              onPressed: btnPress,
              child: Container(
                decoration: new BoxDecoration(
                    color: DeasyColor.kpYellow500,
                    borderRadius: new BorderRadius.all(Radius.circular(10.0))),
                width: Get.width / 2,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(color: DeasyColor.neutral000),
                  ),
                )),
              ),
            ))
      ],
    );
  }
}
