import 'dart:convert';

ResponseGetMaritalStatus responseGetMaritalStatusFromJson(String str) => ResponseGetMaritalStatus.fromJson(json.decode(str));

String responseGetMaritalStatusToJson(ResponseGetMaritalStatus data) => json.encode(data.toJson());

class ResponseGetMaritalStatus {
  ResponseGetMaritalStatus({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<MaritalStatusData>? data;

  factory ResponseGetMaritalStatus.fromJson(Map<String, dynamic> json) => ResponseGetMaritalStatus(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<MaritalStatusData>.from(json["data"].map((x) => MaritalStatusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MaritalStatusData {
  MaritalStatusData({
    this.id,
    this.text,
  });

  String? id;
  String? text;

  factory MaritalStatusData.fromJson(Map<String, dynamic> json) => MaritalStatusData(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
  };
}
