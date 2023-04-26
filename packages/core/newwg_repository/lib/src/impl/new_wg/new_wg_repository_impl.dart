import 'dart:typed_data';

import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';
import 'package:newwg_repository/src/new_wg_repository.dart';
import 'package:newwg_repository/src/response/new_wg/customer_check_limit_type_response.dart';
import 'package:newwg_repository/src/response/new_wg/generate_prospect_id_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_group_categories_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_order_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_white_goods_response.dart';
import 'package:newwg_repository/src/response/new_wg/human_verification_response.dart';
import 'package:newwg_repository/src/request/new_wg/additional_document_submit_request.dart';
import 'package:newwg_repository/src/response/new_wg/additional_documents_submit_response.dart';
import 'package:newwg_repository/src/response/new_wg/additional_documents_upload_response.dart';
import 'package:newwg_repository/src/response/new_wg/submit_order_response.dart';
import 'package:newwg_repository/src/response/new_wg/verification_code_validate_response.dart';

class NewWgRepositoryImpl implements NewWgRepository {
  final DioClient _provider = DioClient(
    isActiveRequestsInspectorInterceptor: true,
    isActiveLoggingInterceptor: true,
  );

  final aesEncryptor = AesHelper(key: KeyConstant.platformKey);

  @override
  Future<VerificationCodeValidateResponse> verificationCodeValidate(
      BuildContext context, String verificationCode, String phoneNumber) async {
    final requestBody = {
      "mobile_phone": phoneNumber,
      "code": aesEncryptor.encrypt(verificationCode),
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "customers/verification-validate",
      requestBody,
      showSnackbar: true,
    );

    return VerificationCodeValidateResponse.fromJson(response);
  }

  @override
  Future<HumanVerificationResponse> submitHumanVerification(
      BuildContext context,
      int customerId,
      bool dataValid,
      bool selfieValid,
      bool recommendation,
      bool confirmCheck) async {
    final requestBody = {
      "customer_id": customerId,
      "data_valid": dataValid,
      "selfie_valid": selfieValid,
      "recomendation": recommendation,
      "confirm_check": confirmCheck,
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "verification/human",
      requestBody,
      showSnackbar: false,
    );

    return HumanVerificationResponse.fromJson(response);
  }

  @override
  Future<CutomerCheckLimitTypeResponse> checkCustomerLimitType(
      BuildContext context, String phoneNumber) async {

    final requestBody = {
      "mobile_phone": aesEncryptor.encrypt(phoneNumber),
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "customers/status",
      requestBody,
      showSnackbar: true,
    );

    return CutomerCheckLimitTypeResponse.fromJson(response);
  }

  @override
  Future<Uint8List?> getImageCustomer(
    BuildContext context,
    String url,
    bool isWatermark,
  ) async {
    final response = await _provider.getImage(
      context,
      Scope.PLATFORM,
      url = isWatermark ? "$url?watermark=true" : url,
      isFullUrl: true,
    );

    return response;
  }

  Future<AdditionalDocumentsUploadResponse> uploadAdditionalDocuments(
      BuildContext context,
      String phoneNumber,
      String type,
      String filePath) async {
    final requestBody = {
      "mobile_phone": aesEncryptor.encrypt(phoneNumber),
      "type": type,
    };
    final response = await _provider.multipartPost(
      context,
      Scope.NEW_WG,
      "verification/additional-document/upload",
      requestBody,
      fileName: "image",
      method: Method.MULTIPART,
      filePath: filePath,
    );
    return AdditionalDocumentsUploadResponse.fromJson(response);
  }

  Future<AdditionalDocumentsUploadResponse> uploadAddDocs(BuildContext context,
      String phoneNumber, String type, List<int>? fileBytes) async {
    final requestBody = {
      "mobile_phone": aesEncryptor.encrypt(phoneNumber),
      "type": type,
    };
    final response = await _provider.multipartPost(
      context,
      Scope.NEW_WG,
      "verification/additional-document/upload",
      requestBody,
      flag: "newwg",
      fileName: "image",
      fileBytes: fileBytes,
      getErrorMessage: true,
    );
    return AdditionalDocumentsUploadResponse.fromJson(response);
  }

  Future<AdditionalDocumentsSubmitResponse> submitAdditionalDocuments(
      BuildContext context, AdditionalDocumentsSubmitRequest data) async {
    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "verification/additional-document/submit",
      data.toJson(),
      showSnackbar: true,
    );
    return AdditionalDocumentsSubmitResponse.fromJson(response);
  }

  @override
  Future<GetGroupCategoryResponse> getAssetGroupCategories(
      BuildContext context) async {
    final response = await _provider.get(
      context,
      Scope.NEW_WG,
      "assets/group-categories",
      null,
      showSnackbar: true,
    );

    return GetGroupCategoryResponse.fromJson(response);
  }

  @override
  Future<GetWhiteGoodsResponse> getWhiteGoods(BuildContext context,
      int groupCategoryId, String? search, int? page, int? limit) async {
    final requestBody = {
      "group_category_id": groupCategoryId,
      "search": search,
      "page": page,
      "limit": limit,
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "assets/white-goods",
      requestBody,
    );

    return GetWhiteGoodsResponse.fromJson(response);
  }

  @override
  Future<SubmitOrderResponse> submitOrder(BuildContext context,
      Map<String, dynamic> requestBody, String xSourceToken) async {
    final additionalHeaders = {
      "X-Source-Token": xSourceToken,
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "assets/submit-draft-order",
      requestBody,
      showSnackbar: true,
      additionalHeaders: additionalHeaders,
    );

    return SubmitOrderResponse.fromJson(response);
  }

  @override
  Future<GenerateProspectIdResponse> generateProspectId(
    BuildContext context,
    String prefix,
    int unique,
  ) async {
    final response = await _provider.get(
      context,
      Scope.ASIA_SOUTHEAST2,
      "lib-generator/generate?handling=orderid&prefix=$prefix&unique=$unique",
      null,
    );

    return GenerateProspectIdResponse.fromJson(response);
  }

  @override
  Future<GetOrderResponse> getOrder(BuildContext context,
      Map<String, dynamic> requestBody, xSourceToken) async {
    final additionalHeaders = {
      "X-Source-Token": xSourceToken,
    };

    final response = await _provider.post(
      context,
      Scope.NEW_WG,
      "assets/draft-order",
      requestBody,
      showSnackbar: true,
      additionalHeaders: additionalHeaders,
    );

    return GetOrderResponse.fromJson(response);
  }

  @override
  Future<SubmitOrderResponse> editOrder(BuildContext context,
      Map<String, dynamic> requestBody, String xSourceToken) async {
    final additionalHeaders = {
      "X-Source-Token": xSourceToken,
    };

    final response = await _provider.put(
      context,
      Scope.NEW_WG,
      "assets/update-draft-order",
      requestBody,
      showSnackbar: true,
      additionalHeaders: additionalHeaders,
    );

    return SubmitOrderResponse.fromJson(response);
  }
}
