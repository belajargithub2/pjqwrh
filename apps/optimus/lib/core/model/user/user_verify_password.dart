import 'dart:convert';

VerifyPasswordResponse verifyPasswordResponseFromJson(String str) => VerifyPasswordResponse.fromJson(json.decode(str));

class VerifyPasswordResponse {
  VerifyPasswordResponse({
    this.code,
    this.message,
    this.error,
  });

  int? code;
  String? message;
  Error? error;

  factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) => VerifyPasswordResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );
}

class Error {
  Error({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );
}
