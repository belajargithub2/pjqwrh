import 'package:flutter_test/flutter_test.dart';

import '../lib/deasy_service.dart';


void main() {
  test('isWeb', () {
    DeasyService service = DeasyService();
    bool isWeb = service.getkIsWeb();
    expect(isWeb, true);
  });
}
