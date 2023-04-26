import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_calculate_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_create_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_order_snap_n_buy_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_prospect_id_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_snap_n_buy_settings_response.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeSnapNBuyRepository {
  DioClient _provider = DioClient();

  Future<CalculateResponse> postApiCalculateInstallment(
    BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(
      eventName: eventName,
      params: requestBody
    );

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "orders/snap-n-buy/calculate-installment", requestBody,
        versionApi: VersionApi.V2, showSnackbar: true);
    return CalculateResponse.fromJson(response);
  }

  Future<ProspectIdResponse> generateProspectId(BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "orders/snap-n-buy/generate-prospect-id", requestBody);
    return ProspectIdResponse.fromJson(response);
  }

  Future<ListPromoMarketingResponse> getListPromoMarketing(BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "orders/snap-n-buy/programs", requestBody,
        versionApi: VersionApi.V2, showSnackbar: true);
    return ListPromoMarketingResponse.fromJson(response);
  }

  Future<CreateSnapNBuyResponse> postApiCreateOrderSnapNBuy(
    BuildContext? context, Map<String, dynamic> requestBody, String eventName) async {
    DioClient _providerWithEvent = DioClient(
      eventName: eventName,
      params: requestBody
    );

    final response = await _providerWithEvent.post(
        context, Scope.MERCHANT, "orders/snap-n-buy/create", requestBody, versionApi: VersionApi.V2, showSnackbar: true);
    return CreateSnapNBuyResponse.fromJson(response);
  }

  Future<OrderSnapNBuyResponse> getOrderSnapNBuyById(BuildContext context, String prospectId) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, "orders/snap-n-buy/$prospectId", null);
    return OrderSnapNBuyResponse.fromJson(response);
  }

  Future<SnapNBuySettingsResponse> fetchApiSnapNBuySettings(
      BuildContext? context, String? supplierId, String? branchId) async {
    var requestBody = <String, dynamic>{
      "supplier_id": supplierId,
      "branch_id": branchId
    };

    final response = await _provider.get(
        context, Scope.MERCHANT, "settings/snap-and-buy", requestBody);
    return SnapNBuySettingsResponse.fromJson(response);
  }

}