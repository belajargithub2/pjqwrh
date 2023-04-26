import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deasy_size_config/deasy_size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test("Should return screen properties", () {
    //arrange

    //act
    DeasySizeConfigUtils().init();

    //assert
    expect(DeasySizeConfigUtils.screenHeight != null, true);
    expect(DeasySizeConfigUtils.screenWidth != null, true);
  });

  test("Should return correct box constraint", () {
    //arrange
    DeasySizeConfigUtils().init();

    final constraint = BoxConstraints(
      minWidth: 150,
      maxWidth: 600,
      minHeight: 300,
      maxHeight: 900,
    );

    //act
    DeasySizeConfigUtils.setScreenSize(constraint);

    //assert
    expect(DeasySizeConfigUtils.boxConstraints, constraint);
  });
}
