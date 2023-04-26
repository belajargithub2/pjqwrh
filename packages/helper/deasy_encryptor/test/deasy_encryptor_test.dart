import 'package:flutter_test/flutter_test.dart';

import '../lib/deasy_encryptor.dart';


void main() {
  test('encrypt text', () {
    final encryptedText = DeasyEncryptorUtil.encryptString('test');
    expect(encryptedText, 'RwMvAslq9XG2fE/NksNNvg==');
  });

  test('decrypt text', () {
    final decryptedText = DeasyEncryptorUtil.decryptString('RwMvAslq9XG2fE/NksNNvg==');
    expect(decryptedText, 'test');
  });
}
