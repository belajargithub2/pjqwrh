
import 'itruzz_plugin_platform_interface.dart';

class ItruzzPlugin {
  Future<String?> getPlatformVersion() {
    return ItruzzPluginPlatform.instance.getPlatformVersion();
  }
}
