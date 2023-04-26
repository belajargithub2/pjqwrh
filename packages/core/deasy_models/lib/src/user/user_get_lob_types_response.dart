import 'dart:convert';

UserGetLobTypesResponse userGetLobTypesResponseFromJson(String str) => UserGetLobTypesResponse.fromJson(json.decode(str));

String userGetLobTypesResponseToJson(UserGetLobTypesResponse data) => json.encode(data.toJson());

class UserGetLobTypesResponse {
  UserGetLobTypesResponse({
    this.code,
    this.message,
    this.lobTypes,
  });

  int? code;
  String? message;
  List<LobType>? lobTypes;

  factory UserGetLobTypesResponse.fromJson(Map<String, dynamic> json) => UserGetLobTypesResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    lobTypes: json["data"] == null ? null : List<LobType>.from(json["data"].map((x) => LobType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": lobTypes == null ? null : List<dynamic>.from(lobTypes!.map((x) => x.toJson())),
  };
}

class LobType {
  LobType({
    this.lobType,
    this.lobTypeName,
  });

  String? lobType;
  String? lobTypeName;

  factory LobType.fromJson(Map<String, dynamic> json) => LobType(
    lobType: json["lob_type"] == null ? null : json["lob_type"],
    lobTypeName: json["lob_type_name"] == null ? null : json["lob_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "lob_type": lobType == null ? null : lobType,
    "lob_type_name": lobTypeName == null ? null : lobTypeName,
  };
}
