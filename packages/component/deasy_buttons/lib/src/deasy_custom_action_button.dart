import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';


class DeasyCustomActionButton extends StatelessWidget {
  int? width;
  int? height;
  Color? bgColor;
  int? borderWidth;
  Color? borderColor;
  int? borderRadius;
  Function? onPressed;
  String? text;
  Color? textColor;
  double? padding;
  double? fontSize;

  DeasyCustomActionButton({
    this.width,
    this.height,
    this.bgColor,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.onPressed,
    this.text,
    this.textColor,
    this.padding,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
    constraints:
        BoxConstraints.tightFor(width: width as double? ?? 120, height: height as double? ?? 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColor ?? DeasyColor.kpYellow500,
        side: BorderSide(width: borderWidth as double? ?? 1, color: borderColor ?? DeasyColor.kpYellow500),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius as double? ?? 10),
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Text(
          text ?? '',
          style: TextStyle(color: textColor ?? DeasyColor.neutral000, fontSize: fontSize ?? 14),
        ),
      ),
    ),
  );
  }
}