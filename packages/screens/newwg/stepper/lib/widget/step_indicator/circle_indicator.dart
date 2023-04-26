import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

Widget circleIndicator(bool isActive, Color activeColor) {
  final selectedColor = isActive ? activeColor : DeasyColor.neutral400;

  return Stack(
    alignment: Alignment.center,
    children: DeasySizeConfigUtils.isDesktopOrWeb
        ? [
            _circleIndicator(selectedColor, 21),
            _circleIndicator(DeasyColor.neutral000, 19),
            _circleIndicator(selectedColor, 14),
          ]
        : DeasySizeConfigUtils.isTab
            ? [
                _circleIndicator(selectedColor, 20),
                _circleIndicator(DeasyColor.neutral000, 18),
                _circleIndicator(selectedColor, 13),
              ]
            : [
                _circleIndicator(selectedColor, 19),
                _circleIndicator(DeasyColor.neutral000, 17),
                _circleIndicator(selectedColor, 12),
              ],
  );
}

Container _circleIndicator(Color color, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}
