
import '../../lib/src/deasy_device_info.dart';

class DeasyDeviceInfoMock implements DeasyDeviceInfo {
  @override
  Future<String> getBrowserType() {
    return Future.value("tesBrowserType");
  }

  @override
  Future<String> getBrowserVersion() {
    return Future.value("tesBrowserVersion");
  }

  @override
  Future<String> getDeviceId() {
    return Future.value("tesid");
  }

  @override
  Future<String> getDeviceModel() {
    return Future.value("tesDeviceModel");
  }

  @override
  Future<String> getDeviceOs() {
    return Future.value("tesDeviceOs");
  }
}
