import 'dart:convert';

HumanVerificationResponse humanVerificationResponseFromJson(String str) => HumanVerificationResponse.fromJson(json.decode(str));

String humanVerificationResponseToJson(HumanVerificationResponse data) => json.encode(data.toJson());

class HumanVerificationResponse {
  HumanVerificationResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory HumanVerificationResponse.fromJson(Map<String, dynamic> json) => HumanVerificationResponse(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
