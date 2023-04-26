import 'dart:convert';

ResponseGetAssetModel requestGetAssetModelFromJson(String str) => ResponseGetAssetModel.fromJson(json.decode(str));

String requestGetAssetModelToJson(ResponseGetAssetModel data) => json.encode(data.toJson());

class ResponseGetAssetModel {
  ResponseGetAssetModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<DataAssetModel>? data;

  factory ResponseGetAssetModel.fromJson(Map<String, dynamic> json) => ResponseGetAssetModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataAssetModel>.from(json["data"].map((x) => DataAssetModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataAssetModel {
  DataAssetModel({
    this.modelName,
  });

  String? modelName;

  factory DataAssetModel.fromJson(Map<String, dynamic> json) => DataAssetModel(
    modelName: json["model_name"] == null ? null : json["model_name"],
  );

  Map<String, dynamic> toJson() => {
    "model_name": modelName == null ? null : modelName,
  };
}
