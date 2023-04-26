import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class TextVerificationConsumer extends StatelessWidget {
  final String title;
  final String value;
  final double fontSize;
  final double space;

  const TextVerificationConsumer({
    super.key,
    required this.title,
    required this.value,
    required this.fontSize,
    this.space = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.0,
      height: 38.0,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 148,
                height: 22,
                child: DeasyTextView(
                  text: title,
                  maxLines: 2,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  fontColor: DeasyColor.neutral500,
                  fontFamily: FontFamily.medium,
                ),
              ),
              SizedBox(width: space),
              Expanded(
                flex: 1,
                child: DeasyTextView(
                  text: value,
                  maxLines: 3,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  fontColor: DeasyColor.neutral800,
                  fontFamily: FontFamily.bold,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
