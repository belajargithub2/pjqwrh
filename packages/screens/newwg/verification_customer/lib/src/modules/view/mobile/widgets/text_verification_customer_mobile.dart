import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class TextVerificationCustomerMobile extends StatelessWidget {
  final String title;
  final String value;
  final double fontSize;
  final double space;

  const TextVerificationCustomerMobile({
    super.key,
    required this.title,
    required this.value,
    required this.fontSize,
    this.space = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
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
              flex: 5,
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
    );
  }
}
