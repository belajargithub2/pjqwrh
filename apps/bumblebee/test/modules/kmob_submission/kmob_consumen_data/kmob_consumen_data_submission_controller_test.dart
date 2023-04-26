import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/mapper/bumblebee_kmob_mapper.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
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
  late BumblebeeKMOBConsumerDataSubmissionController controller;
  KMOBSubmissionRepositoryMock _mockKmobSubmissionRepository = KMOBSubmissionRepositoryMock();
  KMOBSubmissionControllerMock _mockKmobSubmissionController = KMOBSubmissionControllerMock();

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeKMOBConsumerDataSubmissionController>(
      () => BumblebeeKMOBConsumerDataSubmissionController(
        kmobSubmissionRepository: _mockKmobSubmissionRepository,
        kmobSubmissionController: _mockKmobSubmissionController,
        draftRepository: DraftRepositoryMock(),
      ),
    );
  });

  setUp(() async {
    _mockBuildContext = MockBuildContext();

    when(_mockKmobSubmissionController.getLocalSubmission()).thenAnswer((_) async => Future.value([]));
    when(_mockKmobSubmissionController.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));
    when(_mockKmobSubmissionRepository.getBranch(null)).thenAnswer((_) async => responseGetBranch);
    when(_mockKmobSubmissionRepository.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);

    binding.builder();
    controller = Get.find<BumblebeeKMOBConsumerDataSubmissionController>();
  });

  group('Test KMOB Submission Consumer data Controller', () {
    test('should return true when controller is initialized', () async {
      expect(controller.initialized, true);
    });
  });

  group('Test fetchApiBranch', () {
    test('should return the same response when successfully call fetchApiBranch', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getBranch(null)).thenAnswer((_) async => responseGetBranch);

      // act
      final result = await controller.fetchApiBranch();

      // assert
      expect(result, responseGetBranch );
    });
  });

  group('Test fetchMaritalStatus', () {
    test('should return the same response when successfully call fetchMaritalStatus', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);

      // act
      final result = await controller.fetchMaritalStatus();

      // assert
      expect(result, responseGetMaritalStatus);
    });
  });

  group('Test filterListBranch', () {
    test('should return a list containing Kreditplus2', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getBranch(null)).thenAnswer((_) async => responseGetBranch);
      await controller.fetchApiBranch();

      // act
      final result = await controller.filterListBranch("Kreditplus2");

      // assert
      expect(result.length, 1);
    });
  });

  group('Test onChangeMaritalStatus', () {
    test('should return same id marital status', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final result = await controller.fetchMaritalStatus();

      // act
      controller.onChangeMaritalStatus(result.data!.first);

      // assert
      expect(controller.maritalStatusId.value, responseGetMaritalStatus.data!.first.id);
    });

    test('should return true when married is true', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final result = await controller.fetchMaritalStatus();

      // act
      controller.onChangeMaritalStatus(result.data!.last);

      // assert
      expect(controller.isMarried.value, true);
    });
  });

  group('Test clearPartnerData', () {
    test('should return empty when call clearPartnerData ', () {
      // arrange
      // act
      controller.clearPartnerData();

      // assert
      expect(controller.spouseNameController.text, isEmpty);
    });
  });

  group('Test onChangeGender', () {

    test('should return "L" when Consumen is true', () async {
      // arrange
      // act
      controller.onChangeGender("L", true);

      // assert
      expect(controller.genderController.text, "L");
    });

    test('should return "P" when Consumen is false', () async {
      // arrange
      // act
      controller.onChangeGender("P", false);

      // assert
      expect(controller.spouseGenderController.text, "P");
    });

  });

  group('Test checkLengthPhoneNumber', () {
    test('should return false when length phone number is 9', () async {
      // arrange
      // act
      final result = controller.checkLengthPhoneNumber(9);

      // assert
      expect(result, false);
    });

    test('should return true when length phone number is 2', () async {
      // arrange
      // act
      final result = controller.checkLengthPhoneNumber(2);

      // assert
      expect(result, true);
    });
  });

  group('Test phoneNumberValidation', () {
    test('should return message when phone number is empty', () async {
      // arrange
      // act
      final result = controller.phoneNumberValidation("");

      // assert
      expect(result, ContentConstant.phoneNumberCantBeNull);
    });

    test('should return message when phone number is invalid', () async {
      // arrange
      // act
      final result = controller.phoneNumberValidation("123123");

      // assert
      expect(result, ContentConstant.phoneNumberNotValid);
    });

    test('should return null when phone number is valid', () async {
      // arrange
      // act
      final result = controller.phoneNumberValidation("08123456789");

      // assert
      expect(result, isNull);
    });
  });

  group('Test onChangeBranch', () {
    test('should return same moName when call onChangeBranch', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getBranch(null)).thenAnswer((_) async => responseGetBranch);
      final result = await controller.fetchApiBranch();

      // act
      controller.onChangeBranch(result.data!.first);

      // assert
      expect(controller.moName.value, result.data!.first.moName);
    });
  });

  group('Test getBranchByIdBranch', () {
    test('should return branchId by Id when call getBranchByIdBranch', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getBranch(null)).thenAnswer((_) async => responseGetBranch);
      final result = await controller.fetchApiBranch();

      // act
      controller.getBranchByIdBranch("145");

      // assert
      expect(controller.branchId.value, result.data!.first.branchId);
    });
  });

  group('Test getDateFromString', () {
    test('should return same date when call getDateFromString', () async {
      // arrange
      // act
      final result = await controller.getDateFromString(date: "2021/01/01");

      // assert
      expect(result, "2021/01/01");
    });

    test('should return same date when call getDateFromString and length of date is greater than 10', () async {
      // arrange
      // act
      final result = await controller.getDateFromString(date: "2020-01-02T07:12:50+07:00");

      // assert
      expect(result, "02/01/2020");
    });
  });

  group('Test getMaritalStatusById', () {
    test('should return same marital status when call getMaritalStatusById', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final result = await controller.fetchMaritalStatus();

      // act
      controller.getMaritalStatusById("S");

      // assert
      expect(controller.maritalStatusId.value, result.data!.first.id);
    });

    test('should return same marital status when call getMaritalStatusById and status is married', () async {
      // arrange
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final result = await controller.fetchMaritalStatus();

      // act
      controller.getMaritalStatusById(result.data!.last.id);

      // assert
      expect(controller.isMarried.value, true);
    });
  });

  group('Test getDetailDraft', () {
    test('should return same data when call getDetailDraft', () async {
      // arrange
      final prospectId = "123";
      when(controller.draftRepository!.getDetailDraft(_mockBuildContext,
          prospectId: prospectId)).thenAnswer((_) async => kmobSubmissionModelDummy);

      // act
      final result = await controller.getDetailDraft(_mockBuildContext, prospectId);

      // assert
      expect(result, kmobSubmissionModelDummy);
    });
  });

  group('Test setDataFromDraftOrLocal', () {
    test('should return same branchId when call setDataFromDraftOrLocal', () async {
      // arrange
      final prospectId = "123";
      when(controller.kmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
      when(controller.draftRepository!.getDetailDraft(_mockBuildContext,
          prospectId: prospectId)).thenAnswer((_) async => kmobSubmissionModelDummy);

      /// set marital status
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final result = await controller.fetchMaritalStatus();
      controller.listMaritalStatus.value = result.data!;

      // act
      controller.getMaritalStatusById("S");
      await controller.setDataFromDraftOrLocal();

      // assert
      expect(controller.branchId.value, kmobSubmissionModelDummy.branchId);
    });
  });

  group('Test checkWhetherDataFromLocal', () {

    test('should return empty when local data is empty', () async {

      // arrange
      when(controller.kmobSubmissionController!.getLocalSubmission()).thenAnswer((_) async => Future.value([]));

      // act
      controller.checkWhetherDataFromLocal();
      final list = await controller.kmobSubmissionController!.getLocalSubmission();

      // assert
      expect(list, []);
    });

    test('should return same data when local data is not empty', () async {

      // arrange
      when(controller.kmobSubmissionController!.getLocalSubmission()).thenAnswer((_) async => Future.value([responseLocalGetSubmission]));

      // act
      controller.checkWhetherDataFromLocal();

      /// set marital status and save to local
      when(controller.kmobSubmissionRepository!.getMaritalStatus()).thenAnswer((_) async => responseGetMaritalStatus);
      final list = await (controller.kmobSubmissionController!.getLocalSubmission() as FutureOr<List<ResponseLocalGetKmobSubmission>>);
      controller.kmobSubmissionController!.kmobSubmissionModel.value = list.first.toModel();

      // assert
      expect(list, [responseLocalGetSubmission]);
    });
  });

  group('Test goToStepTwo', () {
    test('should return goToAssetSection data when source from draft', () async {
      // arrange
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.DRAFT));

      // act
      controller.goToStepTwo();

      // assert
      verify(controller.kmobSubmissionController!.goToAssetSection()).called(1);
    });

    test('should return list more greater 1 &&  call goToStepTwo', () async {
      // arrange
      when(controller.kmobSubmissionController!.source).thenReturn(Rx<AgentSubmission>(AgentSubmission.NEW));
      when(controller.kmobSubmissionController!.getLocalSubmission()).thenAnswer((_) async => Future.value([responseLocalGetSubmission]));
      when(controller.kmobSubmissionController!.kmobSubmissionModel).thenReturn(Rx<KmobSubmissionModel>(kmobSubmissionModelDummy));
      when(controller.kmobSubmissionController!.agentId).thenReturn(RxString("324783294789237"));
      when(controller.kmobSubmissionController!.prospectId).thenReturn(RxString("00000000000000000000000000000000"));
      when(controller.kmobSubmissionController!.typeOfLob).thenReturn(RxString("KMOB"));

      final list = await (controller.kmobSubmissionController!.getLocalSubmission() as FutureOr<List<ResponseLocalGetKmobSubmission>>);

      // act
      controller.goToStepTwo();

      // assert
      when(controller.kmobSubmissionController!.goToAssetSection()).thenAnswer((_) async => list);
      expect(list.length, greaterThan(0));
    });
  });

  group('Test onReady', () {
    test('should hidden loading when onready is complete', () async {
      // arrange
      when(controller.kmobSubmissionController!.isLoading).thenReturn(RxBool(false));

      // act
      controller.onReady();

      // assert
      expect(controller.kmobSubmissionController!.isLoading.value, false);
    });
  });

}
