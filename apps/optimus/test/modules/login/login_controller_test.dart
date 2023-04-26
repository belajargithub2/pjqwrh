import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/models/response/optimus_login_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/device_mock.dart';
import '../../mocks/repositories/user_repository_mock.dart';
import '../../mocks/shared_preferences_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';


void main() {
  setFlavor(DevFlavorConfig());
  OptimusLoginController? controller;

  //Init Dependencies Injection with mock repository
  final binding = BindingsBuilder(() {
    Get.lazyPut<DeasyDeviceInfo>(() => DeviceMock());
    Get.lazyPut<OptimusLoginController>(
      () => OptimusLoginController(
        userRepository: OptimusUserRepositoryMock(),
        snapNBuyRepository: SnapNBuyRepositoryMock(),
      ),
    );
  });

  setUp(() async {
    //Init firebase
    await Firebase.initializeApp();

    //Init Shared Preferences Mock
    SharedPreferences.setMockInitialValues({'email': 'email'});

    //Init Package Info Mock
    PackageInfo.setMockInitialValues(
      appName: "ABC",
      packageName: "A.B.C",
      version: "1.0.0",
      buildNumber: "1.0.0",
      buildSignature: "buildSignature",
      installerStore: '1.0.0',
    );

    binding.builder();

    controller = Get.find<OptimusLoginController>();
  });

  tearDown(() {
    Get.delete<OptimusLoginController>();
  });

  group('Test Login Controller', () {
    test('Test onInit Controller', () async {
      expect(controller, isInstanceOf<OptimusLoginController>());

      // check if onInit was called
      expect(controller!.initialized, isTrue);

      var mock = new MockSharedPreferences();
      controller!.sharedPreference = Future.value(mock);

      // await time request
      await Future.delayed(Duration(milliseconds: 100));

      //check controller isRegistered
      bool test = Get.isRegistered<OptimusLoginController>();
      expect(test, true);
    });

    test('Test onClose Controller', (() {
      Get.delete<OptimusLoginController>();
    }));

    group('Test onReady Controller', () {
      test('onReady isWeb', (() async {
        controller!.onReady();
      }));
    });

    test('Get app version', () async {
      //act
      await controller!.getAppVersion();

      //assert
      expect(controller!.appVersion.value, "1.0.0");
    });

    group('Send login tab event', () {
      test('Email login', () {
        //act
        final result = controller!.sendLoginTabEvent(0);

        //assert
        expect(result, "Login_Email");
      });

      test('Phone login', () {
        //act
        final result = controller!.sendLoginTabEvent(1);

        //assert
        expect(result, "Login_Phone");
      });
    });

    //Test case still not working
    group('save data to local after do login', () {

      test('Save data isWeb true', () async {
        controller!.onReady();

        SharedPreferences pref = await controller!.sharedPreference;
        await pref.setString("fcm_token", 'token');

        final loginData = LoginData(
          id: 'a',
          supplierId: 'a',
          name: 'a',
          email: 'a',
          isMerchantOnline: true,
          isVerified: true,
          role: 'a',
          roleId: 'a',
          accessToken: 'a',
          refreshToken: 'a',
          expire: 1,
          deviceId: 's',
          lastLoginDate: DateTime(2021),
          code: 's',
          message: 's',
          agentId: 20,
          nik: '0976532145',
          userType: "usertype",
          merchantBranchId: 'branch',
        );

        //act
        await controller!.saveDataToLocalAfterDoLogin(
            response: loginData, isLoginByEmail: true);

        //assert
        expect(DeasyEncryptorUtil.decryptString(pref.getString('email')!), 'a');
      });
    });

    group('Test device info', () {
      test('Get device id', () async {
        //act
        await controller!.getDeviceId();

        //assert
        expect(controller!.deviceId, 'tesid');
      });

      test('Get device model', () async {
        //act
        await controller!.getDeviceModel();

        //assert
        expect(controller!.deviceModel, 'tesDeviceModel');
      });

      test('Get device os', () async {
        //act
        await controller!.getDeviceOs();

        //assert
        expect(controller!.deviceOs, 'tesDeviceOs');
      });

      test('Get device browser type', () async {
        //act
        await controller!.getBrowserType();

        //assert
        expect(controller!.browserType, 'tesBrowserType');
      });

      test('Get device browser version', () async {
        //act
        await controller!.getBrowserVersion();

        //assert
        expect(controller!.browserVersion, 'tesBrowserVersion');
      });
    });

    test('checking role', () {
      //arrange
      OptimusLoginResponse merchantRole =
          OptimusLoginResponse(data: LoginData(role: 'merchant'));
      OptimusLoginResponse merchantEmployeeRole =
          OptimusLoginResponse(data: LoginData(role: 'merchant employee'));
      OptimusLoginResponse adminRole = OptimusLoginResponse(data: LoginData(role: 'admin'));

      //login as merchant
      expect(controller!.checkRoleForWeb(merchantRole), isTrue);
      //login as  employee
      expect(controller!.checkRoleForWeb(merchantEmployeeRole), isTrue);
      //login as admin
      expect(controller!.checkRoleForWeb(adminRole), isFalse);
    });
  });
}
