import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

Widget bumblebeeCircleIndicator(bool isActive) {
  final selectedColor =
      isActive ? DeasyColor.semanticInfo300 : DeasyColor.neutral400;
  return Container(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: DeasySizeConfigUtils.isDesktopOrWeb
              ? 21.0
              : DeasySizeConfigUtils.isTab
                  ? 20.0
                  : 19.0,
          height: DeasySizeConfigUtils.isDesktopOrWeb
              ? 21.0
              : DeasySizeConfigUtils.isTab
                  ? 20.0
                  : 19.0,
          decoration: new BoxDecoration(
            color: selectedColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: DeasySizeConfigUtils.isDesktopOrWeb
              ? 19.0
              : DeasySizeConfigUtils.isTab
                  ? 18.0
                  : 17.0,
          height: DeasySizeConfigUtils.isDesktopOrWeb
              ? 19.0
              : DeasySizeConfigUtils.isTab
                  ? 18.0
                  : 17.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: DeasySizeConfigUtils.isDesktopOrWeb
              ? 14.0
              : DeasySizeConfigUtils.isTab
                  ? 13.0
                  : 12.0,
          height: DeasySizeConfigUtils.isDesktopOrWeb
              ? 14.0
              : DeasySizeConfigUtils.isTab
                  ? 13.0
                  : 12.0,
          decoration: new BoxDecoration(
            color: selectedColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );
}
