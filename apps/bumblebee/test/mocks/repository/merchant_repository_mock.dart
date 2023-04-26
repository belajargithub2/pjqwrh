import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MerchantRepositoryMock with Mock implements MerchantRepository {

  @override
  Future<MerchantDetailResponse> getMerchantById(
      BuildContext? context, String? id) {
    return Future.value(MerchantDetailResponse(
        message: "OK", data: MerchantData(address: "jl alternatif cibubur")));
  }
}
