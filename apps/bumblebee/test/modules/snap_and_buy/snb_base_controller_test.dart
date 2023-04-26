import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/bindings/bumblebee_snb_base_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_request.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_prospect_id_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';


void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late BumblebeeSnapAndBuyBaseController controller;

  final listPromoMarketingRequest = ListPromoMarketingRequest();

  final binding = BindingsBuilder(() {
    BumblebeeSnapAndBuyBaseBinding().dependencies();
    Get.lazyReplace<BumblebeeSnapNBuyRepository>(() => SnapNBuyRepositoryMock());
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues({});
    binding.builder();
    controller = Get.find<BumblebeeSnapAndBuyBaseController>();
  });

  tearDownAll(() {
    Get.delete<BumblebeeSnapAndBuyBaseController>();
  });

  group('Test Snap And Buy Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeSnapAndBuyBaseController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<BumblebeeSnapAndBuyBaseController>(), true);
    });

    test('back to promo marketing section', () {
      //arrange
      //act
      controller.backToPromoMarketingSection();

      //assert
      expect(controller.stepIndex.value, 1);
      expect(
          controller.activeMainSection.value, SECTION.PROMO_MARKETING_SECTION);
      expect(controller.activeSubSection.value, SUB_SECTION.NULL_SUB_SECTION);
    });

    test('submit submission', () async {
      //arrange
      controller.isShowDialogPhoneNumberNotFound.value = false;
      controller.isShowDialogNeedVerification.value = false;

      when(controller.bumblebeeSnapNBuyRepository
              .getListPromoMarketing(any, {}))
          .thenAnswer((_) async => ListPromoMarketingResponse(
              data: Data(
                  customerStatus: CustomerStatus(
                      isRegisteredKreditmu: false,
                      customerRegisterStatus: "NEW"))));

      //act
      await controller.submitSubmission(listPromoMarketingRequest);

      //assert
      expect(controller.isShowDialogPhoneNumberNotFound.value, true);
      expect(controller.isShowDialogNeedVerification.value, false);
    });

    test('go to qr code section', () {
      //arrange
      //act
      controller.goToQrCodeSection();

      //assert
      expect(controller.stepIndex.value, 2);
      expect(controller.activeMainSection.value, SECTION.SHOW_QR_CODE_SECTION);
      expect(controller.activeSubSection.value, SUB_SECTION.HOW_TO_SCAN);
    });

    test('go to submission section', () {
      //arrange
      //act
      controller.goToSubmissionSection();

      //assert
      expect(controller.stepIndex.value, 0);
      expect(controller.activeMainSection.value, SECTION.SUBMISSION_SECTION);
      expect(controller.activeSubSection.value, SUB_SECTION.NULL_SUB_SECTION);
    });

    test('turn on loading not web', () {
      //act
      controller.turnOnLoading();

      //assert
      expect(controller.isLoading.value, true);
    });

    test('turn off loading not web', () {

      //act
      controller.turnOffLoading();

      //assert
      expect(controller.isLoading.value, false);
    });

    test('hidden sub section', () {
      //arrange
      //act
      controller.hiddenSubsection();

      //assert
      expect(controller.activeSubSection.value, SUB_SECTION.NULL_SUB_SECTION);
    });

    test('generate prospect id', () async {
      //arrange
      when(controller.bumblebeeSnapNBuyRepository.generateProspectId(any, any))
          .thenAnswer((_) async => ProspectIdResponse(
              data: ProspectIdData(prospectId: "tesProspectId"),
              message: "tesMessage"));

      //act
      await controller.generateProspectId();

      //assert
      expect(controller.prospectId.value, "tesProspectId");
    });

    test(
        'get list promo marketing when is registered kreditmu is false and customer register status is new',
        () async {
      //arrange
      controller.isShowDialogPhoneNumberNotFound.value = false;
      controller.isShowDialogNeedVerification.value = false;

      when(controller.bumblebeeSnapNBuyRepository
              .getListPromoMarketing(any, {}))
          .thenAnswer((_) async => ListPromoMarketingResponse(
              data: Data(
                  customerStatus: CustomerStatus(
                      isRegisteredKreditmu: false,
                      customerRegisterStatus: "NEW"))));

      //act
      await controller
          .getListPromoMarketing(listPromoMarketingRequest)
          .then((value) {
        //assert
        expect(controller.isShowDialogPhoneNumberNotFound.value, true);
        expect(controller.isShowDialogNeedVerification.value, false);
      });
    });

    test('get list promo marketing when need verification', () async {
      //arrange
      controller.isShowDialogPhoneNumberNotFound.value = false;
      controller.isShowDialogNeedVerification.value = false;

      when(controller.bumblebeeSnapNBuyRepository
              .getListPromoMarketing(any, {}))
          .thenAnswer((_) async => ListPromoMarketingResponse(
              data: Data(
                  customerStatus: CustomerStatus(
                      customerRegisterStatus: "TES",
                      limitStatus: "TES",
                      dataVerification: false,
                      faceVerification: false))));

      //act
      await controller
          .getListPromoMarketing(listPromoMarketingRequest)
          .then((value) {
        //assert
        expect(controller.isShowDialogPhoneNumberNotFound.value, false);
        expect(controller.isShowDialogNeedVerification.value, true);
      });
    });

    test(
        'get list promo marketing when is registered kreditmu and no need verification',
        () async {
      //arrange
      when(controller.bumblebeeSnapNBuyRepository
              .getListPromoMarketing(any, {}))
          .thenAnswer((_) async => ListPromoMarketingResponse(
                code: 123,
                data: Data(
                    customerStatus: CustomerStatus(
                        isRegisteredKreditmu: false,
                        dataVerification: true,
                        faceVerification: true),
                    programs: <Program>[Program(programId: "tesProgramId")]),
              ));

      //act
      await controller
          .getListPromoMarketing(listPromoMarketingRequest)
          .then((value) {
        //assert
        expect(controller.responseListProgram.length, 1);
        expect(controller.responseListProgram.first.programId, "tesProgramId");
        expect(controller.listPromoMarketingResponse.value.code, 123);
        expect(controller.activeMainSection.value,
            SECTION.PROMO_MARKETING_SECTION);
        expect(controller.stepIndex.value, 1);
      });
    });
  });
}
