import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';
import 'package:mockito/mockito.dart';

class MerchantRepositoryMock with Mock implements MerchantRepository {

  @override
  Future<MerchantDetailResponse> getMerchantById(
      BuildContext? context, String? id) {
    return Future.value(MerchantDetailResponse(
        message: "OK", data: MerchantData(address: "jl alternatif cibubur")));
  }
}
