import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class MerchantRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<MerchantDetailResponse> getMerchantById(
      BuildContext? context, String? id) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/$id", null);
    return MerchantDetailResponse.fromJson(response);
  }

  Future<RegisterMerchantExistResponse> isMerchantExistById(
      BuildContext? context, String? deviceId) async {
    var requestBody = <String, dynamic>{"supplier_id": deviceId};
    final response = await _provider.post(
      context,
      Scope.MERCHANT,
      "merchants/check",
      requestBody,
      showSnackbar: true,
    );
    return RegisterMerchantExistResponse.fromJson(response);
  }

  Future<MerchantListResponse> getAllMerchant(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "merchants", requestBody);
    return MerchantListResponse.fromJson(response);
  }
}
