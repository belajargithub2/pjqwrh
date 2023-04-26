import 'package:deasy_helper/deasy_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/bindings/bumblebee_snb_base_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_asset_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_asset_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;

import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';


void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late BumblebeeSubmissionSectionController controller;
  late AssetData assetData;
  final assetRepositoryMock = AssetRepositoryMock();

  final binding = BindingsBuilder(() {
    BumblebeeSnapAndBuyBaseBinding().dependencies();
    Get.lazyReplace<BumblebeeSnapNBuyRepository>(() => SnapNBuyRepositoryMock());
    Get.lazyReplace<BumblebeeSnapAndBuyBaseController>(() => SnapAndBuyControllerMock());
    Get.lazyReplace<BumblebeeAssetRepository>(() => assetRepositoryMock);
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    when(assetRepositoryMock.postApiMasterAsset(any, {}, "")).thenAnswer(
        (_) async => AssetResponse(
            message: "test",
            data: <AssetData>[
              AssetData(
                  assetCode: "tesAssetCode",
                  assetName: "tesAssetName",
                  assetType: "tesAssetType",
                  categoryCode: "tesCategoryCode",
                  categoryName: "tesCategoryName")
            ],
            pageInfo: PageInfo(
                totalRecord: 1,
                totalPage: 1,
                offset: 1,
                limit: 10,
                prevPage: 0,
                nextPage: 2)));
    binding.builder();
    controller = Get.find<BumblebeeSubmissionSectionController>();
    assetData = AssetData(
        assetCode: "tesAssetCode",
        assetName: "tesAssetName",
        assetType: "tesAssetType",
        categoryCode: "tesCategoryCode",
        categoryName: "tesCategoryName");
  });

  tearDownAll(() {
    Get.delete<BumblebeeSubmissionSectionController>();
  });

  group('Test Submission Section Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeSubmissionSectionController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<BumblebeeSubmissionSectionController>(), true);
    });

    test('fetch api asset on error', (() async {
      //arrange
      when(assetRepositoryMock.postApiMasterAsset(any, {}, ""))
          .thenAnswer(((_) async => throw Exception()));
      controller.nextPageAsset.value = 0;

      //act
      await controller.fetchApiAsset().then((value) {
        //assert
        expect(controller.nextPageAsset.value, 1);
        expect(controller.isLoadMore.value, false);
        expect(controller.assetDropdownList.isEmpty, true);
      });
    }));

    test('fetch api asset on success', (() async {
      //arrange
      when(assetRepositoryMock.postApiMasterAsset(any, {}, "")).thenAnswer(
          (_) async => AssetResponse(
              message: "test",
              data: <AssetData>[
                AssetData(
                    assetCode: "tesAssetCode",
                    assetName: "tesAssetName",
                    assetType: "tesAssetType",
                    categoryCode: "tesCategoryCode",
                    categoryName: "tesCategoryName")
              ],
              pageInfo: PageInfo(
                  totalRecord: 1,
                  totalPage: 1,
                  offset: 1,
                  limit: 10,
                  prevPage: 0,
                  nextPage: 2)));
      controller.nextPageAsset.value = 0;

      //act
      await controller.fetchApiAsset().then((value) {
        //assert
        expect(controller.nextPageAsset.value, 1);
        expect(controller.countAsset.value, 1);
        expect(controller.assetDropdownList.isNotEmpty, true);
        expect(controller.assetDropdownList.first.assetCode, "tesAssetCode");
      });
    }));

    test('load more should return false when is load more is false', (() async {
      //arrange
      controller.isLoadMore.value = false;

      //act
      await controller.loadMore().then((value) {
        //assert
        expect(value, false);
      });
    }));

    test(
        'load more should fetch asset by name when search controller text is not empty',
        (() async {
      //arrange
      controller.isLoadMore.value = true;
      controller.searchControllerAsset.text = "tes";
      when(controller.bumblebeeAssetRepository.postApiMasterAsset(any, {}, ""))
          .thenAnswer((_) async => AssetResponse(
              message: "test",
              data: <AssetData>[
                AssetData(
                    assetCode: "tesAssetCode",
                    assetName: "tesAssetName",
                    assetType: "tesAssetType",
                    categoryCode: "tesCategoryCode",
                    categoryName: "tesCategoryName")
              ],
              pageInfo: PageInfo(
                  totalRecord: 1,
                  totalPage: 1,
                  offset: 1,
                  limit: 10,
                  prevPage: 0,
                  nextPage: 2)));

      //act
      await controller.loadMore().then((value) {
        //assert
        expect(value, true);
        expect(controller.nextPageAsset.value, 1);
        expect(controller.countAsset.value, 1);
        expect(controller.assetDropdownList.isNotEmpty, true);
        expect(controller.assetDropdownList.first.assetCode, "tesAssetCode");
      });
    }));

    test(
        'load more should fetch asset without name when search controller text is empty',
        (() async {
      //arrange
      controller.isLoadMore.value = true;

      //act
      await controller.loadMore().then((value) {
        //assert
        expect(value, true);
        expect(controller.nextPageAsset.value, 2);
        expect(controller.countAsset.value, 1);
        expect(controller.assetDropdownList.isNotEmpty, true);
        expect(controller.assetDropdownList.first.assetCode, "tesAssetCode");
      });
    }));

    test('search asset', (() async {
      //arrange
      //act
      await controller.searchAsset("tes").then((value) {
        //assert
        expect(controller.nextPageAsset.value, 4);
        expect(controller.countAsset.value, 1);
        expect(controller.assetDropdownList.isNotEmpty, true);
        expect(controller.assetDropdownList.first.assetCode, "tesAssetCode");
      });
    }));

    test('refresh asset', (() async {
      //arrange
      //act
      controller.searchControllerAsset.clear();
      await controller.refreshAsset().then((value) async {
        await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
        //assert
        expect(controller.nextPageAsset.value, 5);
        expect(controller.countAsset.value, 1);
        expect(controller.assetDropdownList.isNotEmpty, true);
        expect(controller.assetDropdownList.first.assetCode, "tesAssetCode");
      });
    }));

    test('on change find asset when text is empty and is first asset is true',
        (() async {
      //arrange
      controller.isFirstAsset.value = true;

      //act
      controller.onChangeFindAsset("");
      await Future.delayed(Duration(milliseconds: 1000));

      //assert
      expect(controller.isFirstAsset.value, false);
      expect(controller.nextPageAsset.value, 2);
      expect(controller.countAsset.value, 1);
      expect(controller.assetDropdownList.isNotEmpty, true);
    }));

    test('on change find asset when text is empty and is first asset is false',
        (() async {
      //arrange
      controller.isFirstAsset.value = false;

      //act
      controller.onChangeFindAsset("");
      await Future.delayed(Duration(milliseconds: 1000));

      //assert
      expect(controller.nextPageAsset.value, 2);
      expect(controller.countAsset.value, 1);
      expect(controller.assetDropdownList.isNotEmpty, true);
    }));

    test('on change find asset when text is not empty', (() async {
      //arrange
      //act
      controller.onChangeFindAsset("tes");
      await Future.delayed(Duration(milliseconds: 1000));

      //assert
      expect(controller.nextPageAsset.value, 2);
      expect(controller.countAsset.value, 1);
      expect(controller.assetDropdownList.isNotEmpty, true);
    }));

    test('on product tap', (() {
      //arrange
      controller.listAssetVisible.value = false;

      //act
      controller.onProductTap();

      //assert
      expect(controller.listAssetVisible.value, true);
    }));

    test('on tap asset', (() {
      controller.onTapAsset(assetData);

      expect(controller.listAssetVisible.value, false);
      expect(controller.assetModel.value.assetCode, "tesAssetCode");
      expect(controller.productController.text, assetData.assetName);
    }));

    test('on search text changed asset', (() async {
      //arrange
      //act
      await controller.onSearchTextChangedAsset("tesAssetName");

      //assert
      expect(controller.assetDropdownList.isNotEmpty, true);
      expect(controller.assetDropdownList.first.assetName, "tesAssetName");
    }));

    test('phone number validation when phone number value is empty', (() {
      //arrange
      //act
      //assert
      expect(
          controller.phoneNumberValidation(""), ContentConstant.phoneValidation);
    }));

    test('phone number validation when phone number value is not empty', (() {
      //arrange
      //act
      //assert
      expect(controller.phoneNumberValidation("081234567890"), null);
    }));

    test('price good validation when price value is empty', (() {
      //arrange
      //act
      //assert
      expect(
          controller.priceGoodValidation(""), ContentConstant.correctPriceGood);
    }));

    test('price good validation when price value is less than 1.500.000', (() {
      //arrange
      //act
      //assert
      expect(controller.priceGoodValidation("Rp 1.400.000"),
          ContentConstant.minimumGoodPrice);
    }));

    test('price good validation when price value is more than 1.500.000', (() {
      //arrange
      //act
      //assert
      expect(controller.priceGoodValidation("Rp 1.600.000"), null);
    }));

    test('price good validation when price value text length is less than 4',
        (() {
      //arrange
      //act
      //assert
      expect(controller.priceGoodValidation("Rp 5"),
          ContentConstant.correctPriceGood);
    }));

    test('on change price product', (() {
      //arrange
      final priceText = "1000000";

      //act
      controller.onChangePriceProduct(priceText);

      //assert
      expect(controller.realPrice.value, 1000000);
      expect(
          controller.priceController.value,
          TextEditingValue(
            text: "Rp. ${priceText.toDecimalFormat()}",
            selection: TextSelection.collapsed(
                offset: "Rp. ${priceText.toDecimalFormat()}".length),
          ));
    }));

    test('select item validation when item value is not empty', (() {
      //arrange
      //act
      //assert
      expect(controller.selectItemValidation("test"), null);
    }));

    test('select item validation when item value not empty', (() {
      //arrange
      //act
      //assert
      expect(controller.selectItemValidation(""), ContentConstant.emptyProduct);
    }));

    test('go to submission section', (() {
      //arrange
      when(controller.bumblebeeSnapAndBuyBaseController.activeMainSection)
          .thenReturn(Rx(SECTION.SUBMISSION_SECTION));
      when(controller.bumblebeeSnapAndBuyBaseController.activeSubSection)
          .thenReturn(Rx(SUB_SECTION.NULL_SUB_SECTION));
      when(controller.bumblebeeSnapAndBuyBaseController.stepIndex)
          .thenReturn(RxInt(0));

      //act
      controller.goToSubmissionSection();

      //assert
      expect(controller.phoneNumberController.text.isEmpty, true);
      expect(controller.priceController.text.isEmpty, true);
      expect(controller.productController.text.isEmpty, true);
      expect(controller.realPrice.value, 0);
      expect(controller.bumblebeeSnapAndBuyBaseController.stepIndex.value, 0);
      expect(
          controller.bumblebeeSnapAndBuyBaseController.activeMainSection.value,
          SECTION.SUBMISSION_SECTION);
      expect(
          controller.bumblebeeSnapAndBuyBaseController.activeSubSection.value,
          SUB_SECTION.NULL_SUB_SECTION);
    }));

    test('get asset', (() {
      //arrange
      //act
      final asset = controller.getAsset();

      //assert
      expect(asset.assetNumber, 1);
      expect(asset.assetCode, assetData.assetCode);
      expect(asset.categoryCode, assetData.categoryCode);
      expect(asset.categoryName, assetData.categoryName);
      expect(asset.otr, controller.realPrice.value);
    }));
  });
}
