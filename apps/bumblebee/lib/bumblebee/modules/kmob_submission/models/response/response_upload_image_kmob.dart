import 'dart:convert';

ResponseUploadImageKmob responseUploadImageKmobFromJson(String str) => ResponseUploadImageKmob.fromJson(json.decode(str));

String responseUploadImageKmobToJson(ResponseUploadImageKmob data) => json.encode(data.toJson());

class ResponseUploadImageKmob {
  ResponseUploadImageKmob({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory ResponseUploadImageKmob.fromJson(Map<String, dynamic> json) => ResponseUploadImageKmob(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.referenceNo,
    this.status,
    this.type,
    this.path,
    this.mediaUrl,
    this.mediaType,
  });

  String? referenceNo;
  String? status;
  String? type;
  String? path;
  String? mediaUrl;
  String? mediaType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    referenceNo: json["reference_no"] == null ? null : json["reference_no"],
    status: json["status"] == null ? null : json["status"],
    type: json["type"] == null ? null : json["type"],
    path: json["path"] == null ? null : json["path"],
    mediaUrl: json["media_url"] == null ? null : json["media_url"],
    mediaType: json["media_type"] == null ? null : json["media_type"],
  );

  Map<String, dynamic> toJson() => {
    "reference_no": referenceNo == null ? null : referenceNo,
    "status": status == null ? null : status,
    "type": type == null ? null : type,
    "path": path == null ? null : path,
    "media_url": mediaUrl == null ? null : mediaUrl,
    "media_type": mediaType == null ? null : mediaType,
  };
}
