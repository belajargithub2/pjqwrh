import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_city.dart'
    as city;
import 'package:kreditplus_deasy_website/core/model/location/response_district.dart'
    as district;
import 'package:kreditplus_deasy_website/core/model/location/response_province.dart';
import 'package:kreditplus_deasy_website/core/model/location/response_villages.dart'
    as village;
import 'package:kreditplus_deasy_website/core/repositories/location_repository.dart';

class LocationRepositoryMock implements LocationRepository {
  @override
  Future<city.ResponseCity> getCity(BuildContext? context, {int? provinceCode}) {
    // TODO: implement getCity
    return Future.value(city.ResponseCity(data: [
      city.Datum(name: 'Depok', code: 1, provinceCode: 1),
      city.Datum(name: 'Banten', code: 2, provinceCode: 2),
    ], message: "OK"));
  }

  @override
  Future<district.ResponseDistrict> getDistrict(BuildContext? context,
      {int? cityCode}) {
    return Future.value(district.ResponseDistrict(data: [
      district.Datum(name: 'Cimanggis Depok', code: 1, cityCode: 1),
      district.Datum(name: 'Margonda', code: 2, cityCode: 2),
    ], message: "you rock!"));
  }

  @override
  Future<ResponseProvince> getProvince(BuildContext? context) {
    // TODO: implement getProvince
    return Future.value(ResponseProvince(
      message: "you rock!",
    ));
  }

  @override
  Future<village.ResponseVillages> getVillages(BuildContext? context,
      {int? districtCode}) {
    // TODO: implement getVillages
    return Future.value(village.ResponseVillages(data: [
      village.Datum(name: 'Harjamukti', code: 1, districtCode: 1),
      village.Datum(name: 'Kelapa dua', code: 2, districtCode: 2),
    ], message: "OK"));
  }
}
