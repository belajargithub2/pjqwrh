import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helpers {
  @visibleForTesting
  final methodChannel = const MethodChannel('itruzz_plugin');

  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<String?> getIkid() async {
    final ikid = await methodChannel.invokeMethod<String>('getIkid');
    return ikid;
  }
}