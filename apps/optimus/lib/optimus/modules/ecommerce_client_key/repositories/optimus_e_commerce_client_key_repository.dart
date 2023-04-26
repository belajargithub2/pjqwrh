import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_create_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_get_by_supplier.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_list_response.dart';
import 'package:kreditplus_deasy_website/core/model/empty_response.dart';

import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusECommerceClientKeyRepository {
  DioClient _provider = DioClient();

  Future<OptimusECommerceClientKeyListResponse> fetchApiAllClientKey(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "client-keys/ecommerce/get-all", requestBody);
    return OptimusECommerceClientKeyListResponse.fromJson(response);
  }

  Future<OptimusECommerceClientKeyBySupplierResponse> fetchApClientBySupplierKey(
      BuildContext? context,
      Map<String, dynamic>? requestBody,
      String supplierID) async {
    final response = await _provider.get(context, Scope.MERCHANT,
        "client-keys/ecommerce/get-by-supplierId/$supplierID", requestBody);
    return OptimusECommerceClientKeyBySupplierResponse.fromJson(response);
  }

  Future<OptimusECommerceClientKeyCreateResponse> postApiCreateECommerceClientKey(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "client-keys/ecommerce/create", requestBody);
    return OptimusECommerceClientKeyCreateResponse.fromJson(response);
  }

  Future<OptimusECommerceClientKeyCreateResponse> postApiUpdateECommerceClientKey(
      BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(
      eventName: eventName,
      params: requestBody
    );
    
    final response = await _providerWithEvent.put(
        context, Scope.MERCHANT, "client-keys/ecommerce/update", requestBody);
    return OptimusECommerceClientKeyCreateResponse.fromJson(response);
  }

  Future<EmptyResponse> deleteECommerceClientKey(
      BuildContext? context, String? id) async {
    final response = await _provider.delete(
        context, Scope.MERCHANT, "client-keys/ecommerce/delete/$id", null);
    return EmptyResponse.fromJson(response);
  }
}
