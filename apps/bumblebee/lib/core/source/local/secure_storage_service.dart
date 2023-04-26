import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:deasy_config/deasy_config.dart';
final SecureStorageService secureStorageService = SecureStorageService.instance;

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService();

  static SecureStorageService get instance => _instance;

  Future<Uint8List> getEncryptionKey() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final String? savedEncryptionKey = await secureStorage.read(key: flavorConfiguration!.deasyLocalKey);
    if (savedEncryptionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: flavorConfiguration!.deasyLocalKey,
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: flavorConfiguration!.deasyLocalKey);
    final encryptionKey = base64Url.decode(key!);
    return encryptionKey;
  }
}