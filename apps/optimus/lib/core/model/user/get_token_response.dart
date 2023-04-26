import 'dart:convert';

GetTokenResponse getTokenResponseFromJson(String str) => GetTokenResponse.fromJson(json.decode(str));

String getTokenResponseToJson(GetTokenResponse data) => json.encode(data.toJson());

class GetTokenResponse {
  GetTokenResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) => GetTokenResponse(
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
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
  };
}
