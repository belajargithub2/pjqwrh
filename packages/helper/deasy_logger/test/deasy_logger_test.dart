import 'package:flutter_test/flutter_test.dart';

import '../lib/deasy_logger.dart';


void main() {
  test('adds one to input values', () {
    DeasyLoggerUtil.getLogger("INFO => ").i("UNIT TEST");
  });
}
