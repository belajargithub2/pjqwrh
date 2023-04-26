import 'dart:convert';

import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';


UpdateDealerResponse updateDealerResponseFromJson(String str) => UpdateDealerResponse.fromJson(json.decode(str));

String updateDealerResponseToJson(UpdateDealerResponse data) => json.encode(data.toJson());

class UpdateDealerResponse {
  UpdateDealerResponse({
    this.message,
    this.errorData,
    this.data,
  });

  String? message;
  ErrorData? errorData;
  MerchantData? data;

  factory UpdateDealerResponse.fromJson(Map<String, dynamic> json) => UpdateDealerResponse(
    message: json["message"] == null ? null : json["message"],
    errorData: json["errors"] == null ? null : ErrorData.fromJson(json["errors"]),
    data: json["data"] == null ? null : MerchantData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "errors": errorData == null ? null : errorData!.toJson(),
    "data": data == null ? null : data!.toJson(),
  };
}

class ErrorData {
  ErrorData({
    this.field,
    this.message,
  });

  String? field;
  String? message;

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
    field: json["field"] == null ? null : json["field"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "field": field == null ? null : field,
    "message": message == null ? null : field,
  };
}