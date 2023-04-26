import 'dart:convert';

ResponseGetBpkbOwnerShipStatus responseGetBpkbOwnerShipStatusFromJson(String str) => ResponseGetBpkbOwnerShipStatus.fromJson(json.decode(str));

String responseGetBpkbOwnerShipStatusToJson(ResponseGetBpkbOwnerShipStatus data) => json.encode(data.toJson());

class ResponseGetBpkbOwnerShipStatus {
  ResponseGetBpkbOwnerShipStatus({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<DataBpkbOwnerShipStatus>? data;

  factory ResponseGetBpkbOwnerShipStatus.fromJson(Map<String, dynamic> json) => ResponseGetBpkbOwnerShipStatus(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataBpkbOwnerShipStatus>.from(json["data"].map((x) => DataBpkbOwnerShipStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataBpkbOwnerShipStatus {
  DataBpkbOwnerShipStatus({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory DataBpkbOwnerShipStatus.fromJson(Map<String, dynamic> json) => DataBpkbOwnerShipStatus(
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "name": name == null ? null : name,
  };
}
