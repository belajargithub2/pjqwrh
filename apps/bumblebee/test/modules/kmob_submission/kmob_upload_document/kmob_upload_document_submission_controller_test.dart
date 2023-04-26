import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:mockito/mockito.dart';

import '../kmob_submission_dummy.dart';
import '../../../mocks/build_context_mock.dart';
import '../mock/kmob_submission_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  MockBuildContext? _mockBuildContext;
  late BumblebeeKMOBUploadDocumentSubmissionController controller;
  KMOBConsumerDataSubmissionControllerMock _kmobConsumerDataSubmissionControllerMock = KMOBConsumerDataSubmissionControllerMock();
  KMOBSubmissionControllerMock _kmobSubmissionControllerMock = KMOBSubmissionControllerMock();

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeDraftRepository>(() => DraftRepositoryMock());
    Get.lazyPut<BumblebeeKMOBAssetDataSubmissionController>(() => KMOBAssetDataSubmissionControllerMock());
    Get.lazyPut<BumblebeeKMOBConsumerDataSubmissionController>(() => KMOBConsumerDataSubmissionControllerMock());
    Get.lazyPut<BumblebeeKMOBSubmissionController>(() => KMOBSubmissionControllerMock());
    Get.lazyPut<BumblebeeKMOBSubmissionRepository>(() => KMOBSubmissionRepositoryMock());

    Get.lazyPut<BumblebeeKMOBUploadDocumentSubmissionController>(
            () =>
            BumblebeeKMOBUploadDocumentSubmissionController(
              kmobAssetDataSubmissionController: KMOBAssetDataSubmissionControllerMock(),
              draftRepository: Get.find(),
              kmobConsumerDataSubmissionController: _kmobConsumerDataSubmissionControllerMock,
              kmobSubmissionController: _kmobSubmissionControllerMock,
              kmobSubmissionRepository: Get.find(),
            ));
  });

  setUp(() async {
    when(_kmobConsumerDataSubmissionControllerMock.isMarried).thenReturn(RxBool(false));
    when(_kmobSubmissionControllerMock.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));
    when(_kmobSubmissionControllerMock.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
    when(_kmobSubmissionControllerMock.prospectId).thenReturn(RxString('123456789'));

    _mockBuildContext = MockBuildContext();
    binding.builder();
    controller = Get.find<BumblebeeKMOBUploadDocumentSubmissionController>();
  });

  group('Test BumblebeeKMOBUploadDocumentSubmissionController', () {
    test('should return true when controller is initialized', () {
      expect(controller.initialized, true);
    });
  });

  group('Test addMarriedItemList', () {
    test('should return 4 length of list ', () {
      // arrange
      controller.listUpload.clear();

      // act
      controller.addMarriedItemList();

      // assert
      expect(controller.listUpload.length, 4);
    });
  });

  group('Test addUnMarriedItemList', () {
    test('should return 3 length of list ', () {
      // arrange
      controller.listUpload.clear();

      // act
      controller.addUnMarriedItemList();

      // assert
      expect(controller.listUpload.length, 3);
    });
  });

  group('Test isNullEmptyOrFalse', () {
    test('should return true when value is null', () {
      // arrange
      controller.listUpload.clear();

      // act
      final result = controller.isNullEmptyOrFalse(null);

      // assert
      expect(result, true);
    });

    test('should return true when value is empty', () {
      // act
      final result = controller.isNullEmptyOrFalse('');

      // assert
      expect(result, true);
    });

    test('should return true when value is false', () {
      // act
      final result = controller.isNullEmptyOrFalse(false);

      // assert
      expect(result, true);
    });

    test('should return false when value is true', () {
      // act
      final result = controller.isNullEmptyOrFalse(true);

      // assert
      expect(result, false);
    });
  });

  group('Test submit', () {
    test('should return true when call submit', () {
      // arrange
      controller.isShowDialogOrder.value = false;

      // act
      controller.submit();

      // assert
      expect(controller.isShowDialogOrder.value, true);
    });
  });

  group('Test onTapDraft', () {
    test('should return true when call onTapDraft', () {
      // arrange
      controller.isShowDialogDraft.value = false;

      // act
      controller.onTapDraft();

      // assert
      expect(controller.isShowDialogDraft.value, true);
    });
  });

  group('Test saveToLocal', () {
    test('should return true when call saveToLocal', () {
      // arrange
      String imageUrl = 'https://www.google.com';
      String typeName = 'KTP';
      when(controller.kmobSubmissionController!.source)
          .thenReturn(Rx<AgentSubmission>(AgentSubmission.DRAFT));

      // act
      controller.saveToLocal(imageUrl, typeName);

      // assert
      expect(controller.isShowDialogDraft.value, true);
    });
  });

  group('Test setDataDataToLocal', () {
    test('should return url image when tyName is KTP Konsumen', () async {
      // arrange
      String imageUrl = 'https://www.google.com';
      String typeName = 'KTP Konsumen';
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      final result = await controller.setDataDataToLocal(
          imageUrl: imageUrl, typeName: typeName);

      // assert
      expect(result.photoKkUrl, imageUrl);
    });

    test('should return url image when tyName is KTP Pasangan', () async {
      // arrange
      String imageUrl = 'https://www.google.com';
      String typeName = 'KTP Pasangan';
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      final result = await controller.setDataDataToLocal(
          imageUrl: imageUrl, typeName: typeName);

      // assert
      expect(result.photoSpouseKtpUrl, imageUrl);
    });

    test('should return url image when typeName is Kartu keluarga', () async {
      // arrange
      String imageUrl = 'https://www.google.com';
      String typeName = 'Kartu keluarga';
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      final result = await controller.setDataDataToLocal(
          imageUrl: imageUrl, typeName: typeName);

      // assert
      expect(result.photoKkUrl, imageUrl);
    });

    test('should return url image when typeName is STNK', () async {
      // arrange
      String imageUrl = 'https://www.google.com';
      String typeName = 'STNK';
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      final result = await controller.setDataDataToLocal(
          imageUrl: imageUrl, typeName: typeName);

      // assert
      expect(result.photoStnkUrl, imageUrl);
    });
  });

  group('Test getUrlImage', () {
    test('should return empty Url image when tyName is empty', () {
      // arrange
      String typename = '';
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      String? url = controller.getUrlImage(typename);

      // assert
      expect(url, isEmpty);
    });

    test('should return url image when tyName is KTP Konsumen', () {
      // arrange
      String typename = 'KTP Konsumen';
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      String? url = controller.getUrlImage(typename);

      // assert
      expect(url, kmobSubmissionModelDummy.photoKtpUrl);
    });

    test('should return url image when tyName is KTP Pasangan', () {
      // arrange
      String typename = 'KTP Pasangan';
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      String? url = controller.getUrlImage(typename);

      // assert
      expect(url, kmobSubmissionModelDummy.photoSpouseKtpUrl);
    });

    test('should return url image when tyName is Kartu keluarga', () {
      // arrange
      String typename = 'Kartu keluarga';
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.kmobSubmissionModel)
          .thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      String? url = controller.getUrlImage(typename);

      // assert
      expect(url, kmobSubmissionModelDummy.photoKkUrl);
    });

    test('should return url image when tyName is STNK', () {
      // arrange
      String typename = 'STNK';
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.kmobSubmissionModel).thenReturn(
          Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));

      // act
      String? url = controller.getUrlImage(typename);

      // assert
      expect(url, kmobSubmissionModelDummy.photoStnkUrl);
    });
  });

  group('Test addMarriedItemList', () {
    test('should return typeName is name of UploadImageModel', () {
      // arrange
      UploadImageModel uploadImageModel = UploadImageModel(
        name: 'KTP',
        key: keyUploadImageEnum.STNK,
        documentType: 'STNK',
      );

      // act
      controller.setValue(uploadImageModel);

      // assert
      expect(controller.typeName.value, 'KTP');
    });
  });

  group('Test getImageStnkFromDraftOrLocal', () {
    test('should return url image when call getImageStnkFromDraftOrLocal', () async {
      // arrange
      when(controller.kmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.DRAFT));
      when(controller.kmobSubmissionController!.prospectId).thenReturn(RxString('123456789'));

      // act
      await controller.getImageStnkFromDraftOrLocal();

      // assert
      expect(controller.kmobSubmissionController!.kmobSubmissionModel.value.photoStnkUrl, kmobSubmissionModelDummy.photoStnkUrl);
    });
  });

  group('Test checkUrlIsAvailable', () {
    test('should return list have length greater than 0', () async {
      // arrange
      String imagePath = "https://www.google.com";
      String typeName = "KTP Konsumen";
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));

      // act
      controller.checkUrlIsAvailable(imagePath, typeName);

      // assert
      expect(controller.listUpload.length, greaterThan(0));
    });
  });

  group('Test agentOrderController', () {
    test('should return true when call agenOrder', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.agentOrder(any, {})).thenAnswer((_) async => responseAgentOrderDummy);

      controller.listUpload.value = [
        UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
        UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
      ];

      // act
      await controller.agentOrder(_mockBuildContext);

      // assert
      expect(controller.successValidation.value, true);
    });
  });

  group('Test onReady', () {
    test('should return url image when call onReady', () async {
      // arrange
      when(controller.kmobConsumerDataSubmissionController!.isMarried).thenReturn(RxBool(true));

      // act
      controller.onReady();

      // assert
      expect(controller.kmobSubmissionController!.kmobSubmissionModel.value.photoSpouseKtpUrl, kmobSubmissionModelDummy.photoSpouseKtpUrl);
    });
  });


  group('Test onTapSaveDraft', () {
    test('should return true when call onTapSaveDraft', () async {
      // arrange
      when(controller.draftRepository!.saveToDraft(any, {})).thenAnswer((_) async => responseSaveToDraftDummy);
      controller.listUpload.value = listUploadDummy;

      // act
      controller.onTapSaveDraft(_mockBuildContext);

      // assert
      expect(controller.successValidation.value, true);
    });
  });

  group('Test addItemToList', () {
    test('should return 4 length if status is married', () async {
      // arrange
      controller.listUpload.clear();
      controller.isMarried.value = true;

      // act
      await controller.addItemToList();

      // assert
      expect(controller.listUpload.length, 4);
    });

    test('should return 3 length if status is not married', () async {
      // arrange
      controller.listUpload.clear();
      controller.isMarried.value = false;

      // act
      await controller.addItemToList();

      // assert
      expect(controller.listUpload.length, 3);
    });
  });

  group('Test deleteLocal', () {
    test('should return verify called 1', () async {
      // arrange
      when(controller.kmobSubmissionController!.deleteLocalRecord()).thenAnswer((_) async => returnsNormally );

      // act
      controller.deleteLocal();

      // assert
      verify(controller.deleteLocal()).called(1);
    });
  });

  group('Test getImageKkFromDraftOrLocal', () {
    test('should return url image when call getImageKkFromDraftOrLocal', () async {
      // arrange
      when(controller.kmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.DRAFT));

      // act
      await controller.getImageKkFromDraftOrLocal();

      // assert
      expect(controller.kmobSubmissionController!.kmobSubmissionModel.value.photoKkUrl, kmobSubmissionModelDummy.photoKkUrl);
    });
  });

  group('Test getImageKtpPasanganFromDraft', () {
    test('should return url image when call getImageKtpPasanganFromDraft', () async {
      // arrange
      controller.listUpload.clear();
      controller.addMarriedItemList();
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));

      // act
      await controller.getImageKtpPasanganFromDraft();

      // assert
      expect(controller.kmobSubmissionController!.kmobSubmissionModel.value.photoSpouseKtpUrl, kmobSubmissionModelDummy.photoSpouseKtpUrl);
    });
  });

  group('Test getImageKtpFromDraftOrLocal', () {
    test('should return url image when call getImageKtpFromDraftOrLocal', () async {
      // arrange
      controller.listUpload.clear();
      controller.addUnMarriedItemList();
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));

      // act
      await controller.getImageKtpFromDraftOrLocal();

      // assert
      expect(controller.kmobSubmissionController!.kmobSubmissionModel.value.photoKtpUrl, kmobSubmissionModelDummy.photoKtpUrl);
    });
  });

  group('Test getRequestAgentOrder', () {
    test('should return request agent order when call getRequestAgentOrder', () async {

      // arrange
      controller.listUpload.clear();
      controller.listUpload.value = listUploadMarriedDummy;
      when(controller.kmobSubmissionController!.agentId).thenReturn(RxString('007007'));
      when(controller.kmobSubmissionController!.typeOfLob).thenReturn(RxString("KMOB"));

      ///asset data
      when(controller.kmobAssetDataSubmissionController!.bpkbOwnerShipStatusId).thenReturn(RxString("L"));
      when(controller.kmobAssetDataSubmissionController!.disbursedAmount).thenReturn(RxInt(10000000));
      when(controller.kmobAssetDataSubmissionController!.licenseAreaController).thenReturn(TextEditingController(text: "B"));
      when(controller.kmobAssetDataSubmissionController!.licenseCodeController).thenReturn(TextEditingController(text: "AB"));
      when(controller.kmobAssetDataSubmissionController!.licenseNumberController).thenReturn(TextEditingController(text: "1234"));
      when(controller.kmobAssetDataSubmissionController!.vehicleBrandController).thenReturn(TextEditingController(text: "Toyota"));
      when(controller.kmobAssetDataSubmissionController!.vehicleModelController).thenReturn(TextEditingController(text: "Avanza"));
      when(controller.kmobAssetDataSubmissionController!.vehicleRegistrationNameController).thenReturn(TextEditingController(text: "Atung"));
      when(controller.kmobAssetDataSubmissionController!.vehicleTypeController).thenReturn(TextEditingController(text: "Sedan"));
      when(controller.kmobAssetDataSubmissionController!.vehicleYearController).thenReturn(TextEditingController(text: "2019"));

      ///consumer data
      when(controller.kmobConsumerDataSubmissionController!.birthDateController).thenReturn(TextEditingController(text: "1490-01-01"));
      when(controller.kmobConsumerDataSubmissionController!.birthPlaceController).thenReturn(TextEditingController(text: "Jakarta"));
      when(controller.kmobConsumerDataSubmissionController!.branchId).thenReturn(RxString("007"));
      when(controller.kmobConsumerDataSubmissionController!.customerNameController).thenReturn(TextEditingController(text: "Atung"));
      when(controller.kmobConsumerDataSubmissionController!.genderController).thenReturn(TextEditingController(text: "L"));
      when(controller.kmobConsumerDataSubmissionController!.idNumberController).thenReturn(TextEditingController(text: "012312312312321"));
      when(controller.kmobConsumerDataSubmissionController!.customerNameController).thenReturn(TextEditingController(text: "Atung"));
      when(controller.kmobConsumerDataSubmissionController!.maritalStatusId).thenReturn(RxString("M"));
      when(controller.kmobConsumerDataSubmissionController!.moId).thenReturn(RxString("007"));
      when(controller.kmobConsumerDataSubmissionController!.moName).thenReturn(RxString("Atung"));
      when(controller.kmobConsumerDataSubmissionController!.mobilePhoneController).thenReturn(TextEditingController(text: "08123456789"));
      when(controller.kmobConsumerDataSubmissionController!.spouseBirthDateController).thenReturn(TextEditingController(text: "1490-01-01"));
      when(controller.kmobConsumerDataSubmissionController!.spouseBirthPlaceController).thenReturn(TextEditingController(text: "Jakarta"));
      when(controller.kmobConsumerDataSubmissionController!.spouseGenderController).thenReturn(TextEditingController(text: "F"));
      when(controller.kmobConsumerDataSubmissionController!.spouseIdNumberController).thenReturn(TextEditingController(text: "012312312312321"));
      when(controller.kmobConsumerDataSubmissionController!.spouseNameController).thenReturn(TextEditingController(text: "Atung"));
      when(controller.kmobConsumerDataSubmissionController!.spouseMobilePhoneController).thenReturn(TextEditingController(text: "08123456789"));
      when(controller.kmobConsumerDataSubmissionController!.spouseNameController).thenReturn(TextEditingController(text: "Atung"));
      when(controller.kmobConsumerDataSubmissionController!.spouseSurgateMotherNameController).thenReturn(TextEditingController(text: "Jamila"));
      when(controller.kmobConsumerDataSubmissionController!.surgateMotherNameController).thenReturn(TextEditingController(text: "Luna maya"));
      when(controller.kmobConsumerDataSubmissionController!.agentIdConfins).thenReturn(RxString('0034832'));

      // act
      final result = controller.getRequestAgentOrder();

      // assert
      expect(result, requestAgentOrdersDummy.toJson());
    });
  });
}
