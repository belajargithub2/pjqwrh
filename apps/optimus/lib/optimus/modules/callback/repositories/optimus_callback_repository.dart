import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/models/callback_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/models/callback_list_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';


class OptimusCallbackRepository {
  DioClient _provider = DioClient();

  Future<CallbackListResponse> getAllCallbacks(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "callbacks", requestBody);
    return CallbackListResponse.fromJson(response);
  }

  Future<bool> resendCallbacks(
    BuildContext? context,
    String? prospectId
  ) async {
    try {
      await _provider.get(context, Scope.MERCHANT, "callbacks/resend/$prospectId", null);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<CallbackDetailResponse> getDetailCallbacks(
    BuildContext? context,
    String prospectId
  ) async {
    final response = 
      await _provider.get(context, Scope.MERCHANT, "callbacks/detail/$prospectId", null);
    return CallbackDetailResponse.fromJson(response);
  }
}
