import 'dart:convert';

RequestValidatePoliceNo requestValidatePoliceNoFromJson(String str) => RequestValidatePoliceNo.fromJson(json.decode(str));

String requestValidatePoliceNoToJson(RequestValidatePoliceNo data) => json.encode(data.toJson());

class RequestValidatePoliceNo {
  RequestValidatePoliceNo({
    this.licenseArea,
    this.licenseNumber,
    this.licenseCode,
  });

  String? licenseArea;
  String? licenseNumber;
  String? licenseCode;

  factory RequestValidatePoliceNo.fromJson(Map<String, dynamic> json) => RequestValidatePoliceNo(
    licenseArea: json["license_area"] == null ? null : json["license_area"],
    licenseNumber: json["license_number"] == null ? null : json["license_number"],
    licenseCode: json["license_code"] == null ? null : json["license_code"],
  );

  Map<String, dynamic> toJson() => {
    "license_area": licenseArea == null ? null : licenseArea,
    "license_number": licenseNumber == null ? null : licenseNumber,
    "license_code": licenseCode == null ? null : licenseCode,
  };
}
