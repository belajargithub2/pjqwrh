
import 'dart:convert';

PasswordMailResponse passwordMailResponseFromJson(String str) => PasswordMailResponse.fromJson(json.decode(str));

String passwordMailResponseToJson(PasswordMailResponse data) => json.encode(data.toJson());

class PasswordMailResponse {
  PasswordMailResponse({
    this.message,
    this.data,
  });

  String? message;
  PasswordMailData? data;

  factory PasswordMailResponse.fromJson(Map<String, dynamic> json) => PasswordMailResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : PasswordMailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class PasswordMailData {
  PasswordMailData({
    this.email,
    this.token,
  });

  String? email;
  String? token;

  factory PasswordMailData.fromJson(Map<String, dynamic> json) => PasswordMailData(
    email: json["email"] == null ? null : json["email"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "token": token == null ? null : token,
  };
}
