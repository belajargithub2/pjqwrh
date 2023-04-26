// To parse this JSON data, do
//
//     final responseRequestOtp = responseRequestOtpFromJson(jsonString);

import 'dart:convert';

ResponseRequestOtp responseRequestOtpFromJson(String str) => ResponseRequestOtp.fromJson(json.decode(str));

String responseRequestOtpToJson(ResponseRequestOtp data) => json.encode(data.toJson());

class ResponseRequestOtp {
  ResponseRequestOtp({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ResponseRequestOtp.fromJson(Map<String, dynamic> json) => ResponseRequestOtp(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.phoneNumber,
    this.retryAt,
  });

  String? phoneNumber;
  int? retryAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    retryAt: json["retry_at"] == null ? null : json["retry_at"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "retry_at": retryAt == null ? null : retryAt,
  };
}
