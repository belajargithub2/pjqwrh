import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_ranking_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/branch_employee_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/branch_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/channel_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/confirmation_method_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/dealer_group_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/last_sync_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/update_dealer_response.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';


class MerchantRepository {
  DioClient _provider = DioClient();

  Future<MerchantListResponse> getAllMerchant(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.post(context, Scope.MERCHANT, "merchants", requestBody);
    return MerchantListResponse.fromJson(response);
  }

  Future<MerchantDetailResponse> getMerchantById(
      BuildContext? context, String? id) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/$id", null);
    return MerchantDetailResponse.fromJson(response);
  }

  Future<MerchantListResponse> fetchApiDashboardMerchants(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants", requestBody);
    return MerchantListResponse.fromJson(response);
  }

  Future<UpdateDealerResponse> updateFeatureMerchants(
      BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "merchants/settings", requestBody, showSnackbar: true,);
    return UpdateDealerResponse.fromJson(response);
  }

  Future<bool> syncMerchant(BuildContext? context) async {
    await _provider.get(context, Scope.MERCHANT, "merchants/sync", null, showSnackbar: true);
    return true;
  }

  Future<MerchantRankingListResponse> getMerchantRankingList(
      BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/ranking", null);
    return MerchantRankingListResponse.fromJson(response);
  }

  Future<ChannelListResponse> getChannels(
      BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/list-channel", null);
    return ChannelListResponse.fromJson(response);
  }

  Future<ConfirmationMethodListResponse> getConfirmationMethods(
      BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/confirmation-methods", null);
    return ConfirmationMethodListResponse.fromJson(response);
  }

  Future<LastSyncResponse> getLastSync(
      BuildContext? context) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/last-sync-date", null);
    return LastSyncResponse.fromJson(response);
  }
  
  Future<DealerGroupListResponse> getGroupName(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "merchants/group-name", requestBody);
    return DealerGroupListResponse.fromJson(response);
  }

  Future<BranchListResponse> getBranches(
      BuildContext? context, Map<String, dynamic>? requestBody) async {
    final response =
        await _provider.get(context, Scope.MERCHANT, "branches", null);
    return BranchListResponse.fromJson(response);
  }

  Future<BranchEmployeeListResponse> getBranchEmployees(
      BuildContext? context, String? branchId) async {
    var requestBody = {"branch_id": branchId, "is_active": true};
    final response =
        await _provider.post(context, Scope.MERCHANT, "branch/employees", requestBody);
    return BranchEmployeeListResponse.fromJson(response);
  }
}
