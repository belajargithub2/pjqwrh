import 'dart:convert';

ResponseValidatePoliceNo responseValidatePoliceNoFromJson(String str) => ResponseValidatePoliceNo.fromJson(json.decode(str));

String responseValidatePoliceNoToJson(ResponseValidatePoliceNo data) => json.encode(data.toJson());

class ResponseValidatePoliceNo {
  ResponseValidatePoliceNo({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory ResponseValidatePoliceNo.fromJson(Map<String, dynamic> json) => ResponseValidatePoliceNo(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
