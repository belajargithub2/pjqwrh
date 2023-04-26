import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_subsidies_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_subsidies_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_summary_subsidi_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusSubsidiDealerRepository {
  DioClient _provider = DioClient();

  Future<OptimusSummarySubsidiResponse> fectSummarySubsidi(
    BuildContext? context,
    Map<String, dynamic> requestBody,
  ) async {
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "subsidies/summary",
      requestBody,
      showSnackbar: true,
    );
    return OptimusSummarySubsidiResponse.fromJson(response);
  }

  Future<OptimusSubsidiesResponse> fetchAllTransactionSubsidi(
    BuildContext? context,
    OptimusSubsidiesRequest requestBody,
  ) async {
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "subsidies",
      requestBody.toJson(),
      showSnackbar: true,
    );
    return OptimusSubsidiesResponse.fromJson(response);
  }

  Future<Uint8List?> downloadSubsidi(
    BuildContext? context,
    {required OptimusSubsidiesRequest requestBody}
  ) async {
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "subsidies/report",
      requestBody.toJson(),
      showSnackbar: true,
      isReturnJson: false,
    );
    return response;
  }
}
