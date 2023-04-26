import 'dart:convert';

ResponseGetListLicenseArea responseGetListLicenseAreaFromJson(String str) => ResponseGetListLicenseArea.fromJson(json.decode(str));

String responseGetListLicenseAreaToJson(ResponseGetListLicenseArea data) => json.encode(data.toJson());

class ResponseGetListLicenseArea {
  ResponseGetListLicenseArea({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<LicenseArea>? data;

  factory ResponseGetListLicenseArea.fromJson(Map<String, dynamic> json) => ResponseGetListLicenseArea(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<LicenseArea>.from(json["data"].map((x) => LicenseArea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LicenseArea {
  LicenseArea({
    this.region,
    this.policeNo,
  });

  String? region;
  List<String>? policeNo;

  factory LicenseArea.fromJson(Map<String, dynamic> json) => LicenseArea(
    region: json["region"] == null ? null : json["region"],
    policeNo: json["police_no"] == null ? null : List<String>.from(json["police_no"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "region": region == null ? null : region,
    "police_no": policeNo == null ? null : List<dynamic>.from(policeNo!.map((x) => x)),
  };
}
