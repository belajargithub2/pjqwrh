import 'dart:convert';

GetWhiteGoodsResponse getWhiteGoodsResponseFromJson(String str) => GetWhiteGoodsResponse.fromJson(json.decode(str));

String getWhiteGoodsResponseToJson(GetWhiteGoodsResponse data) => json.encode(data.toJson());

class GetWhiteGoodsResponse {
  GetWhiteGoodsResponse({
    this.messages,
    this.data,
    this.errors,
    this.pageInfo,
    this.code,
  });

  String? messages;
  List<WhiteGoods>? data;
  dynamic errors;
  PageInfo? pageInfo;
  int? code;

  factory GetWhiteGoodsResponse.fromJson(Map<String, dynamic> json) => GetWhiteGoodsResponse(
    messages: json["messages"],
    data: json["data"] == null ? [] : List<WhiteGoods>.from(json["data"]!.map((x) => WhiteGoods.fromJson(x))),
    errors: json["errors"],
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "errors": errors,
    "page_info": pageInfo?.toJson(),
    "code": code,
  };
}

class WhiteGoods {
  WhiteGoods({
    this.assetCode,
    this.description,
    this.categoryId,
    this.categoryName,
  });

  String? assetCode;
  String? description;
  String? categoryId;
  String? categoryName;

  factory WhiteGoods.fromJson(Map<String, dynamic> json) => WhiteGoods(
    assetCode: json["asset_code"],
    description: json["description"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "asset_code": assetCode,
    "description": description,
    "category_id": categoryId,
    "category_name": categoryName,
  };
}

class PageInfo {
  PageInfo({
    this.limit,
    this.nextPage,
    this.offset,
    this.page,
    this.prevPage,
    this.totalPage,
    this.totalRecord,
  });

  int? limit;
  int? nextPage;
  int? offset;
  int? page;
  int? prevPage;
  int? totalPage;
  int? totalRecord;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    limit: json["limit"],
    nextPage: json["next_page"],
    offset: json["offset"],
    page: json["page"],
    prevPage: json["prev_page"],
    totalPage: json["total_page"],
    totalRecord: json["total_record"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "next_page": nextPage,
    "offset": offset,
    "page": page,
    "prev_page": prevPage,
    "total_page": totalPage,
    "total_record": totalRecord,
  };
}
