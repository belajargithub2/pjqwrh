import 'dart:convert';

CreateQrCodeResponse createQrCodeResponseFromJson(String str) =>
    CreateQrCodeResponse.fromJson(json.decode(str));

String createQrCodeResponseToJson(CreateQrCodeResponse data) =>
    json.encode(data.toJson());

class CreateQrCodeResponse {
  CreateQrCodeResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  CreateQrCodeData? data;

  factory CreateQrCodeResponse.fromJson(Map<String, dynamic> json) =>
      CreateQrCodeResponse(
        code: json["code"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] == null ? null : CreateQrCodeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? null,
        "message": message ?? null,
        "data": data == null ? null : data!.toJson()
      };
}

class CreateQrCodeData {
  CreateQrCodeData({
    this.id,
    this.supplierId,
    this.expiredDate,
    this.userId,
    this.qrCodePath,
    this.qrCodeUrl,
  });

  int? id;
  String? supplierId;
  DateTime? expiredDate;
  String? userId;
  String? qrCodePath;
  String? qrCodeUrl;

  factory CreateQrCodeData.fromJson(Map<String, dynamic> json) => CreateQrCodeData(
        id: json["id"] ?? null,
        supplierId: json["supplier_id"] ?? null,
        expiredDate: json["expired_date"] == null
            ? null
            : DateTime.parse(json["expired_date"]),
        userId: json["user_id"] ?? null,
        qrCodePath: json["qr_code_path"] ?? null,
        qrCodeUrl: json["qr_code_url"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "supplier_id": supplierId ?? null,
        "expired_date": expiredDate!.toIso8601String(),
        "user_id": userId ?? null,
        "qr_code_path": qrCodePath ?? null,
        "qr_code_url": qrCodeUrl ?? null,
      };
}
