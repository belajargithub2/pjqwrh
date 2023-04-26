import 'package:deasy_helper/deasy_helper.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/agent_fee_request.dart';
import 'package:kreditplus_deasy_mobile/core/constant/date_constant.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';

enum AgentFeeState { DEFAULT, LOADING, SUCCESS, ERROR }

class AgentFeeController extends GetxController {
  AgentFeeController({this.agentFeeRepository});

  final startDate = ''.obs;
  final endDate = ''.obs;
  final agentFeeState = AgentFeeState.DEFAULT.obs;
  final AgentFeeRepository? agentFeeRepository;
  final listAgentFee = <Incentive>[].obs;

  Map<String, dynamic> agentFeeDataForDetailPage() {
    return RequestGetAgentFee(
      startDate: startDate.value,
      endDate: endDate.value,
      incentives: listAgentFee,
    ).toJson();
  }

  String? validationStartDate(String value, String message) {
    if (value.isEmpty) {
      return message;
    }

    return null;
  }

  String? validationEndDate(
    String value, {
    required String messageIfEmpty,
    required String messageEndDateBeforeStartDate,
  }) {
    if (value.isEmpty) {
      return messageIfEmpty;
    } else if (startDate.value.isNotEmpty) {
      final start = startDate.value
          .toFormattedDate(format: DateConstant.dateFormat6)
          .toDate;
      final end = endDate.value
          .toFormattedDate(format: DateConstant.dateFormat6)
          .toDate;
      if (start.isAfter(end)) {
        return messageEndDateBeforeStartDate;
      }
    }

    return null;
  }

  RequestGetAgentFee requestGetAgentFee() {
    String start = startDate.value.toFormattedDate(format: DateConstant.dateFormatRFC3339);
    String end = endDate.value.toFormattedDate(format: DateConstant.dateFormatRFC3339);

    return RequestGetAgentFee(
      startDate: start,
      endDate: end,
    );
  }

  Future<void> fetchAgentFee() async {
    agentFeeState(AgentFeeState.LOADING);
    listAgentFee.clear();
    await agentFeeRepository!.postGetAgentFee(requestGetAgentFee().toJson(), "get_agent_fee")
      .then((value) {
        agentFeeState(AgentFeeState.SUCCESS);
        listAgentFee.value = value.data!.data!.incentives ?? [];
      }).catchError((error) {
        agentFeeState(AgentFeeState.ERROR);
      });
  }
}
