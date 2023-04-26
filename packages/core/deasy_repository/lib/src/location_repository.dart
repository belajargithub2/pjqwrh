import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/deasy_network.dart';
import 'package:flutter/material.dart';

class LocationRepository {
  final DioClient _provider = DioClient(isActiveRefreshTokenInterceptor: true);

  Future<ResponseProvince> getProvince(BuildContext? context) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "master-data/provinces", null,
        isRegister: true);
    return ResponseProvince.fromJson(response);
  }

  Future<ResponseCity> getCity(BuildContext? context,
      {int? provinceCode}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        "master-data/cities", {"province_code": provinceCode},
        isRegister: true);
    return ResponseCity.fromJson(response);
  }

  Future<ResponseDistrict> getDistrict(BuildContext? context,
      {int? cityCode}) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "master-data/districts", {"city_code": cityCode},
        isRegister: true);
    return ResponseDistrict.fromJson(response);
  }

  Future<ResponseVillages> getVillages(BuildContext? context,
      {int? districtCode}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        "master-data/villages", {"district_code": districtCode},
        isRegister: true);
    return ResponseVillages.fromJson(response);
  }
}
