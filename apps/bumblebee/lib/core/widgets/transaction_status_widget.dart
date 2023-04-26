import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionStatusWidget extends GetView {
  final String labelText;
  final Color labelColor;
  final String iconAsset;
  final Color backgroundColor;

  TransactionStatusWidget(
      {required this.labelText,
      required this.labelColor,
      required this.iconAsset,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            SvgPicture.asset(iconAsset, height: 14,),
            const SizedBox(
              width: 10,
            ),
            Text(
              labelText,
              style: TextStyle(
                  fontSize: 10, color: labelColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
