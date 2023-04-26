import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_review_image_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';

import '../kmob_submission_dummy.dart';
import '../../../mocks/build_context_mock.dart';
import '../mock/kmob_submission_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  MockBuildContext? _mockBuildContext;
  late BumblebeeKMOBReviewImageController controller;

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeKMOBUploadDocumentSubmissionController>(() => KMOBUploadDocumentSubmissionControllerMock());
    Get.lazyPut<BumblebeeKMOBSubmissionController>(() => KMOBSubmissionControllerMock());
    Get.lazyPut<BumblebeeKMOBSubmissionRepository>(() => KMOBSubmissionRepositoryMock());

    Get.lazyPut(() => BumblebeeKMOBReviewImageController(
          kmobUploadDocumentSubmissionController: KMOBUploadDocumentSubmissionControllerMock(),
          kmobSubmissionController: KMOBSubmissionControllerMock(),
          kmobSubmissionRepository: KMOBSubmissionRepositoryMock(),
        ));
  });

  setUp(() async {
    binding.builder();
    controller = Get.find<BumblebeeKMOBReviewImageController>();
    _mockBuildContext = MockBuildContext();
  });

  group('Test KMOB review Controller', () {
    test('should return true when Controller is initialized', () async {
      bool test = Get.isRegistered<BumblebeeKMOBReviewImageController>();
      expect(test, true);
      expect(controller.initialized, true);
    });
  });


  group('Test uploadStnk', () {
    test('should return image url when uploadStnk is called ', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.uploadStnk(any, any.toString(), any.toString(), {})).thenAnswer((_) async => responseUploadImageKmobDummy);
      when(controller.kmobSubmissionController!.prospectId).thenReturn(RxString("123456"));

      // act
      await controller.uploadStnk(_mockBuildContext, fileKey: keyUploadImageEnum.STNK.name, documentType: "photo_stnk");

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });
  });

  group('Test uploadKk', () {
    test('should return image url when uploadKk is called ', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.uploadKk(any, any.toString(), any.toString(),
          {})).thenAnswer((_) async => responseUploadImageKmobDummy);

      // act
      await controller.uploadKk(_mockBuildContext, fileKey: keyUploadImageEnum.KARTU_KELUARGA.name, documentType: "photo_kk");

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });
  });

  group('Test uploadKtp', () {
    test('should return image url when uploadKtp is called ', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.uploadKtp(any, any.toString(), any.toString(), {})).thenAnswer((_) async => responseUploadImageKmobDummy);

      // act
      await controller.uploadKtp(_mockBuildContext, fileKey: keyUploadImageEnum.KTP.name, documentType: "photo_ktp");

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });
  });

  group('Test uploadImage', () {
    test('should return image url when document is ktp ', () async {
      // arrange
      controller.kmobUploadDocumentSubmissionController!.imageKey = keyUploadImageEnum.KTP;
      when(controller.kmobUploadDocumentSubmissionController!.documentType).thenReturn(RxString("photo_ktp"));
      when(controller.kmobUploadDocumentSubmissionController!.imageKey).thenReturn(keyUploadImageEnum.KTP);

      // act
      controller.uploadImage(_mockBuildContext);

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });

    test('should return image url when document is kk ', () async {
      // arrange
      controller.kmobUploadDocumentSubmissionController!.imageKey = keyUploadImageEnum.KARTU_KELUARGA;
      when(controller.kmobUploadDocumentSubmissionController!.documentType).thenReturn(RxString("photo_kk"));
      when(controller.kmobUploadDocumentSubmissionController!.imageKey).thenReturn(keyUploadImageEnum.KARTU_KELUARGA);

      // act
      controller.uploadImage(_mockBuildContext);

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });

    test('should return image url when document is stnk ', () async {
      // arrange
      controller.kmobUploadDocumentSubmissionController!.imageKey = keyUploadImageEnum.STNK;
      when(controller.kmobUploadDocumentSubmissionController!.documentType).thenReturn(RxString("photo_stnk"));
      when(controller.kmobUploadDocumentSubmissionController!.imageKey).thenReturn(keyUploadImageEnum.STNK);

      // act
      controller.uploadImage(_mockBuildContext);

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });

    test('should return image url when document is spouse ktp ', () async {
      // arrange
      controller.kmobUploadDocumentSubmissionController!.imageKey = keyUploadImageEnum.KTP_PASANGAN;
      when(controller.kmobUploadDocumentSubmissionController!.documentType).thenReturn(RxString("KTP_PASANGAN"));
      when(controller.kmobUploadDocumentSubmissionController!.imageKey).thenReturn(keyUploadImageEnum.KTP_PASANGAN);

      // act
      controller.uploadImage(_mockBuildContext);

      // assert
      expect(controller.imageUrl.value, responseUploadImageKmobDummy.data!.mediaUrl);
    });
  });

}