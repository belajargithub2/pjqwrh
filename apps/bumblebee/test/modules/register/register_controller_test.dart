import 'dart:io';

import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/controllers/bumblebee_register_merchant_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/widgets/register_dialog.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/config/dynamic_config_mock.dart';
import '../../mocks/repository/location_repository_mock.dart';
import '../../mocks/repository/merchant_repository_mock.dart';

class UserRepositoryMock with Mock implements UserRepository {}

class AuthRepositoryMock with Mock implements AuthRepository {}

class DeepLinkRepositoryMock with Mock implements DeepLinkRepository {}

class RegisterDialogMock with Mock implements RegisterDialog {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setFlavor(DevFlavorConfig());

  late BumblebeeRegisterMerchantController controller;
  final registerDialogMock = RegisterDialogMock();
  final dynamicLinkMock = DynamicLinkConfigMock();
  final userRepoMock = UserRepositoryMock();
  final authRepoMock = AuthRepositoryMock();
  final deepLinkRepoMock = DeepLinkRepositoryMock();

  final binding = BindingsBuilder(() {
    Get.lazyPut<RegisterDialog>(() => registerDialogMock);
    Get.lazyPut<DynamicLinkConfig>(() => dynamicLinkMock);
    Get.lazyPut<LocationRepository>(() => LocationRepositoryMock());
    Get.lazyPut<MerchantRepository>(() => MerchantRepositoryMock());
    Get.lazyPut<AuthRepository>(() => authRepoMock);
    Get.lazyPut<UserRepository>(() => userRepoMock);
    Get.lazyPut<DeepLinkRepository>(() => deepLinkRepoMock);
    Get.lazyPut<LoadingController>(() => LoadingController());
    Get.lazyPut<BumblebeeRegisterMerchantController>(
        () => BumblebeeRegisterMerchantController());
  });

  setUpAll(() {
    HttpOverrides.global = null;

    DeasySizeConfigUtils.screenWidth = 620;
    DeasySizeConfigUtils.blockVertical = 10;

    when(authRepoMock.getMerchantTypes(
      any,
      any,
    )).thenAnswer(
      (_) async => MerchantTypeResponseModel(
        code: 200,
        message: "message",
        data: [MerchantTypeData(id: "id", text: "text")],
      ),
    );

    SharedPreferences.setMockInitialValues({});

    binding.builder();
    Get.testMode = true;
    controller = Get.find<BumblebeeRegisterMerchantController>();
  });

  tearDownAll(() {
    Get.delete<LoadingController>();
    Get.delete<BumblebeeRegisterMerchantController>();
  });

  group('Test Register Controller', () {
    test('Test Init Controller', () async {
      /// check if onInit was called
      expect(controller.initialized, true);

      /// await time request
      await Future.delayed(Duration(milliseconds: 100));

      ///check controller isRegistered
      bool test = Get.isRegistered<BumblebeeRegisterMerchantController>();
      expect(test, true);
    });

    test('OnFocusChange', () async {
      //arrange
      controller.supplierIdController.text = "tesid";

      //act
      expect(controller.onFocusChange, returnsNormally);
    });

    test('GetMerchantByid', () {
      controller.getMerchantById().then((value) {
        expect(value.message, 'OK');
        expect(controller.addressController.text, 'jl alternatif cibubur');
      });
    });

    group("Fetch address data", () {
      test('GetProvince', () async {
        await controller.getProvince().then((value) {
          expect(value.message, 'you rock!');
        });
      });

      test('GetCity', () async {
        await controller.getCity(2).then((value) {
          expect(controller.listCity.length, greaterThan(0));
        });
      });

      test('GetDistrict', () async {
        await controller.getDistrict(3).then((value) {
          expect(value.data!.length, greaterThan(0));
          expect(value.message, 'you rock!');
        });
      });

      test('GetVillage', () async {
        await controller.getVillage(3).then((value) {
          expect(controller.listVillage.length, greaterThan(0));
        });
      });
    });

    group("FilterListProvince", () {
      test('should return empty list', () async {
        //arrange
        final listMatcher = [
          ProvinceDatum(code: 1, name: "tes 1"),
          ProvinceDatum(code: 2, name: "tes 2"),
        ];
        controller.listProvince.value = RxList(listMatcher);

        //act
        final result = await controller.filterListProvince("tidak");

        //assert
        expect(result.isEmpty, true);
      });

      test('should return filtered list', () async {
        //arrange
        final listMatcher = [
          ProvinceDatum(code: 1, name: "tes 1"),
          ProvinceDatum(code: 2, name: "tes 2"),
        ];
        controller.listProvince.value = RxList(listMatcher);

        //act
        final result = await controller.filterListProvince("tes 1");

        //assert
        expect(result.isNotEmpty, true);
        expect(result.first.name, listMatcher.first.name);
        expect(result.first.code, listMatcher.first.code);
      });
    });

    group("FilterListCity", () {
      test('should return empty list', () async {
        //arrange
        final listMatcher = [
          CityDatum(code: 1, name: "city tes 1", provinceCode: 1),
          CityDatum(code: 2, name: "city tes 2", provinceCode: 2),
        ];

        controller.listCity.addAll(listMatcher);

        //act
        final result = await controller.filterListCity("tidak");

        //assert
        expect(result.isEmpty, true);
      });

      test('should return filtered list', () async {
        //arrange
        final listMatcher = [
          CityDatum(code: 1, name: "city tes 1", provinceCode: 1),
          CityDatum(code: 2, name: "city tes 2", provinceCode: 2),
        ];

        controller.listCity.addAll(listMatcher);

        //act
        final result = await controller.filterListCity("tes 1");

        //assert
        expect(result.isNotEmpty, true);
        expect(result.first.name, listMatcher.first.name);
        expect(result.first.code, listMatcher.first.code);
      });
    });

    group("FilterListDistric", () {
      test('should return empty list', () async {
        //arrange
        final listMatcher = [
          DistrictDatum(code: 1, name: "distric tes 1", cityCode: 1),
          DistrictDatum(code: 2, name: "distric tes 2", cityCode: 2),
        ];

        controller.listDistrict.addAll(listMatcher);

        //act
        final result = await controller.filterListDistrict("tidak");

        //assert
        expect(result.isEmpty, true);
      });

      test('should return filtered list', () async {
        //arrange
        final listMatcher = [
          DistrictDatum(code: 1, name: "distric tes 1", cityCode: 1),
          DistrictDatum(code: 2, name: "distric tes 2", cityCode: 2),
        ];

        controller.listDistrict.addAll(listMatcher);

        //act
        final result = await controller.filterListDistrict("tes 1");

        //assert
        expect(result.isNotEmpty, true);
        expect(result.first.name, listMatcher.first.name);
        expect(result.first.code, listMatcher.first.code);
      });
    });

    group("FilterListVillage", () {
      test('should return empty list', () async {
        //arrange
        final listMatcher = [
          VillageDatum(
              code: 1, name: "village tes 1", postCode: 1, districtCode: 1),
          VillageDatum(
              code: 2, name: "village tes 2", postCode: 2, districtCode: 2),
        ];

        controller.listVillage.addAll(listMatcher);

        //act
        final result = await controller.filterListVillage("tidak");

        //assert
        expect(result.isEmpty, true);
      });

      test('should return filtered list', () async {
        //arrange
        final listMatcher = [
          VillageDatum(
              code: 1, name: "village tes 1", postCode: 1, districtCode: 1),
          VillageDatum(
              code: 2, name: "village tes 2", postCode: 2, districtCode: 2),
        ];

        controller.listVillage.addAll(listMatcher);

        //act
        final result = await controller.filterListVillage("tes 1");

        //assert
        expect(result.isNotEmpty, true);
        expect(result.first.name, listMatcher.first.name);
        expect(result.first.code, listMatcher.first.code);
      });
    });

    group("SelectMerchantType", () {
      test('should return selected merchant type', () {
        //arrange
        final listMatcher = [
          MerchantTypeData(id: "tes id 1", text: "tes 1"),
          MerchantTypeData(id: "tes id 2", text: "tes 2"),
        ];
        controller.listMerchantType.addAll(listMatcher);

        //act
        controller.selectMerchantType(listMatcher.first.text!);

        //assert
        expect(controller.selectedMerchantType.text, listMatcher.first.text);
      });
    });

    test('RegisterRequestBody', () {
      //arrange
      final urlMatcher = "tes url";
      final tokenMatcher = "tes token";

      controller.selectedMerchantType = MerchantTypeData(
        id: "tes id",
        text: "tes text",
      );

      //act
      final result = controller.registerRequestBody(urlMatcher, tokenMatcher);

      //assert
      expect(result.token, tokenMatcher);
      expect(result.createPasswordUrl, urlMatcher);
    });

    group("Submit", () {
      setUp(() {
        when(authRepoMock.getTokenEmail(
          any,
          any,
        )).thenAnswer((_) async =>
            GetTokenResponse(data: GetTokenData(token: "tes token")));

        when(registerDialogMock.mobileDefaultDialog()).thenAnswer((_) => true);

        controller.selectedMerchantType = MerchantTypeData(
          id: "tes id",
          text: "tes text",
        );
      });
      test('Success isWeb', () async {
        //arrange
        final responseRegister = ResponseRegister(
          code: 200,
          message: "tes",
          error: "tes",
          data: RegisterData(),
        );

        when(userRepoMock.userRegister(
          any,
          {},
          any.toString(),
        )).thenAnswer((_) async => responseRegister);

        //act
        controller.submit();
        expect(controller.loadingController.isLoading, true);
        await Future.delayed(Duration(milliseconds: 200));

        //assert
        expect(controller.loadingController.isLoading, false);
      });

      test('Success is not Web', () async {
        //arrange
        final responseRegister = ResponseRegister(
          code: 200,
          message: "tes",
          error: "tes",
          data: RegisterData(),
        );

        when(userRepoMock.userRegister(
          any,
          {},
          any.toString(),
        )).thenAnswer((_) async => responseRegister);

        //act
        controller.submit();
        expect(controller.loadingController.isLoading, true);
        await Future.delayed(Duration(milliseconds: 200));

        //assert
        expect(controller.loadingController.isLoading, false);
      });

      test('failed', () async {
        //arrange
        when(userRepoMock.userRegister(
          any,
          {},
          any.toString(),
        )).thenAnswer(((_) async => throw Exception()));

        //act
        controller.submit();
        expect(controller.loadingController.isLoading, true);
        await Future.delayed(Duration(milliseconds: 200));

        //assert
        expect(controller.loadingController.isLoading, false);
      });
    });

    test('OnPressButtonRegisterType', () {
      //arrange
      final stringMatcher = "userType";
      //act
      controller.onPressedButtonRegisterType(stringMatcher);

      //assert
      expect(controller.onSelectedButton.value, stringMatcher);
    });

    group("onRouteToRegisterAsTypeUser(String", () {
      test('Should return merchant', () {
        //arrange
        final stringMatcher = "merchant";

        //act
        final result = controller.onRouteToRegisterAsTypeUser(stringMatcher);

        //assert
        expect(result, stringMatcher);
      });

      test('Should return agent', () {
        //arrange
        final stringMatcher = "agent";

        //act
        final result = controller.onRouteToRegisterAsTypeUser(stringMatcher);

        //assert
        expect(result, stringMatcher);
      });

      test('Should return null', () {
        //arrange
        final stringMatcher = "avatar";

        //act
        final result = controller.onRouteToRegisterAsTypeUser(stringMatcher);

        //assert
        expect(result == null, true);
      });
    });
  });
}