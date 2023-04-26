import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseLogout responseLogoutFromJson(String str) => ResponseLogout.fromJson(json.decode(str));

String responseLogoutToJson(ResponseLogout data) => json.encode(data.toJson());

class ResponseLogout {
  ResponseLogout({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory ResponseLogout.fromJson(Map<String, dynamic> json) => ResponseLogout(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
