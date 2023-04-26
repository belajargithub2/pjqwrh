import 'dart:convert';

RequestGetAssetTypes requestGetAssetTypesFromJson(String str) => RequestGetAssetTypes.fromJson(json.decode(str));

String requestGetAssetTypesToJson(RequestGetAssetTypes data) => json.encode(data.toJson());

class RequestGetAssetTypes {
  RequestGetAssetTypes({
    this.assetTypeId,
    this.brandName,
    this.limit,
    this.modelName,
    this.page,
    this.typeName,
  });

  int? assetTypeId;
  String? brandName;
  int? limit;
  String? modelName;
  int? page;
  String? typeName;

  factory RequestGetAssetTypes.fromJson(Map<String, dynamic> json) => RequestGetAssetTypes(
    assetTypeId: json["asset_type_id"] == null ? null : json["asset_type_id"],
    brandName: json["brand_name"] == null ? null : json["brand_name"],
    limit: json["limit"] == null ? null : json["limit"],
    modelName: json["model_name"] == null ? null : json["model_name"],
    page: json["page"] == null ? null : json["page"],
    typeName: json["type_name"] == null ? null : json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "asset_type_id": assetTypeId == null ? null : assetTypeId,
    "brand_name": brandName == null ? null : brandName,
    "limit": limit == null ? null : limit,
    "model_name": modelName == null ? null : modelName,
    "page": page == null ? null : page,
    "type_name": typeName == null ? null : typeName,
  };
}
