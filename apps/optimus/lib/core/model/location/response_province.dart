import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseProvince responseProvinceFromJson(String str) => ResponseProvince.fromJson(json.decode(str));

String responseProvinceToJson(ResponseProvince data) => json.encode(data.toJson());

class ResponseProvince {
  ResponseProvince({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<Datum>? data;
  PageInfo? pageInfo;

  factory ResponseProvince.fromJson(Map<String, dynamic> json) => ResponseProvince(
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
    this.name,
  });

  int? code;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
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
  int? prevPage;
  int? nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"] == null ? null : json["prev_page"],
    nextPage: json["next_page"] == null ? null : json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
    "prev_page": prevPage == null ? null : prevPage,
    "next_page": nextPage == null ? null : nextPage,
  };
}
