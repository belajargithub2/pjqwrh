import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics_platform_interface/firebase_crashlytics_platform_interface.dart';

typedef MethodCallCallback = dynamic Function(MethodCall methodCall);
typedef Callback = void Function(MethodCall call);

void setupFirebaseCrashlyticsMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

void handleMethodCall(MethodCallCallback methodCallCallback) =>
    MethodChannelFirebaseCrashlytics.channel
        .setMockMethodCallHandler((call) async {
      return await methodCallCallback(call);
    });

Future<void> testExceptionHandling(String type, Function testMethod) async {
  try {
    await testMethod();
  } on FirebaseException catch (_) {
    if (type == 'PLATFORM' || type == 'EXCEPTION') {
      return;
    }
    fail(
        'testExceptionHandling: $testMethod threw unexpected FirebaseException');
  } catch (e) {
    fail('testExceptionHandling: $testMethod threw invalid exception $e');
  }
}

class TestFirebaseCrashlyticsPlatform extends FirebaseCrashlyticsPlatform {
  TestFirebaseCrashlyticsPlatform(FirebaseApp app) : super(appInstance: app);
}
