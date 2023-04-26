import 'package:deasy_size_config/deasy_size_config.dart';

extension DeasyResponsiveExt on num {

  // https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units

  /// The respective value in centimeters
  double get cm => this * 37.8;

  /// The respective value millimeters
  double get mm => this * 3.78;

  /// The respective value in quarter-millimeters
  double get Q => this * 0.945;

  /// The respective value in inches
  double get inches => this * 96;

  /// The respective value in picas (1/6th of 1 inch)
  double get pc => this * 16;

  /// The respective value in points (1/72th of 1 inch)
  double get pt => this * inches / 72;

  /// The respective value in pixels (default)
  double get px => this.toDouble();

  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * DeasySizeConfigUtils.screenHeight! / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's width
  double get w => this * DeasySizeConfigUtils.screenWidth! / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's pixel
  /// density and aspect ratio
  double get sp => this * (((h + w) + (DeasySizeConfigUtils.pixelRatio * DeasySizeConfigUtils.aspectRatio)) / 2.08) / 100;

  /// Calculates the material dp (Pixel Density)
  /// (https://material.io/design/layout/pixel-density.html#pixel-density-on-android))
  double get dp => this * (w * 160) / DeasySizeConfigUtils.pixelRatio;
}