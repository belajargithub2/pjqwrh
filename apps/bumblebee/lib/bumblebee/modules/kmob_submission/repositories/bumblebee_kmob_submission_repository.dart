import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_agent_order.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_generate_prospect_id_agent.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_bpkb_ownership_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_branch.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_list_license_area.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_marital_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_upload_image_kmob.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_validate_police_no.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class BumblebeeKMOBSubmissionRepository {
  DioClient _provider = DioClient();

  Future<ResponseGetAssetBrands> getBrand(
      {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, _EndPoint.GET_ASSET_BRANDS, requestBody);

    return ResponseGetAssetBrands.fromJson(response);
  }

  Future<ResponseGetBranch> getBranch(Map<String, dynamic>? requestBody) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, _EndPoint.GET_BRANCH, requestBody);

    return ResponseGetBranch.fromJson(response);
  }

  Future<ResponseGetAssetModel> getAssetModels(Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, _EndPoint.GET_ASSET_MODELS, requestBody);

    return ResponseGetAssetModel.fromJson(response);
  }

  Future<ResponseGetAssetTypes> getAssetTypes({Map<String, dynamic>? requestBody}) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, _EndPoint.GET_ASSET_TYPES, requestBody);

    return ResponseGetAssetTypes.fromJson(response);
  }

  Future<ResponseGetMaritalStatus> getMaritalStatus({Map<String, dynamic>? requestBody}) async {
    final response = await _provider.get(
        Get.context, Scope.MERCHANT, _EndPoint.GET_MARITAL_STATUS, requestBody);

    return ResponseGetMaritalStatus.fromJson(response);
  }

  Future<ResponseGetBpkbOwnerShipStatus> getBpkbOwnerShipStatus(
      {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.get(Get.context, Scope.MERCHANT,
        _EndPoint.GET_BPKB_OWNERSHIP_STATUS, requestBody);

    return ResponseGetBpkbOwnerShipStatus.fromJson(response);
  }

  Future<ResponseGenerateProspectIdAgent> generateProspectIdAgent(
      BuildContext? context,
      {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        _EndPoint.POST_GENERATE_PROSPECT_ID_AGENT, requestBody);

    return ResponseGenerateProspectIdAgent.fromJson(response);
  }

  Future<ResponseAgentOrder> agentOrder(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        _EndPoint.POST_AGENT_ORDER, requestBody, showSnackbar: true);

    return ResponseAgentOrder.fromJson(response);
  }

  Future<ResponseUploadImageKmob> uploadKk(
      BuildContext? context, String fileName, String filePath, Map<String, dynamic> requestBody) async {
    final response = await _provider.multipartPost(
        context, Scope.MERCHANT, _EndPoint.POST_UPLOAD_KK, requestBody,
        method: Method.MULTIPART,
        fileName: fileName,
        filePath: filePath,
        showSnackbar: true);

    return ResponseUploadImageKmob.fromJson(response);
  }

  Future<ResponseUploadImageKmob> uploadStnk(
      BuildContext? context, String fileName, String filePath, Map<String, dynamic> requestBody) async {
    final response = await _provider.multipartPost(
        context, Scope.MERCHANT, _EndPoint.POST_UPLOAD_STNK, requestBody,
        method: Method.MULTIPART,
        fileName: fileName,
        filePath: filePath,
        showSnackbar: true);

    return ResponseUploadImageKmob.fromJson(response);
  }

  Future<ResponseUploadImageKmob> uploadKtp(
      BuildContext? context, String fileName, String filePath, Map<String, dynamic> requestBody) async {
    final response = await _provider.multipartPost(
        context, Scope.MERCHANT, _EndPoint.POST_UPLOAD_KTP, requestBody,
        method: Method.MULTIPART,
        fileName: fileName,
        filePath: filePath,
        showSnackbar: true);

    return ResponseUploadImageKmob.fromJson(response);
  }

  Future<ResponseValidatePoliceNo> validatePoliceNo(
      BuildContext? context,
      {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        _EndPoint.POST_VALIDATE_POLICE_NO, requestBody, showSnackbar: true);

    return ResponseValidatePoliceNo.fromJson(response);
  }

  Future<ResponseGetListLicenseArea> getListLicenseArea(
      {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.get(Get.context, Scope.MERCHANT,
        _EndPoint.GET_LIST_LICENSE_AREA, requestBody);

    return ResponseGetListLicenseArea.fromJson(response);
  }

}

class _EndPoint {
  static const String GET_MARITAL_STATUS = "agents/orders/marital-status";
  static const String GET_BRANCH = "agents/orders/branches";
  static const String GET_BPKB_OWNERSHIP_STATUS = "agents/orders/bpkb-ownership-status";
  static const String GET_ASSET_BRANDS = "agents/assets/brands";
  static const String GET_ASSET_MODELS = "agents/assets/models";
  static const String GET_ASSET_TYPES = "agents/assets/types";
  static const String POST_UPLOAD_KK = "documents/upload-kk";
  static const String POST_UPLOAD_STNK = "documents/upload-stnk";
  static const String POST_UPLOAD_KTP = "documents/upload-ktp";
  static const String POST_GENERATE_PROSPECT_ID_AGENT = "agents/orders/prospect-id";
  static const String POST_AGENT_ORDER = "agents/orders/create";
  static const String POST_VALIDATE_POLICE_NO = "agents/assets/validate-police-no";
  static const String GET_LIST_LICENSE_AREA = "agents/assets/license-area";
}
