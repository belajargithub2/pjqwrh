import 'dart:convert';

RequestGetAssetModels requestGetAssetModelFromJson(String str) => RequestGetAssetModels.fromJson(json.decode(str));

String requestGetAssetModelToJson(RequestGetAssetModels data) => json.encode(data.toJson());

class RequestGetAssetModels {
  RequestGetAssetModels({
    this.assetTypeId,
    this.brandName,
    this.limit,
    this.modelName,
    this.page,
  });

  int? assetTypeId;
  String? brandName;
  int? limit;
  String? modelName;
  int? page;

  factory RequestGetAssetModels.fromJson(Map<String, dynamic> json) => RequestGetAssetModels(
    assetTypeId: json["asset_type_id"] == null ? null : json["asset_type_id"],
    brandName: json["brand_name"] == null ? null : json["brand_name"],
    limit: json["limit"] == null ? null : json["limit"],
    modelName: json["model_name"] == null ? null : json["model_name"],
    page: json["page"] == null ? null : json["page"],
  );

  Map<String, dynamic> toJson() => {
    "asset_type_id": assetTypeId == null ? null : assetTypeId,
    "brand_name": brandName!.isEmpty ? "" : brandName,
    "limit": limit == null ? null : limit,
    "model_name": modelName == null ? null : modelName,
    "page": page == null ? null : page,
  };
}
