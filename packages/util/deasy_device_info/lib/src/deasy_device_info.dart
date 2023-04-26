// import 'package:deasy_device_info/src/platform_impl/device_stub.dart'
import 'platform_impl/device_stub.dart'
if (dart.library.io) 'platform_impl/device_info_mobile.dart'
if (dart.library.html) 'platform_impl/device_info_web.dart';

class DeasyDeviceInfo {
  final DeviceManagerImpl _deviceManager;

  DeasyDeviceInfo() : _deviceManager = DeviceManagerImpl();


  Future<String?> getDeviceId() async {
    return await _deviceManager.getDeviceId();
  }

  Future<String?> getDeviceModel() async {
    return await _deviceManager.getDeviceModel();
  }

  Future<String?> getDeviceOs() async {
    return await _deviceManager.getDeviceOs();
  }

  Future<String?> getBrowserType() async {
    return await _deviceManager.getBrowserType();
  }

  Future<String?> getBrowserVersion() async {
    return await _deviceManager.getBrowserVersion();
  }
}
