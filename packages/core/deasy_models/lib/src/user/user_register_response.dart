import 'dart:convert';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

ResponseRegister responseRegisterFromJson(String str) => ResponseRegister.fromJson(json.decode(str));

String responseRegisterToJson(ResponseRegister data) => json.encode(data.toJson());

class ResponseRegister {
  ResponseRegister({
    this.code,
    this.message,
    this.error,
    this.data,
  });

  int? code;
  String? message;
  String? error;
  RegisterData? data;

  factory ResponseRegister.fromJson(Map<String, dynamic> json) => ResponseRegister(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : json["error"],
    data: json["data"] == null ? null : RegisterData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "error": error == null ? null : error,
    "data": data == null ? null : data!.toJson(),
  };
}

class RegisterData {
  RegisterData({
    this.email,
    this.name,
    this.phoneNumber,
    this.supplierId,
  });

  String? email;
  String? name;
  String? phoneNumber;
  String? supplierId;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "supplier_id": supplierId == null ? null : supplierId,
  };
}
