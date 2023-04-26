import 'package:meta/meta.dart';
import 'dart:convert';

SendEmailDeleteAccountResponse sendEmailDeleteAccountResponseFromJson(
        String str) =>
    SendEmailDeleteAccountResponse.fromJson(json.decode(str));

class SendEmailDeleteAccountResponse {
  SendEmailDeleteAccountResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory SendEmailDeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      SendEmailDeleteAccountResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.url,
    required this.expiredAt,
  });

  String? url;
  DateTime? expiredAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"] == null ? null : json["url"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
      );
}
