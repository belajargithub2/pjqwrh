import 'dart:async';

import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/bindings/bumblebee_kmob_submission_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_local_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kmob_submission_dummy.dart';
import '../../mocks/build_context_mock.dart';
import 'mock/kmob_submission_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  late BumblebeeKMOBSubmissionController controller;
  MockBuildContext? _mockBuildContext;

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeDraftRepository>(() => DraftRepositoryMock());
    Get.lazyPut<BumblebeeLocalRepository>(() => LocalRepositoryMock());
    Get.lazyPut<BumblebeeKMOBSubmissionRepository>(() => KMOBSubmissionRepositoryMock());

    Get.lazyPut<BumblebeeKMOBSubmissionController>(
      () => BumblebeeKMOBSubmissionController(
        draftRepository: Get.find(),
        localRepository: Get.find(),
        kmobSubmissionRepository: Get.find(),
      ),
    );
  });

  setUp(() {
    setAgentIdAndSupplierId();
    _mockBuildContext = MockBuildContext();
    binding.builder();
  });

  group('Test KMOB Submission Controller', () {
    test('should return true when controller is initialized', () async {
      controller = Get.find<BumblebeeKMOBSubmissionController>();
      expect(controller.initialized, true);
    });
  });

  group('Test KMOBSubmissionController', () {

    test('should return true when KMOBSubmissionController isRegistered', () async {
      BumblebeeKMOBSubmissionBinding().dependencies();
      expect(Get.isRegistered<BumblebeeKMOBSubmissionController>(), true);
      expect(Get.isRegistered<BumblebeeDraftRepository>(), true);
      expect(Get.isRegistered<BumblebeeLocalRepository>(), true);
    });

    test('should be a subclass of GetxController', () {
      expect(Get.find<BumblebeeKMOBSubmissionController>(), isA<GetxController>());
    });

    test('should have a property called draftRepository', () {
      expect(Get.find<BumblebeeKMOBSubmissionController>().draftRepository,
          isA<BumblebeeDraftRepository>());
    });

    test('should have a property called localRepository', () {
      expect(Get.find<BumblebeeKMOBSubmissionController>().localRepository,
          isA<BumblebeeLocalRepository>());
    });
  });

  group('Test goToAssetSection', () {
    test('should return index 1 of goToAssetSection', () async {
      // act
      controller.goToAssetSection();

      // assert
      expect(controller.index.value, 1);
    });
  });

  group('Test get local submission', () {
    test('should return list of kmob submission', () async {
      // arrange
      when(controller.getLocalSubmission())
          .thenAnswer((_) async => [responseLocalGetSubmission]);

      // act
      final result = await controller.localRepository!.getLocalRecord();

      // assert
      final resultList = result.isBlank! ? [] : result;
      expect(resultList, [responseLocalGetSubmission]);
    });

    test('should return Empty List when get local record', () async {
      // arrange
      when(controller.getLocalSubmission()).thenAnswer((_) async => []);

      // act
      final result = await controller.localRepository!.getLocalRecord();

      // expect failed to get local record
      expect(result, isEmpty);
    });
  });

  group('Test hide and show loading', () {

    test('should show loading', () {
      // arrange
      // act
      controller.showLoading();

      // assert
      expect(controller.isLoading.value, true);
    });

    test('should hide loading', () {
      // arrange
      // act
      controller.hiddenLoading();

      // assert
      expect(controller.isLoading.value, false);
    });
  });

  group('Test set source kmob submission', () {

    test('should set draft source', () {
      // arrange
      // act
      controller.setSource(AgentSubmission.DRAFT);

      // assert
      expect(controller.source.value, AgentSubmission.DRAFT);
    });
  });

  group('Test ktp validation', () {
    test('should return true when ktp is valid', () {
      // arrange
      // act
      final result = controller.ktpValidation('1234567890123456');

      // assert
      expect(result, null);
    });

    test('should return false when ktp is invalid', () {
      // arrange
      // act
      final result = controller.ktpValidation('123456789012345');

      // assert
      expect(result, ContentConstant.ktpMustBe16Digit);
    });

    test('should return false when ktp is invalid', () {
      // act
      final result = controller.ktpValidation('');

      // assert
      expect(result, ContentConstant.ktpCantBeNull);
    });
  });

  group('Test License Code', () {
    test('should return true when license code is valid', () {
      // arrange
      // act
      final result = controller.checkLicenseCode('ABC');

      // assert
      expect(result, null);
    });

    test('should return false when license code is invalid', () {
      // arrange
      // act
      final result = controller.checkLicenseCode('ABED');

      // assert
      expect(result, ContentConstant.licenseCodeMustBe3Digit);
    });

    test('should return false when license code is invalid', () {
      // act
      final result = controller.checkLicenseCode('');

      // assert
      expect(result, ContentConstant.licenseCodeCantBeNull);
    });
  });

  group('Test License Area', () {
    test('should return true when license area is valid', () {
      // arrange
      // act
      final result = controller.checkLicenseArea('AB');

      // assert
      expect(result, null);
    });

    test('should return false when license area is invalid', () {
      // arrange
      // act
      final result = controller.checkLicenseArea('ABC');

      // assert
      expect(result, ContentConstant.licenseAreaMustBe2Digit);
    });

    test('should return false when license area is invalid', () {
      // act
      final result = controller.checkLicenseArea('');

      // assert
      expect(result, ContentConstant.licenseAreaCantBeNull);
    });
  });

  group('Test License Number', () {
    test('should return true when license number is valid', () {
      // arrange
      // act
      final result = controller.checkLicenseNumber('ABCD');

      // assert
      expect(result, null);
    });

    test('should return false when license number is invalid', () {
      // act
      final result = controller.checkLicenseNumber('');

      // assert
      expect(result, ContentConstant.licenseNumberCantBeNull);
    });

    test('should return false when license number is invalid', () {
      // act
      final result = controller.checkLicenseNumber('12345');

      // assert
      expect(result, ContentConstant.licenseNumberMustBe4Digit);
    });
  });

  group('Test goToUploadDocumentSection' , () {

    test('index should be 2 when goToUploadDocumentSection is called', () {
      // arrange
      // act
      controller.goToUploadDocumentSection();

      // assert
      expect(controller.index.value, 2);
    });
  });

  group('Test updateProspectiD', () {

    test('should update prospect id', () {
      // arrange
      // act
      controller.updateProspectiD('123');

      // assert
      expect(controller.prospectId.value, '123');
    });
  });

  group('Test checkValueEmpty', () {

    test('should return null when value is not empty', () {

      // act
      final result = controller.checkValueEmpty('123', "value tidak boleh kosong");

      // assert
      expect(result, isNull);
    });

    test('should return messsage when value is empty', () {
      // arrange
      // act
      final result = controller.checkValueEmpty('', "value tidak boleh kosong");

      // assert
      expect(result, "value tidak boleh kosong");
    });
  });

  group('Test deleteLocalRecord', () {
    test('should return empty list when success localdatarecord list not empty', () async {
      // arrange
      when(controller.getLocalSubmission()).thenAnswer((_) async => [responseLocalGetSubmission]);
      var result = await (controller.localRepository!.getLocalRecord() as FutureOr<List<ResponseLocalGetKmobSubmission>>);

      // act
      if (result.length > 0) {
        await controller.deleteLocalRecord();
        when(controller.getLocalSubmission()).thenAnswer((_) async => []);
        result = await (controller.localRepository!.getLocalRecord() as FutureOr<List<ResponseLocalGetKmobSubmission>>);
      }

      // assert
      expect(result, []);
    });

    test('should return false when success localdatarecord list is empty', () async {
      // arrange
      when(controller.getLocalSubmission()).thenAnswer((_) async => []);

      // act
      bool result = await controller.getLocalSubmission().then((value) => value!.length > 0);

      // assert
      expect(result, false);
    });
  });

  group('Test save or update local record', () {
    test('should return same value when record is save or update', () async {
      // arrange
      when(controller.getLocalSubmission()).thenAnswer((_) async => [responseLocalGetSubmission]);

      // act
      controller.saveOrUpdateToLocal(responseLocalGetSubmission);
      final data = await controller.localRepository!.getLocalRecord().then((value) => value!.first);

      // assert
      expect(data, responseLocalGetSubmission);
    });
  });

  group('Test generate prospect id', () {
    test('should return same prospect id', () async {
      // arrange
      when(controller.generateProspectIdAgent("145", _mockBuildContext)).thenAnswer((_)
      => Future.value(responseGenerateProspectIdAgent));

      // act
      final result = await controller.kmobSubmissionRepository!.generateProspectIdAgent(_mockBuildContext,
          requestBody: requestGenerateProspectIdAgent.toJson());

      // assert
      expect(result.data!.prospectId, equals(responseGenerateProspectIdAgent.data!.prospectId));
    });
  });

  group('Test show Error', () {
    test('should return message when error is true', () async {
      // arrange
      // act
      controller.errorSnackBar("test error ...");

      // assert
      expect(controller.errorMessage.value, "test error ...");
    });
  });

}

void setAgentIdAndSupplierId() async {
  SharedPreferences.setMockInitialValues({});
  SharedPreferences pref = await SharedPreferences.getInstance();
  const String role = "agent";
  const String agentId = "123456";
  const String supplierId = "123456";

  pref.setString("role", DeasyEncryptorUtil.encryptString(role));
  pref.setString("agent_id", DeasyEncryptorUtil.encryptString(agentId));
  pref.setString("supplier_id", DeasyEncryptorUtil.encryptString(supplierId));
}
