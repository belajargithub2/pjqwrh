import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';

class DeasyCustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? colorText;
  final Color? borderSideColor;
  final Function? onPressed;
  final TextStyle? textStyle;
  final double radius;
  final bool enable;

  const DeasyCustomButton(
    {required this.text,
    required this.onPressed,
    this.colorText,
    this.color,
    this.borderSideColor,
    this.textStyle,
    this.radius = 8.0,
    this.enable = true});
    
  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeasySizeConfigUtils.isDesktopOrWeb ? 50.0 : 40,
      child: TextButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
                width: 1.0,
                color: borderSideColor == null
                    ? Theme.of(context).buttonColor
                    : borderSideColor!)),
            backgroundColor: MaterialStateProperty.all<Color?>(
                color ?? Theme.of(context).buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius))))),
        child: Text(text,
            style: textStyle ?? TextStyle(
                    fontSize: 14, color: colorText ?? Colors.white)),
        onPressed: () {
          if (onPressed != null && enable == true) onPressed!();
        },
      ),
    );
  }
}