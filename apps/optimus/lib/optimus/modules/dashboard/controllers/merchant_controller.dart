import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_ranking_list_response.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';

class MerchantController extends GetxController {
  MerchantRepository _repository;

  MerchantController({required MerchantRepository merchantRepository})
      : _repository = merchantRepository;

  @override
  void onInit() {
    _repository = MerchantRepository();
    super.onInit();
  }

  RxList<MerchantRankingData> listRankingMerchant =
      RxList<MerchantRankingData>();

  fetchMerchantRankingList() async {
    await getMerchantRankingList(
        context: Get.context,
        onSuccess: (MerchantRankingListResponse merchantRankingListResponse) {
          listRankingMerchant
              .addAll(merchantRankingListResponse.merchantRankingData!);
        },
        onError: (String message) {});
  }

  Future<MerchantListResponse?> fetchApiDashboardsMerchants(
      {BuildContext? context, int? limit, int? page}) async {
    var requestBody = <String, dynamic>{
      "limit": limit,
      "page": page,
      "order_by": "name"
    };
    try {
      MerchantListResponse response =
          await _repository.fetchApiDashboardMerchants(context, requestBody);
      return response;
    } catch (e) {}
  }

  getAllMerchant({BuildContext? context, int? limit, int? page}) async {
    var requestBody = <String, dynamic>{
      "limit": limit,
      "page": page,
      "order_by": "name"
    };
    try {
      MerchantListResponse response =
          await _repository.getAllMerchant(context, requestBody);
    } catch (e) {}
  }

  getMerchantByName(
      {BuildContext? context,
      int? limit,
      int? page,
      String? name,
      required Function onSuccess,
      Function? onError}) async {
    var requestBody = <String, dynamic>{
      "limit": limit,
      "page": page,
      "q": name
    };
    try {
      MerchantListResponse response =
          await _repository.getAllMerchant(context, requestBody);
      onSuccess(response);
    } catch (e) {
      print(e.toString());
      onError!(e.toString());
    }
  }

  Future<bool?> syncMerchant(
      {BuildContext? context, Function? onSuccess, Function? onError}) async {
    try {
      var response = await _repository.syncMerchant(context);
      return response;
    } catch (e) {
      return null;
    }
  }

  getMerchantById(
      {BuildContext? context,
      String? id,
      required Function onSuccess,
      Function? onError}) async {
    try {
      MerchantDetailResponse response =
          await _repository.getMerchantById(context, id);
      onSuccess(response);
    } catch (e) {
      onError!(e.toString());
    }
  }

  getMerchantRankingList(
      {BuildContext? context, required Function onSuccess, Function? onError}) async {
    try {
      MerchantRankingListResponse response =
          await _repository.getMerchantRankingList(Get.context);
      onSuccess(response);
    } catch (e) {
      onError!(e.toString());
    }
  }
}
