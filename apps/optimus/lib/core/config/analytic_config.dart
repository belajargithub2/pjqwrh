import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticConfig {
  Future<void> sendEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    try {
      if (kIsWeb) {
        eventName = "web_" + eventName;
      } else if (Platform.isIOS) {
        eventName = "iOS_" + eventName;
      } else if (Platform.isAndroid) {
        eventName = "and_" + eventName;
      }
      await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameters);
    } catch (e) {
      print("ANALYTIC ERROR: $e");
    }
  }

  Future<void> sendEventStart(String eventName, {Map<String, dynamic>? requestBody}) async {
    await sendEvent(eventName + "_Start", parameters: requestBody);
  }

  Future<void> sendEventSuccess(String eventName, {Map<String, dynamic>? requestBody}) async {
    await sendEvent(eventName + "_Success", parameters: requestBody);
  }

  Future<void> sendEventFailed(String eventName, {Map<String, dynamic>? requestBody}) async {
    await sendEvent(eventName + "_Failed", parameters: requestBody);
  }

  Future<void> sendEventAccess(String eventName, {Map<String, dynamic>? requestBody}) async {
    await sendEvent(eventName + "_Access", parameters: requestBody);
  }

  Future<void> sendEventRetry(String eventName, {Map<String, dynamic>? requestBody}) async {
    await sendEvent(eventName + "_Retry", parameters: requestBody);
  }
}