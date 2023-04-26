import 'dart:convert';

ResponseCheckEmail responseCheckEmailFromJson(String str) => ResponseCheckEmail.fromJson(json.decode(str));

String responseCheckEmailToJson(ResponseCheckEmail data) => json.encode(data.toJson());

class ResponseCheckEmail {
  ResponseCheckEmail({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ResponseCheckEmail.fromJson(Map<String, dynamic> json) => ResponseCheckEmail(
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
    this.email,
    this.status,
    this.message,
  });

  String? email;
  String? status;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"] == null ? null : json["email"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
