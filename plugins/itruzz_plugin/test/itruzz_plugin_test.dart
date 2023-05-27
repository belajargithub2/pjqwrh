import 'package:flutter_test/flutter_test.dart';
import 'package:itruzz_plugin/itruzz_plugin.dart';
import 'package:itruzz_plugin/itruzz_plugin_platform_interface.dart';
import 'package:itruzz_plugin/itruzz_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockItruzzPluginPlatform
    with MockPlatformInterfaceMixin
    implements ItruzzPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ItruzzPluginPlatform initialPlatform = ItruzzPluginPlatform.instance;

  test('$MethodChannelItruzzPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelItruzzPlugin>());
  });

  test('getPlatformVersion', () async {
    ItruzzPlugin itruzzPlugin = ItruzzPlugin();
    MockItruzzPluginPlatform fakePlatform = MockItruzzPluginPlatform();
    ItruzzPluginPlatform.instance = fakePlatform;

    expect(await itruzzPlugin.getPlatformVersion(), '42');
  });
}
