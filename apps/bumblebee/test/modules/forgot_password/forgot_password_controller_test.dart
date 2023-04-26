import 'package:deasy_repository/deasy_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/bindings/bumblebee_forgot_passowrd_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/controllers/bumblebee_forgot_password_controller.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:deasy_config/deasy_config.dart';

import '../../mocks/build_context_mock.dart';
import '../../mocks/config/dynamic_config_mock.dart';
import '../../mocks/config/firebase_analytics_config_mock.dart';
import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/repository/auth_repository_mock.dart';
import '../../mocks/repository/deep_link_repository_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  final channel = MethodChannel('dev.fluttercommunity.plus/package_info');
  late BumblebeeForgotPasswordController controller;
  MockBuildContext? _mockBuildContext;

  final binding = BindingsBuilder(() {
    BumblebeeForgotPasswordBinding().dependencies();
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
    controller = Get.find<BumblebeeForgotPasswordController>();
  });

  tearDownAll(() {
    Get.delete<BumblebeeForgotPasswordController>();
  });

  group('Test Forgot password Controller', () {


    test('Test Init Controller', () async {
      expect(
        () => Get.find<BumblebeeForgotPasswordController>(tag: 'success'),
        throwsA(TypeMatcher<String>()),
      );

      /// check if onInit was called
      expect(controller.initialized, true);

      /// await time request
      await Future.delayed(Duration(milliseconds: 100));

      ///check controller isRegistered
      bool test = Get.isRegistered<BumblebeeForgotPasswordController>();
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

      Get.delete<BumblebeeForgotPasswordController>();
    });

    test('test set email value', () async {
      controller.setEmailValue("email");

      expect(controller.email.value, equals("email"));
    });
  });
}
