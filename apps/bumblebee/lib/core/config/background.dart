import 'dart:io';

import 'package:kreditplus_deasy_mobile/core/config/crashlytic_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_http_override.dart';
import 'package:kreditplus_deasy_mobile/core/source/local/hive_service.dart';
import 'package:flutter/foundation.dart';
import 'fcm_config.dart';

Future<void> runBackground() async {
  topLevelHandler();
  FirebaseConfig.showNotificationForeground();
  CrashLyticConfig.init();
  DynamicLinkConfig().initDynamicLinks();
  await hive.init();

  if (kDebugMode) {
    HttpOverrides.global = new MyHttpOverrides();
  }
}
