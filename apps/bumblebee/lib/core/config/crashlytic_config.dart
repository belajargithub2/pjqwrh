import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashLyticConfig {

  static Future<void> init() async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kReleaseMode);

    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
        );
      }).sendPort);

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  }

  Future<void> setKeyUser(String supplierId) async {
    if(!kIsWeb){
      FirebaseCrashlytics.instance.setUserIdentifier(supplierId);
      await FirebaseCrashlytics.instance.setCustomKey('supplierId', supplierId);
    }
  }

  Future<void> crash() async {
    FirebaseCrashlytics.instance.crash();
  }
}
