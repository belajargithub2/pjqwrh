import 'dart:convert';

import 'package:deasy_pocket/deasy_pocket.dart';

SnapNBuySettingsResponse snapNBuySettingsResponseFromJson(String str) => SnapNBuySettingsResponse.fromJson(json.decode(str));

String snapNBuySettingsResponseToJson(SnapNBuySettingsResponse data) => json.encode(data.toJson());

class SnapNBuySettingsResponse {
  SnapNBuySettingsResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory SnapNBuySettingsResponse.fromJson(Map<String, dynamic> json) => SnapNBuySettingsResponse(
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
    this.isShowDp,
    this.useSnb,
    this.isMaintenanceMode,
    this.qrCodeTimer,
    this.retryGenerateQrCount,
  });

  bool? isShowDp;
  bool? useSnb;
  bool? isMaintenanceMode;
  int? qrCodeTimer;
  int? retryGenerateQrCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isShowDp: json["is_show_dp"] == null ? null : json["is_show_dp"],
    useSnb: json["use_snb"] == null ? null : json["use_snb"],
    isMaintenanceMode: json["is_maintenance_mode"] == null ? null : json["is_maintenance_mode"],
    qrCodeTimer: json["qr_code_timer"] == null ? null : json["qr_code_timer"],
    retryGenerateQrCount: json["retry_generate_qr_count"] == null ? null : json["retry_generate_qr_count"],
  );

  Map<String, dynamic> toJson() => {
    "is_show_dp": isShowDp == null ? null : isShowDp,
    "use_snb": useSnb == null ? null : useSnb,
    "is_maintenance_mode": isMaintenanceMode == null ? null : isMaintenanceMode,
    "qr_code_timer": qrCodeTimer == null ? null : qrCodeTimer,
    "retry_generate_qr_count": retryGenerateQrCount == null ? null : retryGenerateQrCount,
  };

  Future<void> toSharedPref() async {
    return await DeasyPocket().saveSnbSettingResponse(
      isShowDp: isShowDp!,
      useSnb: useSnb!,
      isMaintenanceMode: isMaintenanceMode!,
      qrCodeTimer: qrCodeTimer!,
      retryGenerateQrCount: retryGenerateQrCount!,
    );
  }

}
