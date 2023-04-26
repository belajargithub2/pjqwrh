
import 'package:encrypt/encrypt.dart';

class DeasyEncryptorUtil {
  static String encryptString(String string, {String? opsionalKey}) {
    Key key = Key.fromUtf8(opsionalKey ?? "DEASY cAwoar2jTf7nZWAp7mBHOPpJUh");
    IV iv = IV.fromLength(16);
    Encrypter encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(string, iv: iv);
    return encrypted.base64;
  }

  static String decryptString(String string, {String? opsionalKey}) {
    Key key = Key.fromUtf8(opsionalKey ?? "DEASY cAwoar2jTf7nZWAp7mBHOPpJUh");
    IV iv = IV.fromLength(16);
    Encrypter encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt64(string, iv: iv);
    return decrypted;
  }
}