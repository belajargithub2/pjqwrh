import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseDistrict responseDistrictFromJson(String str) => ResponseDistrict.fromJson(json.decode(str));

String responseDistrictToJson(ResponseDistrict data) => json.encode(data.toJson());

class ResponseDistrict {
  ResponseDistrict({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<DistrictDatum>? data;
  DistricPageInfo? pageInfo;

  factory ResponseDistrict.fromJson(Map<String, dynamic> json) => ResponseDistrict(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DistrictDatum>.from(json["data"].map((x) => DistrictDatum.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : DistricPageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class DistrictDatum {
  DistrictDatum({
    this.code,
    this.cityCode,
    this.name,
  });

  int? code;
  int? cityCode;
  String? name;

  factory DistrictDatum.fromJson(Map<String, dynamic> json) => DistrictDatum(
    code: json["code"] == null ? null : json["code"],
    cityCode: json["city_code"] == null ? null : json["city_code"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "city_code": cityCode == null ? null : cityCode,
    "name": name == null ? null : name,
  };
}

class DistricPageInfo {
  DistricPageInfo({
    this.totalRecord,
    this.totalPage,
    this.offset,
    this.limit,
    this.page,
    this.prevPage,
    this.nextPage,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  dynamic prevPage;
  dynamic nextPage;

  factory DistricPageInfo.fromJson(Map<String, dynamic> json) => DistricPageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"],
    nextPage: json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
    "prev_page": prevPage,
    "next_page": nextPage,
  };
}
