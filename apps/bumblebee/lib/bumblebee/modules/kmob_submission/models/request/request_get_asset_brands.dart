import 'dart:convert';

RequestGetAssetBrands requestGetBrandFromJson(String str) => RequestGetAssetBrands.fromJson(json.decode(str));

String requestGetBrandToJson(RequestGetAssetBrands data) => json.encode(data.toJson());

class RequestGetAssetBrands {
  RequestGetAssetBrands({
    this.page,
    this.limit,
    this.assetTypeId,
    this.brandName,
  });

  int? page;
  int? limit;
  int? assetTypeId;
  String? brandName;

  factory RequestGetAssetBrands.fromJson(Map<String, dynamic> json) => RequestGetAssetBrands(
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
    assetTypeId: json["asset_type_id"] == null ? null : json["asset_type_id"],
    brandName: json["brand_name"] == null ? null : json["brand_name"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
    "asset_type_id": assetTypeId == null ? null : assetTypeId,
    if(brandName!.isNotEmpty) "brand_name": brandName,
  };
}
