import 'dart:convert';

UploadDocumentResponse uploadDocumentResponseFromJson(String str) => UploadDocumentResponse.fromJson(json.decode(str));

String uploadDocumentResponseToJson(UploadDocumentResponse data) => json.encode(data.toJson());

class UploadDocumentResponse {
  UploadDocumentResponse({
    this.code,
    this.message,
    this.data,
    this.errors,
  });

  int? code;
  String? message;
  UploadDocumentData? data;
  UploadDocumentErrors? errors;

  factory UploadDocumentResponse.fromJson(Map<String, dynamic> json) => UploadDocumentResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : UploadDocumentData.fromJson(json["data"]),
        errors: json["errors"] == null ? null : UploadDocumentErrors.fromJson(json["errors"])
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class UploadDocumentErrors {
  UploadDocumentErrors({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory UploadDocumentErrors.fromJson(Map<String, dynamic> json) => UploadDocumentErrors(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}

class UploadDocumentData {
  UploadDocumentData({
    this.referenceNo,
    this.status,
    this.type,
    this.path,
    this.mediaUrl,
  });

  String? referenceNo;
  String? status;
  String? type;
  String? path;
  String? mediaUrl;

  factory UploadDocumentData.fromJson(Map<String, dynamic> json) => UploadDocumentData(
        referenceNo: json["reference_no"] == null ? null : json["reference_no"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        path: json["path"] == null ? null : json["path"],
        mediaUrl: json["media_url"] == null ? null : json["media_url"],
      );

  Map<String, dynamic> toJson() => {
        "reference_no": referenceNo == null ? null : referenceNo,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "path": path == null ? null : path,
        "media_url": mediaUrl == null ? null : mediaUrl,
      };
}
