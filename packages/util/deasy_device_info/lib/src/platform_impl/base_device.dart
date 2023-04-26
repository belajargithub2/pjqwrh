
abstract class DeviceManager {
  Future<String?> getDeviceId();
  Future<String?> getDeviceModel();
  Future<String?> getDeviceOs();
  Future<String?> getBrowserType();
  Future<String?> getBrowserVersion();
}
