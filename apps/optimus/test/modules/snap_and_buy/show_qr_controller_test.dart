import 'dart:typed_data';

import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/bindings/optimus_snb_base_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_show_qr_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_media_image_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/config/firebase_core_config_mock.dart';
import '../../mocks/snap_and_buy_mock.dart';


void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late OptimusShowQrCodeController controller;
  final mediaImageRepositoryMock = MediaImageRepositoryMock();

  final binding = BindingsBuilder(() {
    OptimusSnapAndBuyBaseBinding().dependencies();
    Get.lazyReplace<OptimusSnapAndBuyBaseController>(() => SnapAndBuyControllerMock());
    Get.lazyReplace<OptimusPromoMarketingController>(
        () => PromoMarketingControllerMock());
    Get.lazyReplace<OptimusSnapNBuyRepository>(() => SnapNBuyRepositoryMock());
    Get.lazyReplace<OptimusMediaImageRepository>(() => mediaImageRepositoryMock);
    Get.lazyReplace<OptimusSubmissionSectionController>(
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
    controller = Get.find<OptimusShowQrCodeController>();
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
    Get.delete<OptimusShowQrCodeController>();
  });

  group('Test Show QR Code Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<OptimusShowQrCodeController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<OptimusShowQrCodeController>(), true);
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
      when(controller.submissionSectionController.goToSubmissionSection())
          .thenReturn(null);

      //act
      controller.refreshQr();

      //assert
      expect(controller.timeHasEnded.value, false);
      expect(controller.snapAndBuyWebController.isShowDialogLimitQrCode.value,
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
      expect(controller.snapAndBuyWebController.activeMainSection.value,
          SECTION.PROMO_MARKETING_SECTION);
      expect(controller.snapAndBuyWebController.activeSubSection.value,
          SUB_SECTION.NULL_SUB_SECTION);
    }));
  });
}
