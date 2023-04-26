import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

Widget optimusLine(bool isActive) {
  return Expanded(
    flex: 1,
    child: Container(
      height: 1,
      color: isActive ? DeasyColor.semanticInfo300 : DeasyColor.neutral400,
    ),
  );
}
