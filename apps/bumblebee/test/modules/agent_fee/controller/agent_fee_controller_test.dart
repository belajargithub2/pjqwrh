import 'package:deasy_config/deasy_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/agent_fee_request.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:mockito/mockito.dart';

import '../dummy/agent_fee_dummy.dart';
import 'agent_fee_detail_controller_test.mocks.dart';

void main() {
  setFlavor(DevFlavorConfig());
  late AgentFeeController controller;
  final mockAgentFeeRepository = MockAgentFeeRepository();

  final binding = BindingsBuilder(() {
    Get.lazyPut<AgentFeeRepository>(() => mockAgentFeeRepository);

    Get.lazyPut<AgentFeeController>(() =>
        AgentFeeController(agentFeeRepository: Get.find<AgentFeeRepository>()));
  });

  setUp(() {
    binding.builder();
  });

  tearDown(() {
    Get.delete<AgentFeeController>();
  });

  group('Test - AgentFeeController', () {
    test('should return true when controller is initialized', () async {
      // arrange
      // act
      controller = Get.find<AgentFeeController>();

      // assert
      expect(controller.initialized, true);
    });

    test('should return String when startDate and endDate is empty', () async {
      // arrange
      // act
      controller.startDate.value = '';
      controller.endDate.value = '';

      // assert
      expect(
          controller.validationEndDate(
              controller.startDate.value, messageIfEmpty: "Start Date is required",
              messageEndDateBeforeStartDate: "Tanggal Akhir merupakan waktu sesudah Tanggal Awal",
          ), 'Start Date is required');
      expect(
          controller.validationEndDate(
            controller.endDate.value, messageIfEmpty: "End Date is required",
            messageEndDateBeforeStartDate: "Tanggal Akhir merupakan waktu sesudah Tanggal Awal",
          ),
          'End Date is required');
    });

    test('should return null when startDate and endDate is not empty',
        () async {
      // arrange
      // act
      controller.startDate.value = '2021-01-01';
      controller.endDate.value = '2021-01-02';

      // assert
      expect(
          controller.validationEndDate(
              controller.startDate.value, messageIfEmpty: "Start Date is required",
              messageEndDateBeforeStartDate: "Tanggal Akhir merupakan waktu sesudah Tanggal Awal"),
          null);
      expect(
          controller.validationEndDate(
              controller.endDate.value, messageIfEmpty: "Start Date is required",
              messageEndDateBeforeStartDate: "Tanggal Akhir merupakan waktu sesudah Tanggal Awal"),
          null);
    });

    test(
        'should return _InternalLinkedHashMap<String, String> when requestGetAgentFee is called',
        () async {
      // arrange
      controller.startDate.value = '2021-01-01';
      controller.endDate.value = '2021-01-02';

      // act
      final result = controller.agentFeeDataForDetailPage();

      // assert
      expect(
          result,
          RequestGetAgentFee(
            startDate: controller.startDate.value,
            endDate: controller.endDate.value,
          ).toJson());
    });

    test('should return list not empty when fetchDetailAgentFee is success',
        () async {
      // arrange
      when(mockAgentFeeRepository.postGetAgentFee(any, any))
          .thenAnswer((_) async => Future.value(responseGetAgentFee));

      // act
      await controller.fetchAgentFee();

      // assert
      // expect(controller.agentFeeState.value, AgentFeeState.SUCCESS);
      expect(controller.listAgentFee, isNotEmpty);
    });

    test('should return empty list when fetchDetailAgentFee is failed',
        () async {
      // arrange
      controller.listAgentFee.clear();
      when(mockAgentFeeRepository.postGetAgentFee(any, any))
          .thenAnswer((_) async => Future.error('error'));

      // act
      await controller.fetchAgentFee();

      // assert
      // expect(controller.agentFeeState.value, AgentFeeState.ERROR);
      expect(controller.listAgentFee, isEmpty);
    });
  });
}
