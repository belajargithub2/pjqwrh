import 'dart:convert';

ResponseGetAssetBrands responseGetBrandFromJson(String str) => ResponseGetAssetBrands.fromJson(json.decode(str));

String responseGetBrandToJson(ResponseGetAssetBrands data) => json.encode(data.toJson());

class ResponseGetAssetBrands {
  ResponseGetAssetBrands({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<DataAssetBrand>? data;

  factory ResponseGetAssetBrands.fromJson(Map<String, dynamic> json) => ResponseGetAssetBrands(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataAssetBrand>.from(json["data"].map((x) => DataAssetBrand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataAssetBrand {
  DataAssetBrand({
    this.brandName,
  });

  String? brandName;

  factory DataAssetBrand.fromJson(Map<String, dynamic> json) => DataAssetBrand(
    brandName: json["brand_name"] == null ? null : json["brand_name"],
  );

  Map<String, dynamic> toJson() => {
    "brand_name": brandName == null ? null : brandName,
  };
}
