import 'dart:convert';

import 'merchant_list_response.dart';

MerchantDetailResponse lastSyncResponseFromJson(String str) => MerchantDetailResponse.fromJson(json.decode(str));

String lastSyncResponseToJson(MerchantDetailResponse data) => json.encode(data.toJson());

class MerchantDetailResponse {
  MerchantDetailResponse({
    this.message,
    this.data
  });

  String? message;
  MerchantData? data;

  factory MerchantDetailResponse.fromJson(Map<String, dynamic> json) => MerchantDetailResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : MerchantData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}
