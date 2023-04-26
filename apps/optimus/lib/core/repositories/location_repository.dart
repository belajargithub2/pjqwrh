import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_city.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_district.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_province.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_villages.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';

class LocationRepository {
  DioClient _provider = DioClient();

  Future<ResponseProvince> getProvince(BuildContext? context) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "locations/provinces", null,
        isRegister: true);
    return ResponseProvince.fromJson(response);
  }

  Future<ResponseCity> getCity(BuildContext? context, {int? provinceCode}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        "locations/cities", {"province_code": provinceCode},
        isRegister: true);
    return ResponseCity.fromJson(response);
  }

  Future<ResponseDistrict> getDistrict(BuildContext? context,
      {int? cityCode}) async {
    final response = await _provider.post(
        context, Scope.MERCHANT, "locations/districts", {"city_code": cityCode},
        isRegister: true);
    return ResponseDistrict.fromJson(response);
  }

  Future<ResponseVillages> getVillages(BuildContext? context,
      {int? districtCode}) async {
    final response = await _provider.post(context, Scope.MERCHANT,
        "locations/villages", {"district_code": districtCode},
        isRegister: true);
    return ResponseVillages.fromJson(response);
  }
}
