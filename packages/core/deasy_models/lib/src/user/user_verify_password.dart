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
  VerifyPasswordError? error;

  factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) => VerifyPasswordResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : VerifyPasswordError.fromJson(json["error"]),
  );
}

class VerifyPasswordError {
  VerifyPasswordError({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory VerifyPasswordError.fromJson(Map<String, dynamic> json) => VerifyPasswordError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );
}
