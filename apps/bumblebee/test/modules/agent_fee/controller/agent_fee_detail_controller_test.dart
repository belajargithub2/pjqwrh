import 'dart:typed_data';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_detail_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/date_constant.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

import '../dummy/agent_fee_dummy.dart';
import '../dummy/agent_fee_mock_file.dart';
import '../dummy/agent_feemock_permission.dart';
import 'agent_fee_detail_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AgentFeeRepository>()])
void main() {
  setFlavor(DevFlavorConfig());
  late MockFile file;
  late AgentFeeDetailController controller;
  final mockAgentFeeRepository = MockAgentFeeRepository();

  final binding = BindingsBuilder(() {
    Get.lazyPut<AgentFeeRepository>(() => mockAgentFeeRepository);

    Get.lazyPut<AgentFeeDetailController>(
      () => AgentFeeDetailController(
        agentFeeRepository: Get.find<AgentFeeRepository>(),
      ),
    );
  });

  setUp(() async {
    initializeDateFormatting('id');
    PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();
    file = MockFile();
    binding.builder();
    controller = Get.find<AgentFeeDetailController>();
    controller.startDate.value = "2012-02-27 13:27:00";
    controller.endDate.value = "2012-02-28 13:27:00";
    when(mockAgentFeeRepository.postGetAgentFee(any, any))
        .thenAnswer((_) async => Future.value(responseGetAgentFee));
  });

  tearDown(() {
    Get.delete<AgentFeeDetailController>();
  });

  group('Test - AgentFeeDetailController', () {
    test('should return true when controller is initialized', () async {
      expect(controller.initialized, true);
    });

    test("Should return correct object when requestGetAgentFee is called", () {
      //arrange
      final startDateMatcher = controller.startDate.value
          .toFormattedDate(format: DateConstant.dateFormatRFC3339);
      final endDateMatcher = controller.endDate.value
          .toFormattedDate(format: DateConstant.dateFormatRFC3339);

      //act
      final result = controller.requestGetAgentFee();

      //assert
      expect(result.startDate, startDateMatcher);
      expect(result.endDate, endDateMatcher);
    });

    test('should return Android download path when getDownloadPath is called',
        () async {
      // arrange

      // act
      final result = await controller.getDownloadPath();

      // assert
      expect(result, '/storage/emulated/0/Download');
    });

    test(
        'should return correct period datetime when getPeriodDatetime is called',
        () async {
      // arrange
      final start = '2012-02-27 13:27:00';
      final end = '2012-02-28 13:27:00';

      // act
      final result = controller.getPeriodDatetime(start: start, end: end);

      // assert
      expect(result, '27 Februari 2012 - 28 Februari 2012');
    });

    test('PermissionActions on Permission: request()', () async {
      final permissionRequest = Permission.storage.request();

      expect(permissionRequest, isA<Future<PermissionStatus>>());
    });

    test(
        'PermissionActions on Permission: get shouldShowRequestRationale should return true',
        () async {
      final mockPermissionHandlerPlatform = PermissionHandlerPlatform.instance;

      when(mockPermissionHandlerPlatform
              .shouldShowRequestPermissionRationale(Permission.storage))
          .thenAnswer((_) => Future.value(true));

      await Permission.storage.shouldShowRequestRationale;

      verify(mockPermissionHandlerPlatform
              .shouldShowRequestPermissionRationale(Permission.storage))
          .called(1);
    });

    test('should return false when downloadAgentFee is called', () async {
      // arrange
      // act
      final result = await controller.downloadAgentFee();

      // assert
      expect(result, false);
    });

    test("Should return success state when hiddenLoading is called", () {
      //arrange
      //act
      controller.hiddenLoading();

      //assert
      expect(controller.agentFeeState.value, AgentFeeState.SUCCESS);
    });

    test('should return true when postDownloadAgentFee is success', () async {
      // arrange
      when(file.writeAsBytes(Uint8List(0))).thenAnswer((_) {
        return Future.value(file);
      });

      when(mockAgentFeeRepository.postDownloadAgentFee(any))
          .thenAnswer((_) async => Future.value(Uint8List(0)));

      // act
      final result = await controller.postDownloadAgentFee();

      // assert
      expect(controller.agentFeeState.value, AgentFeeState.SUCCESS);
      expect(result, true);
    });

    test('should return false when postDownloadAgentFee is failed', () async {
      // arrange
      when(mockAgentFeeRepository.postDownloadAgentFee(any,
              requestBody: anyNamed("requestBody")))
          .thenAnswer((_) async => throw Exception("error"));

      // act
      final result = await controller.postDownloadAgentFee();

      // assert
      expect(controller.agentFeeState.value, AgentFeeState.ERROR);
      expect(result, false);
    });
  });
}