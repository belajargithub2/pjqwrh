import 'dart:convert';

ListPromoMarketingRequest listPromoMarketingRequestFromJson(String str) => ListPromoMarketingRequest.fromJson(json.decode(str));

String listPromoMarketingRequestToJson(ListPromoMarketingRequest data) => json.encode(data.toJson());

class ListPromoMarketingRequest {
  ListPromoMarketingRequest({
    this.assets,
    this.mobilePhone,
  });

  List<Asset>? assets;
  String? mobilePhone;

  factory ListPromoMarketingRequest.fromJson(Map<String, dynamic> json) => ListPromoMarketingRequest(
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
  );

  Map<String, dynamic> toJson() => {
    if (assets != null) "assets":  List<dynamic>.from(assets!.map((x) => x.toJson())),
    if (mobilePhone != null) "mobile_phone": mobilePhone,
  };
}

class Asset {
  Asset({
    this.assetNumber,
    this.assetCode,
    this.categoryCode,
    this.categoryName,
    this.otr,
  });

  int? assetNumber;
  String? assetCode;
  String? categoryCode;
  String? categoryName;
  int? otr;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetNumber: json["asset_number"] == null ? null : json["asset_number"],
    assetCode: json["asset_code"] == null ? null : json["asset_code"],
    categoryCode: json["category_code"] == null ? null : json["category_code"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    otr: json["otr"] == null ? null : json["otr"],
  );

  Map<String, dynamic> toJson() => {
    "asset_number": assetNumber == null ? null : assetNumber,
    "asset_code": assetCode == null ? null : assetCode,
    "category_code": categoryCode == null ? null : categoryCode,
    "category_name": categoryName == null ? null : categoryName,
    "otr": otr == null ? null : otr,
  };
}
