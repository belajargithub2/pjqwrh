import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';

class LocationRepositoryMock implements LocationRepository {
  @override
  Future<ResponseCity> getCity(BuildContext? context, {int? provinceCode}) {
    // TODO: implement getCity
    return Future.value(ResponseCity(data: [
      CityDatum(name: 'Depok', code: 1, provinceCode: 1),
      CityDatum(name: 'Banten', code: 2, provinceCode: 2),
    ], message: "OK"));
  }

  @override
  Future<ResponseDistrict> getDistrict(BuildContext? context,
      {int? cityCode}) {
    return Future.value(ResponseDistrict(data: [
      DistrictDatum(name: 'Cimanggis Depok', code: 1, cityCode: 1),
      DistrictDatum(name: 'Margonda', code: 2, cityCode: 2),
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
  Future<ResponseVillages> getVillages(BuildContext? context,
      {int? districtCode}) {
    // TODO: implement getVillages
    return Future.value(ResponseVillages(data: [
      VillageDatum(name: 'Harjamukti', code: 1, districtCode: 1),
      VillageDatum(name: 'Kelapa dua', code: 2, districtCode: 2),
    ], message: "OK"));
  }
}
