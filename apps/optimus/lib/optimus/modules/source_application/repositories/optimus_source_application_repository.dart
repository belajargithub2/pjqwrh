import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/empty_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_create_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class OptimusSourceApplicationRepository {
  DioClient _provider = DioClient();


  Future<OptimusSourceAppResponse> fetchApiAllSource(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
    await _provider.post(context, Scope.MERCHANT, "source-application/get-all", requestBody);
    return OptimusSourceAppResponse.fromJson(response);
  }

  Future<OptimusSourceAppCreateResponse> fetchApiCreateSourceApp(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
    await _provider.post(context, Scope.MERCHANT, "source-application/create", requestBody, showSnackbar: true,);
    return OptimusSourceAppCreateResponse.fromJson(response);
  }

  Future<OptimusSourceAppCreateResponse> fetchApiEditSourceApp(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
    await _provider.put(context, Scope.MERCHANT, "source-application/update", requestBody, showSnackbar: true);
    return OptimusSourceAppCreateResponse.fromJson(response);
  }

  Future<EmptyResponse> deleteSource(
      BuildContext? context, String? id) async {
    final response =
    await _provider.delete(context, Scope.MERCHANT, "source-application/delete/$id", null);
    return EmptyResponse.fromJson(response);
  }

  Future<OptimusSourceAppResponse> getSourceApplicationList(
      BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "source-application/list", null);
    return OptimusSourceAppResponse.fromJson(response);
  }

  Future<OptimusSourceAppCreateResponse> getSourceApplicationById(
      BuildContext? context, String id) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "source-application/get-by-id/$id", null);
    return OptimusSourceAppCreateResponse.fromJson(response);
  }
}