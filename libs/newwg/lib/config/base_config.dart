import 'package:flutter/services.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg/config/auth_config.dart';
import 'package:newwg/config/data_config.dart';
import 'package:newwg/config/network_config.dart';

class BaseConfig {
  static MethodChannel channel = const MethodChannel('deasy.newwg');

  static initialConfig() {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'base_config' && call.arguments is Map) {
        AppConfig.instance.fromJson(call.arguments['app_config']);
        AuthConfig.instance.fromJson(call.arguments['auth_config']);
        NetworkConfig.instance.fromJson(call.arguments['network_config']);
        DataConfig.instance.fromJson(call.arguments['data_config']);
      }
    });
  }

  // for callback to native
  static invokeMethod(String methodName, [dynamic args]) {
    try {
      channel.invokeMethod(methodName, args);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
