import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/controllers/optimus_forgot_password_controller.dart';
import 'package:kreditplus_deasy_website/core/repositories/auth_repository.dart';
import 'package:kreditplus_deasy_website/core/repositories/deep_link_repository.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/build_context_mock.dart';
import '../../mocks/config/dynamic_config_mock.dart';
import '../../mocks/config/firebase_analytics_config_mock.dart';
import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/repositories/auth_repository_mock.dart';
import '../../mocks/repositories/deep_link_repository_mock.dart';


void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  final channel = MethodChannel('dev.fluttercommunity.plus/package_info');
  late OptimusForgotPasswordController controller;
  MockBuildContext? _mockBuildContext;

  final binding = BindingsBuilder(() {
    OptimusForgotPasswordBinding().dependencies();
    Get.lazyReplace<DeepLinkRepository>(() => DeepLinkRepositoryMock());
    Get.lazyReplace<AuthRepository>(() => AuthRepositoryMock());
    Get.lazyReplace<DynamicLinkConfig>(() => DynamicLinkConfigMock());
    Get.lazyReplace<AnalyticConfig>(() => AnalyticsConfigMock());
  });

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getAll':
        return <String, dynamic>{
          'appName': 'package_info_example',
          'buildNumber': '1',
          'packageName': 'io.flutter.plugins.packageinfoexample',
          'version': '1.0',
        };
      default:
        return null;
    }
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    binding.builder();
    _mockBuildContext = MockBuildContext();
    controller = Get.find<OptimusForgotPasswordController>();
  });

  tearDownAll(() {
    Get.delete<OptimusForgotPasswordController>();
  });

  group('Test Forgot password Controller', () {

    test('Test Init Controller', () async {
      expect(
        () => Get.find<OptimusForgotPasswordController>(tag: 'success'),
        throwsA(TypeMatcher<String>()),
      );

      /// check if onInit was called
      expect(controller.initialized, true);

      /// await time request
      await Future.delayed(Duration(milliseconds: 100));

      ///check controller isRegistered
      bool test = Get.isRegistered<OptimusForgotPasswordController>();
      expect(test, true);
    });

    test('check email if empty', () {
      // final result = controller.validate('');
      // expect(result, false);
    });

    test('check email if not empty', () {
      // final result = controller.validate('bayu.nugroho@kpvendor.id');
      // expect(result, true);
    });

    test('check get token function', () async {
      String? token = await controller.getToken();
      expect(token, "fk9cm52Nr3EQMseY7");
    });

    test('test package info plus', () async {
      String getVersion = await controller.getVersion();

      expect(getVersion, "1.0");
    });

    test('test clear text', () async {
      controller.clearText();

      expect(controller.email.value, "");
    });

    test('test send email', () async {
      String url = "https://deasy.page.link/fk9cm52Nr3EQMseY7";
      String token = "fk9cm52Nr3EQMseY7";
      String email = 'bayu.nugroho@kpvendor.id';

      controller.submit(_mockBuildContext, email);

      expect(controller.isLoading.value, true);
      controller.sendEmail(Uri.parse(url), token).then((value) {
        expect(value!.message, "OK");

        controller.successSendEmail(value);

        expect(value, isNotNull);
      });
    });

    test('test create dynamic link function', () async {
      String url = await controller.createDynamicLink("fk9cm52Nr3EQMseY7");

      expect(url, "https://deasy.page.link/fk9cm52Nr3EQMseY7");

      Get.delete<OptimusForgotPasswordController>();
    });

    test('test set email value', () async {
      controller.setEmailValue("email");

      expect(controller.email.value, equals("email"));
    });
  });
}
