import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeasySizeConfigUtils {
  static double? screenWidth;
  static double? screenHeight;
  static double? blockHorizontal;
  static late double blockVertical;
  static late bool isMobile;
  static late bool isDesktopOrWeb;
  static late bool isTab;
  static late double pixelRatio;
  static late double aspectRatio;
  static BoxConstraints? boxConstraints;
  static Orientation? orientation;


  void init({BuildContext? context}) {
    screenWidth = context != null ? MediaQuery.of(context).size.width : Get.width;
    screenHeight = context != null ? MediaQuery.of(context).size.height : Get.height;
    blockHorizontal = screenWidth! / 100;
    blockVertical = screenHeight! / 100;
    isDesktopOrWeb = screenWidth! >= 1300;
    isMobile = screenWidth! < 650;
    isTab = screenWidth! < 1300 && screenWidth! >= 650;
  }

  static void setScreenSize(BoxConstraints constraints) {
    boxConstraints = constraints;
    aspectRatio = constraints.constrainDimensions(screenWidth!, screenHeight!).aspectRatio;
    pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
  }

}
