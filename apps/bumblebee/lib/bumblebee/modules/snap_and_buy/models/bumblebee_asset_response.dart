import 'dart:convert';

AssetResponse assetResponseFromJson(String str) => AssetResponse.fromJson(json.decode(str));


class AssetResponse {
  AssetResponse({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<AssetData>? data;
  PageInfo? pageInfo;

  factory AssetResponse.fromJson(Map<String, dynamic> json) => AssetResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AssetData>.from(json["data"].map((x) => AssetData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

}

class AssetData {
  AssetData({
    this.assetCode,
    this.assetName,
    this.assetType,
    this.categoryCode,
    this.categoryName,
  });

  String? assetCode;
  String? assetName;
  String? assetType;
  String? categoryCode;
  String? categoryName;

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
    assetCode: json["asset_code"] == null ? null : json["asset_code"],
    assetName: json["asset_name"] == null ? null : json["asset_name"],
    assetType: json["asset_type"] == null ? null : json["asset_type"],
    categoryCode: json["category_code"] == null ? null : json["category_code"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
  );

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

}
