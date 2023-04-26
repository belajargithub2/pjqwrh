import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_email_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

import '../../mocks/repositories/login_repository_mock.dart';
import '../../mocks/shared_preferences_mock.dart';


class LoginControllerMock extends GetxController
    with Mock
    implements OptimusLoginController {}

class MenuRoleRepositoryMock extends GetxController
    with Mock
    implements OptimusMenuRoleRepository {}

void main() {
  setFlavor(DevFlavorConfig());
  late OptimusLoginEmailController controller;

  final binding = BindingsBuilder(() {
    Get.lazyPut<OptimusLoginController>(() => LoginControllerMock());
    Get.lazyPut<OptimusLoginEmailController>(
      () => OptimusLoginEmailController(
        loginRepository: LoginRepositoryMock(),
        menuRoleRepository: MenuRoleRepositoryMock(),
      ),
    );
  });

  setUp(() async {
    await Firebase.initializeApp();

    SharedPreferences.setMockInitialValues({});
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{};
      }
      return null;
    });

    binding.builder();

    controller = Get.find<OptimusLoginEmailController>();
  });

  group('Test Login Controller', () {
    test('Test Init Controller', () async {
      // check if onInit was called
      expect(controller.initialized, isTrue);

      var mock = new MockSharedPreferences();
      controller.sharedPreference = Future.value(mock);

      // await time request
      await Future.delayed(Duration(milliseconds: 100));

      //check controller isRegistered
      bool test = Get.isRegistered<OptimusLoginEmailController>();
      expect(test, true);
    });

    test('onReady', (() async {
      controller.onReady();
    }));

    //Test case still not working
    test('post login api', () async {
      //act
      controller.postApiLogin("email", "password");
    });

    test('clear email value', () {
      //arange
      //act
      controller.clearEmailValue();

      //assert
      expect(controller.emailController.text, isEmpty);
      expect(controller.isShowingClearButton.value, isFalse);
    });

    group('handle verification', () {
      test('validation if fill empty', () {
        //arrange
        //act
        controller.handleVerification('');

        //assert
        expect(controller.isShowingClearButton.value, isFalse);
      });
      test('validation if fill not empty', () {
        //arrange
        //act
        controller.handleVerification('value');

        //assert
        expect(controller.isShowingClearButton.value, isTrue);
      });
    });

    test('save local data', (() async {
      //arange
      OptimusLoginResponse loginMatcher = OptimusLoginResponse(
        code: 0,
        message: 'a',
        data: LoginData(
          id: 'a',
          supplierId: 'a',
          name: 'a',
          email: 'email',
          isMerchantOnline: true,
          isVerified: true,
          role: 'a',
          roleId: 'a',
          accessToken: 'token',
          refreshToken: 'refreshtoken',
          expire: 1,
          deviceId: 'deviceId',
          lastLoginDate: DateTime(2021),
          code: 's',
          message: 's',
        ),
      );

      //act
      await controller.onLoginSuccess(loginMatcher);

      //assert
      expect(controller.isLoading, isFalse);
    }));

    test('onClose was called', (() {
      Get.delete<OptimusLoginEmailController>();
    }));
  });
}

class FakeSharedPreferencesStore implements SharedPreferencesStorePlatform {
  FakeSharedPreferencesStore(Map<String, Object> data)
      : backend = InMemorySharedPreferencesStore.withData(data);

  final InMemorySharedPreferencesStore backend;
  final List<MethodCall> log = <MethodCall>[];

  @override
  bool get isMock => true;

  @override
  Future<bool> clear() {
    log.add(const MethodCall('clear'));
    return backend.clear();
  }

  @override
  Future<Map<String, Object>> getAll() {
    log.add(const MethodCall('getAll'));
    return backend.getAll();
  }

  @override
  Future<bool> remove(String key) {
    log.add(MethodCall('remove', key));
    return backend.remove(key);
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) {
    log.add(MethodCall('setValue', <dynamic>[valueType, key, value]));
    return backend.setValue(valueType, key, value);
  }
}
