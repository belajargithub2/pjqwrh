import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/bindings/optimus_snb_base_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_permission_location_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_asset_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_calculate_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_tenor_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;

import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late OptimusPromoMarketingController controller;

  final binding = BindingsBuilder(() {
    OptimusSnapAndBuyBaseBinding().dependencies();
    Get.lazyReplace<OptimusSnapNBuyRepository>(() => SnapNBuyRepositoryMock());
    Get.lazyReplace<OptimusSnapAndBuyBaseController>(() => SnapAndBuyControllerMock());
    Get.lazyReplace<OptimusSubmissionSectionController>(
        () => SubmissionSectionControllerMock());
    Get.lazyReplace<OptimusPermissionLocationController>(
        () => PermissionLocationControllerMock());
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    DeasySizeConfigUtils.screenWidth = 640;
    binding.builder();
    controller = Get.find<OptimusPromoMarketingController>();
    when(controller.snapAndBuyWebController.listPromoMarketingResponse)
        .thenReturn(Rx(ListPromoMarketingResponse(
            data: Data(
      customerStatus: CustomerStatus(
          customerId: 123,
          customerRegisterStatus: "tesCustRegisStatus",
          isRegisteredKreditmu: true,
          limitStatus: "tesLimitStatus",
          verificationLimitStatus: "tesVierificationLimitStatu",
          dataVerification: true,
          faceVerification: true),
      programs: <Program>[
        Program(
            programId: "tesProgramId1",
            programName: "tesProgramName1",
            miNumber: 123,
            description: "tesDescripton1",
            periodStart: DateTime(2021),
            periodEnd: DateTime(2021),
            specialFeature: "tesSpecialFeature1",
            installmentType: "tesInstallmentType1",
            minimumDpMethod: "tesMinimumDpMethod1",
            minimumDpAmount: 123,
            minimumDpPercentage: 1.0,
            totalOtr: 123),
        Program(
            programId: "tesProgramId2",
            programName: "tesProgramName2",
            miNumber: 234,
            description: "tesDescripton2",
            periodStart: DateTime(2022),
            periodEnd: DateTime(2022),
            specialFeature: "tesSpecialFeature2",
            installmentType: "tesInstallmentType2",
            minimumDpMethod: "tesMinimumDpMethod2",
            minimumDpAmount: 234,
            minimumDpPercentage: 2.0,
            totalOtr: 234)
      ],
    ))));
    when(controller.submissionSectionController.realPrice)
        .thenReturn(RxInt(3000000));
  });

  tearDownAll(() {
    Get.delete<OptimusPromoMarketingController>();
  });

  group('Test Promo Marketing Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<OptimusPromoMarketingController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<OptimusPromoMarketingController>(), true);
    });

    test('submit tenor', () async {
      controller.dpIsValid.value = false;

      await controller.submitTenor().then((value) {
        expect(value, null);
      });
    });

    test('get calculate request', () {
      //arrange
      controller.programSelected.value = Program(
          programId: "tesProgramIdSelected",
          programName: "tesProgramNameSelected",
          miNumber: 123,
          description: "tesDescriptonSelected",
          periodStart: DateTime(2021),
          periodEnd: DateTime(2021),
          specialFeature: "tesSpecialFeatureSelected",
          installmentType: "tesInstallmentTypeSelected",
          minimumDpMethod: "tesMinimumDpMethodSelected",
          minimumDpAmount: 123,
          minimumDpPercentage: 1.0,
          totalOtr: 123);

      controller.inputDp.value = 2000000;

      //act
      var calculateRequest = controller.getCalculateRequest();

      //assert
      expect(calculateRequest.programId, "tesProgramIdSelected");
      expect(calculateRequest.customerId, 123);
      expect(calculateRequest.dpAmount, 2000000);
      expect(calculateRequest.totalOtr, 3000000);
      expect(calculateRequest.shippingFee, 0);
      expect(calculateRequest.insuranceShippingFee, 0);
    });

    test('check valid dp should return true when is show dp is false', () {
      //arrange
      when(controller.snapAndBuyWebController.isShowDp)
          .thenReturn(RxBool(false));

      //act
      //assert
      expect(controller.checkValidDp(), true);
    });

    test(
        'check valid dp should return false when real dp is greater than real price',
        () {
      //arrange
      when(controller.snapAndBuyWebController.isShowDp)
          .thenReturn(RxBool(true));
      controller.inputDp.value = 5000000;

      //assert
      expect(controller.checkValidDp(), false);
    });

    test(
        'check valid dp should return false when real dp is less than real price and min dp',
        () {
      //arrange
      when(controller.snapAndBuyWebController.isShowDp)
          .thenReturn(RxBool(true));
      when(controller.submissionSectionController.realPrice)
          .thenReturn(RxInt(5000000));
      controller.inputDp.value = 2000000;
      controller.minDp.value = 2500000;

      //act
      //assert
      expect(controller.checkValidDp(), false);
    });

    test(
        'check valid dp should return true when real dp is less than real price and greater than min dp',
        () {
      //arrange
      controller.minDp.value = 1500000;

      //act
      //assert
      expect(controller.checkValidDp(), true);
    });

    test('calculate installment', () async {
      //arrange
      when(controller.snapNBuyRepository
              .postApiCalculateInstallment(any, {}, ""))
          .thenAnswer((_) async => CalculateResponse(
                  code: 200,
                  message: "success",
                  data: <TenorData>[
                    TenorData(
                        firstInstallment: "tesFirstInstallment",
                        installmentAmount: 1000000,
                        insuranceFee: 10000,
                        rate: 1.0,
                        tenor: 6,
                        tenorLimit: 7,
                        adminFee: 20000,
                        totalPaymentAmount: 2000000,
                        subsidyAdminDealer: 1000,
                        subsidyRateDealer: 2000,
                        subsidyDealer: 3000,
                        payToDealerAmount: 4000,
                        productId: "tesProductId",
                        productOfferingId: "tesProductOfferingId",
                        totalOtr: 5000,
                        af: 6000,
                        ntf: 7000,
                        isAdminAsLoan: false,
                        sessionId: "tesSessionId")
                  ]));

      //act
      await controller.calculateInstallment().then((value) {
        //assert
        expect(controller.indexTenor, Rx<int?>(null));
        expect(controller.isShowErrorTenor.value, false);
        expect(controller.listTenor.length, 1);
        expect(controller.listTenor.first.status, false);
      });
    });

    test('get snb request', () {
      //arrange
      final product = CalculateRequest(
        programId: "tesProgramId",
        customerId: 1,
        dpAmount: 2000000,
        totalOtr: 3000000,
        insuranceShippingFee: 1000,
        shippingFee: 2000,
      );

      final assetData = AssetData(
          assetCode: "tesAssetCode",
          assetName: "tesAssetName",
          assetType: "tesAssetType",
          categoryCode: "tesCategoryCode",
          categoryName: "tesCategoryName");

      controller.programSelected.value = Program(
          programId: "tesProgramIdSelected",
          programName: "tesProgramNameSelected",
          miNumber: 123,
          description: "tesDescriptonSelected",
          periodStart: DateTime(2021),
          periodEnd: DateTime(2021),
          specialFeature: "tesSpecialFeatureSelected",
          installmentType: "tesInstallmentTypeSelected",
          minimumDpMethod: "tesMinimumDpMethodSelected",
          minimumDpAmount: 123,
          minimumDpPercentage: 1.0,
          totalOtr: 123);

      controller.tenorModel.value = TenorModel(
          status: false,
          firstInstallment: "tesFirstInstallment",
          installmentAmount: 1000000,
          insuranceFee: 10000,
          rate: 1.0,
          tenor: 6,
          tenorLimit: 7,
          adminFee: 20000,
          totalPaymentAmount: 2000000,
          subsidyAdminDealer: 1000,
          subsidyRateDealer: 2000,
          subsidyDealer: 3000,
          payToDealerAmount: 4000,
          productId: "tesProductId",
          productOfferingId: "tesProductOfferingId",
          totalOtr: 5000,
          af: 6000,
          ntf: 7000,
          isAdminAsLoan: false,
          sessionId: "tesSessionId");

      when(controller.snapAndBuyWebController.prospectId)
          .thenReturn(RxString("tesProspectId"));
      when(controller.submissionSectionController.phoneNumberController)
          .thenReturn(TextEditingController(text: "081234567890"));

      //act
      var snbRequest = controller.getSnbRequest(product, assetData);

      //assert
      expect(snbRequest.application!.aoId, "NONE");
      expect(snbRequest.assets!.length, 1);
      expect(snbRequest.assets!.first.assetCode, "tesAssetCode");
      expect(snbRequest.prospectId, "tesProspectId");
      expect(snbRequest.mobilePhone, "081234567890");
    });

    test('create snap and buy', (() async {
      //arrange
      when(controller.snapNBuyRepository
              .postApiCreateOrderSnapNBuy(any, {}, ""))
          .thenAnswer((_) async => CreateSnapNBuyResponse(
              code: 200,
              message: "success",
              data: CreateSnapNBuyData(
                  uniqueQrCode: "tesUniqueQrCode",
                  qrCodeUrl: "tesQrCodeUrl",
                  mediaType: "tesMediaType",
                  prospectId: "tesProspectId",
                  mobilePhone: "tesMobilePhone",
                  expiredAt: DateTime(2023),
                  timeNow: DateTime(2022))));

      when(controller.submissionSectionController.assetModel).thenReturn(Rx(
          AssetData(
              assetCode: "tesAssetCode",
              assetName: "tesAssetName",
              assetType: "tesAssetType",
              categoryCode: "tesCategoryCode",
              categoryName: "tesCategoryName")));

      //act
      await controller.createSnapAndBuy().then((value) {
        //assert
        expect(controller.createSnapNBuyResponse.value.code, 200);
      });
    }));

    test('on tap tenor', (() {
      //arrange
      final index = 0;
      DeasySizeConfigUtils.isMobile = false;

      controller.listTenor.add(TenorModel(
          status: false,
          firstInstallment: "tesFirstInstallment",
          installmentAmount: 1000000,
          insuranceFee: 10000,
          rate: 1.0,
          tenor: 6,
          tenorLimit: 7,
          adminFee: 20000,
          totalPaymentAmount: 2000000,
          subsidyAdminDealer: 1000,
          subsidyRateDealer: 2000,
          subsidyDealer: 3000,
          payToDealerAmount: 4000,
          productId: "tesProductId",
          productOfferingId: "tesProductOfferingId",
          totalOtr: 5000,
          af: 6000,
          ntf: 7000,
          isAdminAsLoan: false,
          sessionId: "tesSessionId"));

      //act
      when(controller.snapAndBuyWebController.activeSubSection)
          .thenReturn(Rx(SUB_SECTION.USAGE_LIMIT_SUB_SECTION));
      controller.onTapTenor(0);

      //assert
      expect(controller.listTenor[index].status, true);
      expect(controller.indexTenor.value, index);
      expect(controller.isShowErrorTenor.value, false);
      expect(controller.btnSubmitIsValid.value, true);
      expect(controller.snapAndBuyWebController.activeSubSection.value,
          SUB_SECTION.USAGE_LIMIT_SUB_SECTION);
      expect(controller.isShowUsageLimitCard.value, true);
    }));

    test('onChangePromo when minimum dp method is percentage', (() async {
      //arrange
      final program = Program(
          programName: "tesProgramName",
          minimumDpMethod: "percentage",
          minimumDpPercentage: 0.2,
          minimumDpAmount: 2000000);

      //act
      controller.onChangePromo(program);

      //assert
      expect(controller.promoController.text, program.programName);
      expect(controller.isShowTextFieldDp.value, true);
      expect(
          controller.minDp.value,
          (controller.submissionSectionController.realPrice.value *
                  program.minimumDpPercentage!) ~/
              100);
    }));

    test('onChangePromo when minimum dp method is not percentage', (() {
      //arrange
      final program = Program(
          programName: "tesProgramName",
          minimumDpMethod: "tesMinimumDpMethod",
          minimumDpPercentage: 0.2,
          minimumDpAmount: 2000000);

      //act
      controller.onChangePromo(program);

      //assert
      expect(controller.promoController.text, program.programName);
      expect(controller.isShowTextFieldDp.value, true);
      expect(controller.minDp.value, program.minimumDpAmount);
    }));

    test('clean up when submit tenor', (() {
      //act
      controller.cleanUpTenor();

      //assert
      expect(controller.inputDp.value, 0);
      expect(controller.dpController.text.isEmpty, true);
      expect(controller.listTenor.isEmpty, true);
      expect(controller.btnSubmitIsValid.value, false);
      expect(controller.isShowErrorTenor.value, false);
      expect(controller.programSelected.value, isInstanceOf<Program>());
      expect(controller.promoController.text.isEmpty, true);
    }));

    test('clean up when promo changes', (() {
      //act
      controller.cleanUpPromo();

      //assert
      expect(controller.isShowButtonTenor.value, true);
      expect(controller.isShowErrorTenor.value, false);
      expect(controller.btnTenorIsEdit.value, false);
      expect(controller.btnSubmitIsValid.value, false);
      expect(controller.inputDp.value, 0);
      expect(controller.dpController.text.isEmpty, true);
      expect(controller.listTenor.isEmpty, true);
    }));

    test('filter list promo', (() async {
      //arrange
      when(controller.snapAndBuyWebController.responseListProgram)
          .thenReturn(RxList(<Program>[
        Program(
            programId: "tesProgramId",
            programName: "tesProgramName",
            miNumber: 123,
            description: "tesDescripton",
            periodStart: DateTime(2021),
            periodEnd: DateTime(2021),
            specialFeature: "tesSpecialFeature",
            installmentType: "tesInstallmentType",
            minimumDpMethod: "tesMinimumDpMethod",
            minimumDpAmount: 123,
            minimumDpPercentage: 1.0,
            totalOtr: 123)
      ]));

      //act
      await controller.filterListPromo("tesProgramName").then((value) {
        //assert
        expect(value.length, 1);
        expect(value.first.programName, "tesProgramName");
      });
    }));

    test('select promo validation', (() {
      //arrange
      //act
      //assert
      expect(controller.selectPromoValidation(""), ValidationConstant.emptyPromo);

      //assert
      expect(controller.selectPromoValidation("test"), null);
    }));

    test('onChange price product', (() {
      //arrange
      final text = "3000000";
      controller.onChangePriceProduct(text);

      //assert
      expect(controller.inputDp.value, 3000000);
      expect(
          controller.dpController.value,
          TextEditingValue(
            text: text.toString().toCurrency(),
            selection: TextSelection.collapsed(
                offset: text.toString().toCurrency().length),
          ));
    }));

    test('check shopping summary mobile when isShow is true', (() {
      //arrange
      DeasySizeConfigUtils.isMobile = true;

      //act
      controller.checkShoppingSummaryMobile(isShow: true);

      //assert
      expect(controller.isShowShoppingSummaryMobile.value, true);
    }));

    test('check shopping summary mobile when isShow is false', (() {
      //arrange
      //act
      controller.checkShoppingSummaryMobile(isShow: false);

      //assert
      expect(controller.isShowShoppingSummaryMobile.value, false);
    }));

    test('check shopping summary mobile when isShow is null', (() {
      //arrange
      //act
      controller.checkShoppingSummaryMobile();

      //assert
      expect(controller.isShowShoppingSummaryMobile.value, null);
    }));

    test('get extra color dp when value is empty', (() {
      //arrange
      //act
      //assert
      expect(controller.getExtraColorDp(""), false);
    }));

    test(
        'get extra color dp when value is not empty and real dp is greater than min dp',
        (() {
      //arrange
      controller.inputDp.value = 2000000;
      controller.minDp.value = 1500000;
      //act
      //assert
      expect(controller.getExtraColorDp("test"), false);
    }));

    test(
        'get extra color dp when value is not empty and real dp is less than min dp',
        (() {
      //arrange
      controller.inputDp.value = 2000000;
      controller.minDp.value = 2500000;
      //act
      //assert
      expect(controller.getExtraColorDp("test"), true);
    }));

    test('refresh extra dp when real dp is greater than real price', (() {
      //arrange
      when(controller.submissionSectionController.realPrice)
          .thenReturn(RxInt(3000000));
      controller.inputDp.value = 3500000;

      //act
      controller.refreshExtraDp();

      //assert
      expect(controller.extraTextDp.value,
          ContentConstant.dpShouldBeSmallerThanProductPrice);
      expect(controller.extraTextDpIsRedColor.value, true);
      expect(controller.btnSubmitIsValid.value, false);
    }));

    test('refresh extra dp when real dp is less than real price and min dp',
        (() {
      //arrange
      controller.inputDp.value = 2000000;
      controller.minDp.value = 3000000;

      //act
      controller.refreshExtraDp();

      //assert
      expect(controller.extraTextDp.value,
          '${ContentConstant.minDp} ${controller.minDp.toString().toCurrency()}');
      expect(controller.extraTextDpIsRedColor.value, true);
      expect(controller.btnSubmitIsValid.value, false);
    }));

    test(
        'refresh extra dp when real dp is less than real price and greater than min dp',
        (() {
      //arrange
      controller.inputDp.value = 2000000;
      controller.minDp.value = 1500000;

      //act
      controller.refreshExtraDp();

      //assert
      expect(controller.extraTextDp.value,
          '${ContentConstant.minDp} ${controller.minDp.toString().toCurrency()}');
      expect(controller.extraTextDpIsRedColor.value, false);
    }));
  });
}
