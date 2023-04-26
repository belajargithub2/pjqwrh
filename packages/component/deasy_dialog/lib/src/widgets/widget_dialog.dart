import 'package:deasy_color/deasy_color.dart';
import 'package:flutter/material.dart';
import 'package:deasy_text/deasy_text.dart';

class DeasyWidgetDialog extends StatelessWidget {
  final String? buttonText;
  final Widget? icon;
  final String? title;
  final Widget? body;
  final bool btnEnable;
  final Function()? btnPress;

  const DeasyWidgetDialog({
    Key? key,
    this.icon,
    required this.buttonText,
    required this.title,
    required this.body,
    required this.btnPress,
    this.btnEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon ?? const SizedBox(),
        const SizedBox(
          height: 5,
        ),
        DeasyTextView(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.center,
          fontSize: 20,
          fontColor: Colors.black,
          fontFamily: FontFamily.medium,
          margin: const EdgeInsets.symmetric(horizontal: 30),
        ),
        const SizedBox(
          height: 5,
        ),
        body ?? const SizedBox(),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: btnEnable ? DeasyColor.kpYellow500 : DeasyColor.neutral200,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: InkWell(
            onTap: btnEnable ? btnPress : null,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: DeasyTextView(
                  text: buttonText,
                  fontColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
