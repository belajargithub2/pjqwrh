import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'itruzz_plugin_method_channel.dart';

abstract class ItruzzPluginPlatform extends PlatformInterface {
  /// Constructs a ItruzzPluginPlatform.
  ItruzzPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ItruzzPluginPlatform _instance = MethodChannelItruzzPlugin();

  /// The default instance of [ItruzzPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelItruzzPlugin].
  static ItruzzPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ItruzzPluginPlatform] when
  /// they register themselves.
  static set instance(ItruzzPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
