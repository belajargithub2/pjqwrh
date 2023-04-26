import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class AgentFeeRepository {
  final DioClient _provider;

  AgentFeeRepository({DioClient? provider})
      : _provider = provider ?? DioClient();

  Future<ResponseGetAgentFee> postGetAgentFee(
      Map<String, dynamic> requestBody, String eventName) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, "agents/reports/fees", requestBody,
        showSnackbar: true);
    return ResponseGetAgentFee.fromJson(response);
  }

  Future<Uint8List> postDownloadAgentFee(
      String eventName,
      {Map<String, dynamic>? requestBody, BuildContext? context}) async {
    final response = await _provider.post(
      context ?? Get.context,
      Scope.MERCHANT,
      "agents/reports/fees/view",
      requestBody,
      isReturnJson: false,
    );
    return response;
  }
}
