import 'dart:typed_data';

import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/bindings/bumblebee_snb_base_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_show_qr_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_media_image_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late BumblebeeShowQrCodeController controller;
  final mediaImageRepositoryMock = MediaImageRepositoryMock();

  final binding = BindingsBuilder(() {
    BumblebeeSnapAndBuyBaseBinding().dependencies();
    Get.lazyReplace<BumblebeeSnapAndBuyBaseController>(() => SnapAndBuyControllerMock());
    Get.lazyReplace<BumblebeePromoMarketingController>(
        () => PromoMarketingControllerMock());
    Get.lazyReplace<BumblebeeSnapNBuyRepository>(() => SnapNBuyRepositoryMock());
    Get.lazyReplace<BumblebeeMediaImageRepository>(() => mediaImageRepositoryMock);
    Get.lazyReplace<BumblebeeSubmissionSectionController>(
        () => SubmissionSectionControllerMock());
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues(
        {KEY_PREFERENCES.retryGenerateQrCount: 10});
    SharedPreferences.setMockInitialValues({KEY_PREFERENCES.qrCodeTimer: 20});
    when(mediaImageRepositoryMock.getImagesUint8List(any, any))
        .thenAnswer((_) async => Uint8List(10));
    binding.builder();
    controller = Get.find<BumblebeeShowQrCodeController>();
    when(controller.promoMarketingController.createSnapNBuyResponse).thenReturn(
        Rx(CreateSnapNBuyResponse(
            code: 200,
            message: 'success',
            data: CreateSnapNBuyData(
                uniqueQrCode: "tesUniqueQrCode",
                qrCodeUrl: "tesQrCodeUrl",
                mediaType: "tesMediaType",
                prospectId: "tesProspectId",
                mobilePhone: "tesMobilePhone",
                expiredAt: DateTime(2022),
                timeNow: DateTime(2021)))));
  });

  tearDownAll(() {
    Get.delete<BumblebeeShowQrCodeController>();
  });

  group('Test Show QR Code Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeShowQrCodeController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<BumblebeeShowQrCodeController>(), true);
    });

    test('fetch image from qr code url throw error exception', (() async {
      //arrange
      when(mediaImageRepositoryMock.getImagesUint8List(any, any))
          .thenAnswer((_) async => throw Exception());

      //act
      await controller
          .fetchImageFromQRCodeUrl(
              controller.promoMarketingController.createSnapNBuyResponse.value)
          .then((value) {
        //assert
        expect(controller.isLoading.value, false);
      });
    }));

    test('fetch image from qr code url', (() async {
      //arrange
      when(mediaImageRepositoryMock.getImagesUint8List(any, any))
          .thenAnswer((_) async => Uint8List(10));
      //act
      await controller
          .fetchImageFromQRCodeUrl(
              controller.promoMarketingController.createSnapNBuyResponse.value)
          .then((value) {
        //assert
        expect(
            controller.data.value!.prospectId,
            controller.promoMarketingController.createSnapNBuyResponse.value
                .data!.prospectId);
        expect(controller.listImage.value!.length, 10);
      });
    }));

    test(
        'refresh qr when try retry create snb is greater than retry generate qr count and is not mobile',
        (() {
      //arrange
      controller.tryRetryCreateSnb.value = 1;
      controller.retryGenerateQrCount.value = 1;
      DeasySizeConfigUtils.isDesktopOrWeb = true;
      when(controller.snapAndBuyWebController.activeMainSection)
          .thenReturn(Rx(SECTION.SUBMISSION_SECTION));
      when(controller.snapAndBuyWebController.activeSubSection)
          .thenReturn(Rx(SUB_SECTION.NULL_SUB_SECTION));
      when(controller.snapAndBuyWebController.isShowDialogLimitQrCode)
          .thenReturn(RxBool(true));
      when(controller.submissionSectionController
              .goToSubmissionSection())
          .thenReturn(null);

      //act
      controller.refreshQr();

      //assert
      expect(controller.timeHasEnded.value, false);
      expect(
          controller
              .snapAndBuyWebController.isShowDialogLimitQrCode.value,
          true);
      expect(controller.tryRetryCreateSnb.value, 0);
    }));

    test(
        'refresh qr when try retry create snb is less than retry generate qr count',
        (() {
      //arrange
      controller.tryRetryCreateSnb.value = 1;
      controller.retryGenerateQrCount.value = 3;
      when(controller.promoMarketingController.refreshProspectId())
          .thenAnswer((_) async => null);
      when(controller.promoMarketingController.createSnapAndBuy()).thenAnswer(
          ((_) async => null) as Future<CreateSnapNBuyResponse> Function(
              Invocation));

      //act
      controller.refreshQr();

      //assert
      expect(controller.data.value, null);
    }));

    test('on end', (() {
      //arrange
      //act
      controller.onEnd();

      //assert
      expect(controller.timeHasEnded.value, true);
    }));

    test('back to promo marketing section', (() {
      //arrange
      when(controller.snapAndBuyWebController.activeMainSection)
          .thenReturn(Rx(SECTION.PROMO_MARKETING_SECTION));
      when(controller.snapAndBuyWebController.activeSubSection)
          .thenReturn(Rx(SUB_SECTION.NULL_SUB_SECTION));

      //act
      controller.backToPromoMarketingSection();

      //assert
      expect(
          controller.snapAndBuyWebController.activeMainSection.value,
          SECTION.PROMO_MARKETING_SECTION);
      expect(
          controller.snapAndBuyWebController.activeSubSection.value,
          SUB_SECTION.NULL_SUB_SECTION);
    }));
  });
}
