import 'dart:convert';

CreateSnapNBuyResponse createSnapNBuyResponseFromJson(String str) => CreateSnapNBuyResponse.fromJson(json.decode(str));

String createSnapNBuyResponseToJson(CreateSnapNBuyResponse data) => json.encode(data.toJson());

class CreateSnapNBuyResponse {
  CreateSnapNBuyResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  CreateSnapNBuyData? data;

  factory CreateSnapNBuyResponse.fromJson(Map<String, dynamic> json) => CreateSnapNBuyResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CreateSnapNBuyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class CreateSnapNBuyData {
  CreateSnapNBuyData({
    this.uniqueQrCode,
    this.qrCodeUrl,
    this.mediaType,
    this.prospectId,
    this.mobilePhone,
    this.expiredAt,
    this.timeNow,
  });

  String? uniqueQrCode;
  String? qrCodeUrl;
  String? mediaType;
  String? prospectId;
  String? mobilePhone;
  DateTime? expiredAt;
  DateTime? timeNow;

  factory CreateSnapNBuyData.fromJson(Map<String, dynamic> json) => CreateSnapNBuyData(
    uniqueQrCode: json["unique_qr_code"] == null ? null : json["unique_qr_code"],
    qrCodeUrl: json["qr_code_url"] == null ? null : json["qr_code_url"],
    mediaType: json["media_type"] == null ? null : json["media_type"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    timeNow: json["time_now"] == null ? null : DateTime.parse(json["time_now"]),
  );

  Map<String, dynamic> toJson() => {
    "unique_qr_code": uniqueQrCode == null ? null : uniqueQrCode,
    "qr_code_url": qrCodeUrl == null ? null : qrCodeUrl,
    "media_type": mediaType == null ? null : mediaType,
    "prospect_id": prospectId == null ? null : prospectId,
    "mobile_phone": mobilePhone == null ? null : mobilePhone,
    "expired_at": expiredAt == null ? null : expiredAt!.toIso8601String(),
    "time_now": timeNow == null ? null : timeNow!.toIso8601String(),
  };
}
