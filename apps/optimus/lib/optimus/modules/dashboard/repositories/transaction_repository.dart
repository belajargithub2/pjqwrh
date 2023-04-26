import 'dart:typed_data';

import 'package:deasy_config/deasy_config.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/agent_orders_response.dart';
import 'package:kreditplus_deasy_website/core/model/cancel_order_response.dart';
import 'package:kreditplus_deasy_website/core/model/cancel_reason_response.dart';
import 'package:kreditplus_deasy_website/core/model/detail_agent_order_response.dart';
import 'package:kreditplus_deasy_website/core/model/document_response.dart';
import 'package:kreditplus_deasy_website/core/model/orders/payment_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/tracking_response.dart';
import 'package:kreditplus_deasy_website/core/model/transaction_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/upload_document_response.dart';



class TransactionRepository {
  DioClient _provider = DioClient();

  Future<TransactionResponse> fetchApiAllOrders(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "orders", requestBody);
    return TransactionResponse.fromJson(response);
  }

  Future<AgentOrdersResponse> fetchApiAllAgentOrders(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "agents/orders", requestBody);
    return AgentOrdersResponse.fromJson(response);
  }

  Future<DetailAgentOrderResponse> fetchApiDetailAgentOrders(
      BuildContext? context, String? prospectId) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "agents/orders/$prospectId", null);
    return DetailAgentOrderResponse.fromJson(response);
  }

  Future<CancelOrderResponse> putApiCancelOrder(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.put(context, Scope.MERCHANT, "orders/cancel", requestBody);
    return CancelOrderResponse.fromJson(response);
  }

  Future<CancelOrderResponse> putApiAgentCancelOrder(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.put(context, Scope.MERCHANT, "agents/orders/cancel", requestBody);
    return CancelOrderResponse.fromJson(response);
  }

  Future<CancelReasonResponse> fetchApiCancelReasonList(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "orders/cancel/reasons", requestBody);
    return CancelReasonResponse.fromJson(response);
  }

  Future<CancelReasonResponse> fetchApiAgentCancelReasonList(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "agents/orders/cancel-reasons", requestBody);
    return CancelReasonResponse.fromJson(response);
  }

  Future<DocumentResponse> fetchApiDocumentById(
      BuildContext? context, Map<String, dynamic>? requestBody, String? prospectId) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "documents/prospect-id/$prospectId", requestBody);
    return DocumentResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> postApiUploadBAST(
      BuildContext? context, Map<String, dynamic> requestBody, List<int> file) async {
    final response =
    await _provider.multipartPost(
      context,
      Scope.MERCHANT,
      "documents/upload-bast",
      requestBody,
      flag: "bast",
      fileBytes: file,
      getErrorMessage: true,
    );
    return UploadDocumentResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> postApiUploadCustReceipt(
      BuildContext? context, Map<String, dynamic> requestBody, List<int> file) async {
    final response =
      await _provider.multipartPost(
        context,
        Scope.MERCHANT,
        "documents/upload-customer-receipt-photo",
        requestBody,
        flag: "customer",
        fileBytes: file,
        getErrorMessage: true,
      );
    return UploadDocumentResponse.fromJson(response);
  }

  Future<UploadDocumentResponse> postApiUploadImei(
      BuildContext? context, Map<String, dynamic> requestBody, List<int> file) async {
    final response =
      await _provider.multipartPost(
        context,
        Scope.MERCHANT,
        "documents/upload-imei",
        requestBody,
        flag: "imei",
        fileBytes: file,
        getErrorMessage: true,
      );
    return UploadDocumentResponse.fromJson(response);
  }

  Future<TrackingResponse> fetchApiTracking(
      BuildContext? context, Map<String, dynamic>? requestBody, String? prospectId) async {
    final response =
    await _provider.get(context, Scope.MERCHANT, "orders/tracking/$prospectId", requestBody, showSnackbar: true);
    return TrackingResponse.fromJson(response);
  }

  Future<PaymentDetailResponse> fetchApiPaymentDetail(
      BuildContext? context, String? prospectID) async {
    final response =
    await _provider.get(context, Scope.MERCHANT, "agreements/$prospectID", null);
    return PaymentDetailResponse.fromJson(response);
  }

  Future<Uint8List?> fetchDocument(
      BuildContext? context, Map<String, dynamic>? requestBody, String? prospectId,String? type) async {
    final response =
    await _provider.getWithoutJsonResponse(context, Scope.MERCHANT, "reports/$type/$prospectId/view", requestBody);
    return response;
  }

  Future<String> fetchPdfUrl({String? type,String? prospectId}) async {
    final url = "${flavorConfiguration!.appMerchantBaseUrlWithoutVersion}reports/$type/$prospectId/view" ;
    return url;
  }
}
