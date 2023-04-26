import 'dart:convert';

GetTokenResponse getTokenResponseFromJson(String str) => GetTokenResponse.fromJson(json.decode(str));

String getTokenResponseToJson(GetTokenResponse data) => json.encode(data.toJson());

class GetTokenResponse {
  GetTokenResponse({
    this.message,
    this.data,
  });

  String? message;
  GetTokenData? data;

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) => GetTokenResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : GetTokenData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class GetTokenData {
  GetTokenData({
    this.token,
  });

  String? token;

  factory GetTokenData.fromJson(Map<String, dynamic> json) => GetTokenData(
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
  };
}
