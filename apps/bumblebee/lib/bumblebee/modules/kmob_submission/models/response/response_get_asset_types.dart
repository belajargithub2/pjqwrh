import 'dart:convert';

ResponseGetAssetTypes requestGetAssetTypesFromJson(String str) => ResponseGetAssetTypes.fromJson(json.decode(str));

String requestGetAssetTypesToJson(ResponseGetAssetTypes data) => json.encode(data.toJson());

class ResponseGetAssetTypes {
  ResponseGetAssetTypes({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<DataAssetType>? data;

  factory ResponseGetAssetTypes.fromJson(Map<String, dynamic> json) => ResponseGetAssetTypes(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataAssetType>.from(json["data"].map((x) => DataAssetType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataAssetType {
  DataAssetType({
    this.typeName,
  });

  String? typeName;

  factory DataAssetType.fromJson(Map<String, dynamic> json) => DataAssetType(
    typeName: json["type_name"] == null ? null : json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "type_name": typeName == null ? null : typeName,
  };
}
