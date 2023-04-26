import 'dart:convert';
import 'dart:typed_data';
import "package:pointycastle/export.dart";

import "./convert_helper.dart";

// AES key size
const KEY_SIZE = 32; // 32 byte key for AES-256
const ITERATION_COUNT = 1000;

class AesHelper {
  static const CBC_MODE = 'CBC';
  static const CFB_MODE = 'CFB';

  final String key;

  AesHelper({required this.key});

  String encrypt(String plaintext, {String mode = CFB_MODE}) {
    Uint8List derivedKey = createUint8ListFromString(key);
    Uint8List textBytes = createUint8ListFromString(plaintext);
    int blockSize = textBytes.length;

    KeyParameter keyParam = new KeyParameter(derivedKey);
    BlockCipher aes = AESEngine();

    var rnd = FortunaRandom();
    rnd.seed(keyParam);
    Uint8List iv = rnd.nextBytes(aes.blockSize);

    BlockCipher cipher;
    ParametersWithIV params = new ParametersWithIV(keyParam, iv);
    switch (mode) {
      case CBC_MODE:
        cipher = new CBCBlockCipher(aes);
        break;
      case CFB_MODE:
        cipher = new CFBBlockCipher(aes, blockSize);
        break;
      default:
        throw new ArgumentError('incorrect value of the "mode" parameter');
        break;
    }
    cipher.init(true, params);

    Uint8List cipherBytes = _processBlocks(cipher, textBytes);
    Uint8List cipherIvBytes = new Uint8List(cipherBytes.length + iv.length)
      ..setAll(0, iv)
      ..setAll(iv.length, cipherBytes);

    return base64.encode(cipherIvBytes);
  }

  String decrypt(String ciphertext, {String mode = CFB_MODE}) {
    Uint8List derivedKey = createUint8ListFromString(key);
    KeyParameter keyParam = new KeyParameter(derivedKey);
    BlockCipher aes = new AESEngine();

    Uint8List cipherIvBytes = base64.decode(ciphertext);
    Uint8List iv = new Uint8List(aes.blockSize)
      ..setRange(0, aes.blockSize, cipherIvBytes);

    int blockSize = cipherIvBytes.length - iv.length;

    BlockCipher cipher;
    ParametersWithIV params = new ParametersWithIV(keyParam, iv);
    switch (mode) {
      case CBC_MODE:
        cipher = new CBCBlockCipher(aes);
        break;
      case CFB_MODE:
        cipher = new CFBBlockCipher(aes, blockSize);
        break;
      default:
        throw new ArgumentError('incorrect value of the "mode" parameter');
        break;
    }
    cipher.init(false, params);

    int cipherLen = cipherIvBytes.length - aes.blockSize;
    Uint8List cipherBytes = new Uint8List(cipherLen)
      ..setRange(0, cipherLen, cipherIvBytes, aes.blockSize);
    Uint8List textByte = _processBlocks(cipher, cipherBytes);

    return new String.fromCharCodes(textByte);
  }

  static Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
    var out = new Uint8List(inp.lengthInBytes);

    for (var offset = 0; offset < inp.lengthInBytes;) {
      var len = cipher.processBlock(inp, offset, out, offset);
      offset += len;
    }

    return out;
  }
}