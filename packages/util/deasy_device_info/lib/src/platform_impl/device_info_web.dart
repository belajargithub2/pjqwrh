import 'dart:js' as js;
import 'base_device.dart';

class DeviceManagerImpl extends DeviceManager {

  @override
  Future<String?> getDeviceId() async{
    var webInfo = await js.context['uuid'];
    return webInfo;
  }

  @override
  Future<String?> getDeviceOs() async {
    var os = await js.context['os'];
    return os;
  }

  @override
  Future<String?> getBrowserType() async {
    var browserType = await js.context['browserType'];
    return browserType;
  }

  Future<String?> getBrowserVersion() async {
    var browserVersion = await js.context['browserVersion'];
    return browserVersion;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
