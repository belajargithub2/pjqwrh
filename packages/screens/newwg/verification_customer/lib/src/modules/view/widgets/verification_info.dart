import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class VerificationInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const VerificationInfo({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: DeasyColor.sally50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: DeasyColor.kpBlue600, // todo: NEWWG-253 change based on App Config (bayu)
            size: 12,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: DeasyTextView(
              text: text,
              fontSize: 12.0,
              maxLines: 4,
              fontColor: DeasyColor.kpBlue600, // todo: NEWWG-253 change based on App Config (bayu)
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
