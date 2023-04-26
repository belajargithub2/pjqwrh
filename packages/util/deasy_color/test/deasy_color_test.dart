import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/deasy_color.dart';

void main() {
  test('combine colors', () {
    final result = DeasyColor.combineMultipleColor(
        [DeasyColor.sally500, DeasyColor.sally400]);
    expect(result, Color(0xff4c9aff));
  });
}
