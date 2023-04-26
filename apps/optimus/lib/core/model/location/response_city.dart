import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseCity responseCityFromJson(String str) => ResponseCity.fromJson(json.decode(str));

String responseCityToJson(ResponseCity data) => json.encode(data.toJson());

class ResponseCity {
  ResponseCity({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<Datum>? data;
  PageInfo? pageInfo;

  factory ResponseCity.fromJson(Map<String, dynamic> json) => ResponseCity(
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
    this.provinceCode,
    this.name,
  });

  int? code;
  int? provinceCode;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"] == null ? null : json["code"],
    provinceCode: json["province_code"] == null ? null : json["province_code"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "province_code": provinceCode == null ? null : provinceCode,
    "name": name == null ? null : name,
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
