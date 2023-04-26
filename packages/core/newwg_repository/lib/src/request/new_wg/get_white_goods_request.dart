import 'dart:convert';

GetWhiteGoodsRequest getWhiteGoodsRequestFromJson(String str) => GetWhiteGoodsRequest.fromJson(json.decode(str));

String getWhiteGoodsRequestToJson(GetWhiteGoodsRequest data) => json.encode(data.toJson());

class GetWhiteGoodsRequest {
  GetWhiteGoodsRequest({
    this.groupCategoryId,
    this.search,
    this.page,
    this.limit,
  });

  int? groupCategoryId;
  String? search;
  int? page;
  int? limit;

  factory GetWhiteGoodsRequest.fromJson(Map<String, dynamic> json) => GetWhiteGoodsRequest(
    groupCategoryId: json["group_category_id"],
    search: json["search"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "group_category_id": groupCategoryId,
    "search": search,
    "page": page,
    "limit": limit,
  };
}
