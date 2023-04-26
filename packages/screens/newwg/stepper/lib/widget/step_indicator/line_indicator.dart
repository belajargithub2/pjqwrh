import 'package:deasy_color/deasy_color.dart';
import 'package:flutter/material.dart';

Widget lineIndicator(bool isActive, Color activeColor) {
  return Expanded(
    flex: 1,
    child: Container(
      height: 1,
      color: isActive ? activeColor : DeasyColor.neutral400,
    ),
  );
}
