import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/bindings/account_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_add_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/content_constant.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/config/firebase_core_config_mock.dart';
import 'merchant_user_management_controller_test.mocks.dart';

void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late BumblebeeAddMerchantUserManagementController controller;
  
  final userRepositoryMock = MockUserRepository();

  final binding = BindingsBuilder(() {
    AccountBinding().dependencies();
    Get.lazyReplace<UserRepository>(() => userRepositoryMock);
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    binding.builder();
    controller = Get.find<BumblebeeAddMerchantUserManagementController>();
    SharedPreferences.setMockInitialValues({});
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("supplier_id", DeasyEncryptorUtil.encryptString("testSupplierId"));
    controller.merchantEmployeeRoleId = "testMerchantEmployeeId";
  });

  tearDownAll(() {
    Get.delete<BumblebeeAddMerchantUserManagementController>();
  });

  group('Test Bumblebee Merchant User Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeAddMerchantUserManagementController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<BumblebeeAddMerchantUserManagementController>(), true);
    });

    test('get supplier id', () async {
      //arrange
      //act
      await controller.getSupplierId();

      //assert
      expect(controller.supplierId, "testSupplierId");
    });

    test('set lob types', () async {
      //arrange
      when(userRepositoryMock.fetchApiLobTypes(any))
        .thenAnswer(((_) async => Future.value(
          UserGetLobTypesResponse(
            code: 200,
            message: "test",
            lobTypes: [
              LobType(
                lobType: ContentConstant.deaLobType,
                lobTypeName: ContentConstant.electronicLobName
              )
            ]
          )
        )));
      
      //act
      await controller.setLobTypes();

      //assert
      expect(controller.lobType, ContentConstant.deaLobType);
    });
  });
}
