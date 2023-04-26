import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/models/optimus_register_merchant_exist_response.dart';

class OptimusRegisterRepository {
  DioClient _provider = DioClient();

  Future<OptimusRegisterMerchantExistResponse> isMerchantExistById(
      BuildContext? context, String? deviceId) async {
    var requestBody = <String, dynamic>{"supplier_id": deviceId};
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "merchants/check",
      requestBody,
      showSnackbar: true,
    );
    return OptimusRegisterMerchantExistResponse.fromJson(response);
  }
}