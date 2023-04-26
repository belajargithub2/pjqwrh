
import 'dart:convert';

PasswordMailResponse passwordMailResponseFromJson(String str) => PasswordMailResponse.fromJson(json.decode(str));

String passwordMailResponseToJson(PasswordMailResponse data) => json.encode(data.toJson());

class PasswordMailResponse {
  PasswordMailResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory PasswordMailResponse.fromJson(Map<String, dynamic> json) => PasswordMailResponse(
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
    this.token,
  });

  String? email;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"] == null ? null : json["email"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "token": token == null ? null : token,
  };
}
