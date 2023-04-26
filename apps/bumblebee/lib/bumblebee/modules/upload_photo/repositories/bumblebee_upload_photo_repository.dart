import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/all_upload_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/list_bast_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/list_imei_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/list_receipt_photo.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/upload_document_response.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';

class BumblebeeUploadPhotoRepository {
  DioClient _provider = DioClient();

  get responseString => null;

  Future<ListBastResponse> fetchListUpload(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "documents/list-upload-document", requestBody);
    return ListBastResponse.fromJson(response);
  }

  Future<ListImeiResponse> fetchListImei(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "documents/list-upload-document", requestBody,
        showSnackbar: true);
    return ListImeiResponse.fromJson(response);
  }

  Future<ListReceiptPhotoResponse> fetchListReceiptPhoto(BuildContext? context,
      Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "documents/list-upload-document", requestBody,
        showSnackbar: true);
    return ListReceiptPhotoResponse.fromJson(response);
  }

  Future<AllUploadResponse> fetchAllListUploadPhoto(
      BuildContext? context) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        "documents/list-upload-document", {"document_type": "All"});
    return AllUploadResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> uploadFileBast(
      BuildContext context,
      Map<String, dynamic> requestBody,
      PickedFile? file,
      String eventName) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.multipartPost(
        context, Scope.MERCHANT, "documents/upload-bast", requestBody,
        file: file, flag: "bast");
    return UploadDocumentResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> uploadFileImei(
    BuildContext context,
    Map<String, dynamic> requestBody,
    PickedFile? file,
    String eventName,
  ) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.multipartPost(
      context,
      Scope.MERCHANT,
      "documents/upload-imei",
      requestBody,
      file: file,
      flag: "imei",
    );
    return UploadDocumentResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> uploadFileReceiptPhoto(
      BuildContext context,
      Map<String, dynamic> requestBody,
      PickedFile? file,
      String eventName) async {
    DioClient _providerWithEvent =
        DioClient(eventName: eventName, params: requestBody);

    final response = await _providerWithEvent.multipartPost(
      context,
      Scope.MERCHANT,
      "documents/upload-customer-receipt-photo",
      requestBody,
      file: file,
      flag: "customer",
      getErrorMessage: true,
    );
    return UploadDocumentResponse.fromJson(response);
  }
}
