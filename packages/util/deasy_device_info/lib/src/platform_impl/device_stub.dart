import 'base_device.dart';

class DeviceManagerImpl extends DeviceManager{

  @override
  Future<String> getDeviceId() {
    throw Exception('Cannot create Device manager');
  }

  @override
  Future<String> getDeviceModel() {
    throw Exception('Cannot create Device manager');
  }

  @override
  Future<String> getDeviceOs() {
    throw Exception('Cannot create Device manager');
  }

  @override
  Future<String> getBrowserType() {
    throw Exception('Cannot create Device manager');
  }

  @override
  Future<String> getBrowserVersion() {
    throw Exception('Cannot create Device manager');
  }
}