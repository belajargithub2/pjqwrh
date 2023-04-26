import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseVillages responseVillagesFromJson(String str) => ResponseVillages.fromJson(json.decode(str));

String responseVillagesToJson(ResponseVillages data) => json.encode(data.toJson());

class ResponseVillages {
  ResponseVillages({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<Datum>? data;
  PageInfo? pageInfo;

  factory ResponseVillages.fromJson(Map<String, dynamic> json) => ResponseVillages(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class Datum {
  Datum({
    this.code,
    this.districtCode,
    this.postCode,
    this.name,
    this.longitude,
    this.latitude,
  });

  int? code;
  int? districtCode;
  int? postCode;
  String? name;
  double? longitude;
  double? latitude;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"] == null ? null : json["code"],
    districtCode: json["district_code"] == null ? null : json["district_code"],
    postCode: json["post_code"] == null ? null : json["post_code"],
    name: json["name"] == null ? null : json["name"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "district_code": districtCode == null ? null : districtCode,
    "post_code": postCode == null ? null : postCode,
    "name": name == null ? null : name,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
  };
}

class PageInfo {
  PageInfo({
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

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
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
