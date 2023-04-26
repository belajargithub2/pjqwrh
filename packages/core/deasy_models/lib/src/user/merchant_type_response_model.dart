
import 'package:meta/meta.dart';
import 'dart:convert';

MerchantTypeResponseModel merchantTypeResponseModelFromJson(String str) => MerchantTypeResponseModel.fromJson(json.decode(str));


class MerchantTypeResponseModel {
  MerchantTypeResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  List<MerchantTypeData>? data;

  factory MerchantTypeResponseModel.fromJson(Map<String, dynamic> json) => MerchantTypeResponseModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<MerchantTypeData>.from(json["data"].map((x) => MerchantTypeData.fromJson(x))),
  );


}

class MerchantTypeData {
  MerchantTypeData({
    required this.id,
    required this.text,
  });

  String? id;
  String? text;

  factory MerchantTypeData.fromJson(Map<String, dynamic> json) => MerchantTypeData(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
  );


}
