import 'package:flutter/material.dart';

class DeasyTextView extends StatelessWidget {
  final String? text;
  final EdgeInsets margin;
  final FontFamily fontFamily;
  final double? fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final int maxLines;
  final bool isSelectable;
  final double lineHeight;
  final double letterSpacing;

  DeasyTextView(
      {Key? key,
        required this.text,
        this.margin = const EdgeInsets.all(0),
        this.fontFamily = FontFamily.light,
        this.fontSize = 14,
        this.fontColor = Colors.black,
        this.textAlign = TextAlign.start,
        this.overflow = TextOverflow.fade,
        this.fontWeight = FontWeight.w400,
        this.maxLines = 1,
        this.isSelectable = false,
        this.lineHeight = 0.0,
        this.letterSpacing = 0.0,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: isSelectable
          ? SelectableText(text!,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
              fontWeight: fontWeight,
              fontFamily: getFontFamily(fontFamily),
              color: fontColor,
              fontSize: fontSize))
          : Text(text!,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
              height: lineHeight ?? null,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontFamily: getFontFamily(fontFamily),
              color: fontColor,
              fontSize: fontSize)),
    );
  }
}

enum FontFamily { light, medium, bold }

String getFontFamily(FontFamily fontType) {
  switch (fontType) {
    case FontFamily.light:
      return "KBFGDisplayLight";
    case FontFamily.medium:
      return "KBFGDisplayMedium";
    case FontFamily.bold:
      return "KBFGDisplayBold";
    default:
      return "KBFGDisplayLight";
  }
}
