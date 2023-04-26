import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'base_device.dart';

class DeviceManagerImpl extends DeviceManager {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Future<String?> getDeviceId() async {
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
  }

  @override
  Future<String?> getDeviceModel() async {
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    } else {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
  }

  @override
  Future<String> getDeviceOs() async {
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      String osInfo = Platform.operatingSystem + " " + iosInfo.systemVersion!;
      return osInfo;
    } else {
      var androidInfo = await deviceInfo.androidInfo;
      String osInfo = Platform.operatingSystem + " " + androidInfo.version.release;
      return osInfo;
    }
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}