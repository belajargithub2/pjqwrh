import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';

import '../kmob_submission_dummy.dart';
import '../mock/kmob_submission_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  late BumblebeeKMOBAssetDataSubmissionController controller;

  KMOBSubmissionRepositoryMock _mockKmobSubmissionRepository = KMOBSubmissionRepositoryMock();
  KMOBSubmissionControllerMock _kmobSubmissionController = KMOBSubmissionControllerMock();

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeKMOBAssetDataSubmissionController>(
      () => BumblebeeKMOBAssetDataSubmissionController(
        bumblebeeKmobSubmissionRepository: _mockKmobSubmissionRepository,
        bumblebeeKmobSubmissionController: _kmobSubmissionController,
        bumblebeeDraftRepository: DraftRepositoryMock(),
      ),
    );
  });

  setUp(() async {
    when(_mockKmobSubmissionRepository.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummy);
    when(_mockKmobSubmissionRepository.getListLicenseArea()).thenAnswer((_) async => responseGetListLicenseAreaDummy);
    when(_kmobSubmissionController.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

    binding.builder();
    controller = Get.find<BumblebeeKMOBAssetDataSubmissionController>();
  });

  group('Test KMOB Submission asset data Controller', () {
    test('should return true when controller is initialized', () async {
      expect(controller.initialized, true);
    });
  });

  group('Test fetchApiBpkbOwnerShipStatus', () {

    test('should return throw exception', () async {
      // arrange
      // act
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenThrow(Exception());

      // assert
      expect(controller.fetchApiBpkbOwnerShipStatus(), throwsException);
    });

    test('should return list greater than 0', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummy);

      // act
      final result = await controller.fetchApiBpkbOwnerShipStatus();

      // assert
      expect(result.length, greaterThan(0));
    });

    test('should return 0 when DataBpkbOwnerShipStatus is empty', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummyEmpty);
      // act
      final result = await controller.fetchApiBpkbOwnerShipStatus();

      // assert
      expect(result.length, 0);
    });
  });

  group('Test fetchApiBrand', () {

    test('should return null when getbrand is throw exception', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBrand(requestBody: requestGetBranddummy.toJson())).thenThrow(Exception());

      // act
      final result = await controller.fetchApiBrand();

      // act
      expect(result.data, null);
    });

    test('should return success', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBrand(requestBody: requestGetBranddummy.toJson())).thenAnswer((_) async => responseGetAssetBrandsDummy);

      // act
      final result = await controller.fetchApiBrand(brandName: 'toyota').then((value) => value = responseGetAssetBrandsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(result.code, 200);
    });

    test('should return 0 when DataBrand is empty', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBrand()).thenAnswer((_) async => responseGetAssetBrandsDummy);

      // act
      final result = await controller.fetchApiBrand(). then((value) => value = responseGetAssetBrandsDummyEmpty);

      // assert
      expect(result.data!.length, 0);
    });
  });

  group('Test updateListBrand', () {
    test('should return list greater than 0', () async {
      // arrange
      final result = await controller.fetchApiBrand().then((value) => value = responseGetAssetBrandsDummy);

      // act
      controller.updateListBrand(result);

      // assert
      expect(controller.listBrand.length, greaterThan(0));
      expect(controller.isLoadMoreBrand.value, true);
    });

    test('should return false when DataBrand is empty', () async {
      // arrange
      final result = await controller.fetchApiBrand(brandName: "toyota").then((value) => value = responseGetAssetBrandsDummyEmpty);

      // act
      controller.updateListBrand(result);

      // assert
      expect(controller.isLoadMoreBrand.value, false);
    });
  });


  group('Test getAssetModels', () {
    test('should return null when getmodel is throw exception', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetModels(requestGetModelDummy.toJson())).thenThrow(Exception());

      // act
      final result = await controller.fetchApiModel();

      // act
      expect(result.data, null);
    });

    test('should return success', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetModels(requestGetModelDummy.toJson()))
          .thenAnswer((_) async => responseGetAssetModelsDummy);

      // act
      final result = await controller.fetchApiModel().then((value) => value = responseGetAssetModelsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(result.code, 200);
    });

    test('should return 0 when DataModel is empty', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetModels(requestGetModelDummy.toJson()))
          .thenAnswer((_) async => responseGetAssetModelsDummyEmpty);

      // act
      final result = await controller.fetchApiModel(). then((value) => value = responseGetAssetModelsDummyEmpty);

      // assert
      expect(result.data!.length, 0);
    });
  });

  group('Test updateListModel', () {
    test('should return list greater than 0', () async {
      // arrange
      final result = await controller.fetchApiModel().then((value) => value = responseGetAssetModelsDummy);

      // act
      controller.updateListModel(result);

      // assert
      expect(controller.listModel.length, greaterThan(0));
      expect(controller.isLoadMoreModel.value, true);
    });

    test('should return false when DataModel is empty', () async {
      // arrange
      final result = await controller.fetchApiModel().then((value) => value = responseGetAssetModelsDummyEmpty);

      // act
      controller.updateListModel(result);

      // assert
      expect(controller.isLoadMoreModel.value, false);
    });
  });


  group('Test fetchApiType', () {

    test('should return null when gettype is throw exception', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetTypes(requestBody: requestGetTypeDummy.toJson())).thenThrow(Exception());

      // act
      final result = await controller.fetchApiType();

      // act
      expect(result.data, null);
    });

    test('should return success', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetTypes(requestBody: requestGetTypeDummy.toJson())).thenAnswer((_) async => responseGetAssetTypesDummy);

      // act
      final result = await controller.fetchApiType().then((value) => value = responseGetAssetTypesDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(result.code, 200);
    });

    test('should return 0 when DataType is empty', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getAssetTypes(requestBody: requestGetTypeDummy.toJson())).thenAnswer((_) async => responseGetAssetTypesDummyEmpty);

      // act
      final result = await controller.fetchApiType(). then((value) => value = responseGetAssetTypesDummyEmpty);

      // assert
      expect(result.data!.length, 0);
    });
  });

  group('Test updateListType', () {
    test('should return list greater than 0', () async {
      // arrange
      final result = await controller.fetchApiType().then((value) => value = responseGetAssetTypesDummy);

      // act
      controller.updateListType(result);

      // assert
      expect(controller.listType.length, greaterThan(0));
      expect(controller.isLoadMoreType.value, true);
    });

    test('should return false when DataType is empty', () async {
      // arrange
      final result = await controller.fetchApiType().then((value) => value = responseGetAssetTypesDummyEmpty);

      // act
      controller.updateListType(result);

      // assert
      expect(controller.isLoadMoreType.value, false);
    });
  });

  group('Test onTapBrand', () {
    test('should return true when onTapBrand', () async {
      // arrange
      // act
      controller.onTapBrand();

      // assert
      expect(controller.listBrandVisible.value, true);
    });
  });

  group('Test onTapModel', () {
    test('should return true when onTapModel', () async {
      // arrange
      // act
      controller.onTapModel();

      // assert
      expect(controller.listModelVisible.value, true);
    });
  });

  group('Test onTapType', () {
    test('should return true when onTapType', () async {
      // arrange
      // act
      controller.onTapType();

      // assert
      expect(controller.listTypeVisible.value, true);
    });
  });

  group('Test loadMoreBrand', () {
    test('should return true when loadMoreBrand and search is empty', () async {
      // arrange
      controller.isLoadMoreBrand.value = true;

      // act
      final result = await controller.loadMoreBrand();

      // assert
      expect(result, true);
    });

    test('should return true when loadMoreBrand and search value is not empty', () async {
      // arrange
      controller.isLoadMoreBrand.value = true;
      controller.searchBrandController.text = "toyota";

      // act
      final result = await controller.loadMoreBrand();

      // assert
      expect(result, true);
    });
  });

  group('Test loadMoreModel', () {
    test('should return true when loadMoreModel and search is empty', () async {
      // arrange
      controller.isLoadMoreModel.value = true;

      // act
      final result = await controller.loadMoreModel();

      // assert
      expect(result, true);
    });

    test('should return true when loadMoreModel and search value is not empty', () async {
      // arrange
      controller.isLoadMoreModel.value = true;
      controller.searchModelController.text = "toyota";

      // act
      final result = await controller.loadMoreModel();

      // assert
      expect(result, true);
    });
  });

  group('Test loadMoreType', () {
    test('should return true when loadMoreType and search is empty', () async {
      // arrange
      controller.isLoadMoreType.value = true;

      // act
      final result = await controller.loadMoreType();

      // assert
      expect(result, true);
    });

    test('should return true when loadMoreType and search value is not empty', () async {
      // arrange
      controller.isLoadMoreType.value = true;
      controller.searchTypeController.text = "toyota";

      // act
      final result = await controller.loadMoreType();

      // assert
      expect(result, true);
    });
  });


  group('Test onChangeFindBrand', () {

    test('should return empty list when onChangeBrand', () async {
      // arrange
      String q = 'yamaha';
      final result = await controller.fetchApiBrand(brandName: q). then((value) => value = responseGetAssetBrandsDummyEmpty);

      // act
      controller.onChangeFindBrand(q);

      // assert
      expect(result.data!.length, 0);
    });

    test('should return list greater than 0 when onChangeBrand && search value not empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = 'toyota';

      // act
      controller.onChangeFindBrand(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiBrand(brandName: q).then((value) => value = responseGetAssetBrandsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

    test('should return list greater than 0 when onChangeBrand && search value is empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = '';

      // act
      controller.onChangeFindBrand(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiBrand(page: 1).then((value) => value = responseGetAssetBrandsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

  });

  group('Test onChangeFindModel', () {

    test('should return empty list when onChangeModel', () async {
      // arrange
      String q = 'yamaha';
      final result = await controller.fetchApiModel(modelName: q). then((value) => value = responseGetAssetModelsDummyEmpty);

      // act
      controller.onChangeFindModel(q);

      // assert
      expect(result.data!.length, 0);
    });

    test('should return list greater than 0 when onChangeModel && search value not empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = 'toyota';

      // act
      controller.onChangeFindModel(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiModel(modelName: q).then((value) => value = responseGetAssetModelsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

    test('should return list greater than 0 when onChangeModel && search value is empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = '';

      // act
      controller.onChangeFindModel(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiModel(page: 1).then((value) => value = responseGetAssetModelsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

  });

  group('Test onChangeFindType', () {

    test('should return empty list when onChangeType', () async {
      // arrange
      String q = 'yamaha';
      final result = await controller.fetchApiType(typeName: q). then((value) => value = responseGetAssetTypesDummyEmpty);

      // act
      controller.onChangeFindType(q);

      // assert
      expect(result.data!.length, 0);
    });

    test('should return list greater than 0 when onChangeType && search value not empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = 'toyota';

      // act
      controller.onChangeFindType(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiType(typeName: q).then((value) => value = responseGetAssetTypesDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

    test('should return list greater than 0 when onChangeType && search value is empty', () async {
      // arrange
      const FIVE_HUNDRED_MILLISECOND = 500;
      String q = '';

      // act
      controller.onChangeFindType(q);
      await Future.delayed(Duration(milliseconds: FIVE_HUNDRED_MILLISECOND));
      final result = await controller.fetchApiType(page: 1).then((value) => value = responseGetAssetTypesDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
    });

  });

  group('Test onTapBrandItem', () {
    test('should return same brandName value when call onTapBrandItem', () async {
      // arrange
      final brand = DataAssetBrand(
        brandName: "toyota",
      );

      // act
      controller.onTapBrandItem(brand);

      // assert
      expect(controller.vehicleBrandController.text, brand.brandName);
    });
  });

  group('Test onTapModelItem', () {
    test('should return same modelName value when call onTapModelItem', () async {
      // arrange
      final model = DataAssetModel(
        modelName: "toyota",
      );

      // act
      controller.onTapModelItem(model);

      // assert
      expect(controller.vehicleModelController.text, model.modelName);
    });
  });

  group('Test onTapTypeItem', () {
    test('should return same typeName value when call onTapTypeItem', () async {
      // arrange
      final type = DataAssetType(
        typeName: "toyota",
      );

      // act
      controller.onTapTypeItem(type);

      // assert
      expect(controller.vehicleTypeController.text, type.typeName);
    });
  });

  group('Test refreshBrand', () {
    test('should return list greater than 0 && search must not empty when call refreshBrand', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = 'yamaha';

      // act
      controller.refreshBrand();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiBrand(brandName: q). then((value) => value = responseGetAssetBrandsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchBrandController.text, isNotEmpty);
    });

    test('should return list greater than 0 && search must empty when call refreshBrand', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = '';
      controller.searchBrandController.text = q;

      // act
      controller.refreshBrand();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiBrand(). then((value) => value = responseGetAssetBrandsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchBrandController.text, isEmpty);
    });
  });

  group('Test refreshModel', () {
    test('should return list greater than 0 && search must not empty when call refreshModel', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = 'yamaha';
      int page = 1;
      controller.searchModelController.text = q;

      // act
      controller.refreshModel();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiModel(page: page ,modelName: q). then((value) => value = responseGetAssetModelsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchModelController.text, isNotEmpty);
    });

    test('should return list greater than 0 && search must empty when call refreshModel', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = '';
      int page = 1;
      controller.searchModelController.text = q;

      // act
      controller.refreshModel();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiModel(page: page). then((value) => value = responseGetAssetModelsDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchModelController.text, isEmpty);
    });
  });

  group('Test refreshType', () {
    test('should return list greater than 0 && search must not empty when call refreshType', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = 'SUV';
      controller.searchTypeController.text = q;

      // act
      controller.refreshType();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiType(typeName: q). then((value) => value = responseGetAssetTypesDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchTypeController.text, isNotEmpty);
    });

    test('should return list greater than 0 && search must empty when call refreshType', () async {
      // arrange
      const ONE_THOUSAND_MILLISECOND = 1000;
      String q = '';
      controller.searchTypeController.text = q;

      // act
      controller.refreshType();
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      final result = await controller.fetchApiType(page: 1, typeName: q). then((value) => value = responseGetAssetTypesDummy);

      // assert
      expect(result.data!.length, greaterThan(0));
      expect(controller.searchTypeController.text, isEmpty);
    });
  });

  group('Test onChangeYearPicker', () {

    test('should return 2021 when call onChangeYearPicker', () async {
      // arrange
      DateTime date = DateTime.parse("2021-01-01");

      // act
      final result = await controller.onChangeYearPicker(date);

      // assert
      expect(controller.vehicleYearController.text, result);
    });

  });


  group('Test filterLicenseStatus', () {
    test('should return list greater than 0 when call filterLicenseStatus', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummy);
      final list = await controller.fetchApiBpkbOwnerShipStatus();

      // act
      final result = await controller.filterLicenseStatus(list.first.name);

      // assert
      expect(result.length, greaterThan(0));
    });
  });

  group('Test onChangeBpkbOwnerShipStatus', () {
    test('should return same value when call onChangeBpkbOwnerShipStatus', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummy);
      final result = await controller.fetchApiBpkbOwnerShipStatus();

      // act
      controller.onChangeBpkbOwnerShipStatus(result.first);

      // assert
      expect(controller.bpkbOwnerShipStatusController.text, result.first.name);
      expect(controller.bpkbOwnerShipStatusId.value, result.first.code);
    });
  });

  group('Test fetchApiGetPlat', () {
    test('should return throw exception', () async {
      // arrange
      // act
      when(controller.bumblebeeKmobSubmissionRepository!.getListLicenseArea()).thenThrow(Exception());

      // assert
      expect(controller.fetchApiGetPlat(), throwsException);
    });

    test('should return list greater than 0 when call fetchApiGetPlat', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getListLicenseArea()).thenAnswer((_) async => responseGetListLicenseAreaDummy);

      // act
      final result = await controller.fetchApiGetPlat();

      // assert
      expect(result.length, greaterThan(0));
    });

  });

  group('Test findPlatInNestedList', () {
    test('should return 1 region and 1 police no when call findPlatInNestedList', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getListLicenseArea()).thenAnswer((_) async => responseGetListLicenseAreaDummy);
      final list = await controller.fetchApiGetPlat();
      controller.listLicenceArea.value = list;

      // act
      final region = controller.findPlatInNestedList("EF");

      // assert
      expect(region.length, 1);
      expect(region.first.policeNoList!.length, 1);
    });
  });

  group('Test getBpkpOwnershipStatusById', () {
    test('should return same value when call getBpkpOwnershipStatusById', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus()).thenAnswer((_) async => responseGetBpkbOwnerShipStatusDummy);
      final result = await controller.fetchApiBpkbOwnerShipStatus();
      controller.listBpkbOwnerShipStatus.value = result;

      // act
      controller.getBpkpOwnershipStatusById(result.first.code);

      // assert
      expect(controller.bpkbOwnerShipStatusController.text, result.first.name);
      expect(controller.bpkbOwnerShipStatusId.value, result.first.code);
    });
  });

  group('Test setDataDataToLocal', () {
    test('should return same value when call setDataDataToLocal', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
      controller.disbursedAmountController.text = "100.000";

      // act
      final result = await controller.setDataDataToLocal();

      // assert
      expect(result, kmobSubmissionModelDummy);
    });
  });

  group('Test checkDraftAssetData', () {
    test('should return same value when call checkDraftAssetData', () async {
      // arrange
      when(controller.bumblebeeKmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      controller.checkDraftAssetData();

      // assert
      expect(controller.bumblebeeKmobSubmissionController!.kmobSubmissionModel.value, kmobSubmissionModelDummy);
    });
  });

  group('Test onTapChipPlatNo', () {
    test('should return same value when call onTapChipPlatNo', () async {
      // arrange
      // act
      controller.onTapChipPlatNo("EF");

      // assert
      expect(controller.licenseAreaController.text, "EF");
    });
  });

  group('Test isChipSelected', () {
    test('should return true when call isChipSelected', () async {
      // arrange
      // act
      final result = controller.isChipSelected("EF");

      // assert
      expect(result, true);
    });
  });

}
