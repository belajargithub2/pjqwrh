import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

class ErrorResponse {
  ErrorResponse({
    this.code,
    this.message,
    this.errors,
  });

  int? code;
  String? message;
  dynamic errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        errors: json["errors"] != null || json["error"] != null
            ? json["errors"] is List
                ? (json["errors"] as List)
                    .map((x) => x == null ? null : Error.fromJson(x))
                    .toList()
                : json["errors"] is String 
                    ? json["errors"]
                    : Error.fromJson(json["errors"] ?? json["error"])
            : json["message"],
      );
}

class Error {
  Error({
    this.field,
    this.code,
    this.message,
  });

  String? field;
  String? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        field: json["field"] == null ? null : json["field"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "field": field == null ? null : field,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
