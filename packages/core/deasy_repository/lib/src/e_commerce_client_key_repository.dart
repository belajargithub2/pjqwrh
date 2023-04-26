import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class ECommerceClientKeyRepository {
  DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<ECommerceClientKeyBySupplierResponse> fetchApClientBySupplierKey(
      BuildContext? context,
      Map<String, dynamic>? requestBody,
      String supplierID) async {
    final response = await _provider.get(context, Scope.MERCHANT,
        "client-keys/ecommerce/get-by-supplierId/$supplierID", requestBody);
    return ECommerceClientKeyBySupplierResponse.fromJson(response);
  }

  Future<ECommerceClientKeyCreateResponse> postApiUpdateECommerceClientKey(
      BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(isActiveRefreshTokenInterceptor: true,
      eventName: eventName,
      params: requestBody
    );
    
    final response = await _providerWithEvent.put(
        context, Scope.MERCHANT, "client-keys/ecommerce/update", requestBody);
    return ECommerceClientKeyCreateResponse.fromJson(response);
  }
}
