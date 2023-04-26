import 'dart:convert';

VerificationCodeValidateResponse verificationCodeValidateResponseFromJson(String str) => VerificationCodeValidateResponse.fromJson(json.decode(str));

String verificationCodeValidateResponseToJson(VerificationCodeValidateResponse data) => json.encode(data.toJson());

class VerificationCodeValidateResponse {
  VerificationCodeValidateResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory VerificationCodeValidateResponse.fromJson(Map<String, dynamic> json) => VerificationCodeValidateResponse(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.prospectId,
    this.noKtp,
    this.customerName,
    this.birthPlace,
    this.birthDate,
    this.address,
    this.rtRw,
    this.district,
    this.religion,
    this.marritalStatus,
    this.job,
    this.nationality,
    this.phoneNumber,
    this.limitType,
    this.fotoKtpUrl,
    this.fotoSelfieUrl,
  });

  String? prospectId;
  String? noKtp;
  String? customerName;
  String? birthPlace;
  String? birthDate;
  String? address;
  String? rtRw;
  String? district;
  String? religion;
  String? marritalStatus;
  String? job;
  String? nationality;
  String? phoneNumber;
  String? limitType;
  String? fotoKtpUrl;
  String? fotoSelfieUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    prospectId: json["prospect_id"],
    noKtp: json["no_ktp"],
    customerName: json["customer_name"],
    birthPlace: json["birth_place"],
    birthDate: json["birth_date"],
    address: json["address"],
    rtRw: json["rt/rw"],
    district: json["district"],
    religion: json["religion"],
    marritalStatus: json["marrital_status"],
    job: json["job"],
    nationality: json["nationality"],
    phoneNumber: json["phone_number"],
    limitType: json["limit_type"],
    fotoKtpUrl: json["foto_ktp_url"],
    fotoSelfieUrl: json["foto_selfie_url"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId,
    "no_ktp": noKtp,
    "customer_name": customerName,
    "birth_place": birthPlace,
    "birth_date": birthDate,
    "address": address,
    "rt/rw": rtRw,
    "district": district,
    "religion": religion,
    "marrital_status": marritalStatus,
    "job": job,
    "nationality": nationality,
    "phone_number": phoneNumber,
    "limit_type": limitType,
    "foto_ktp_url": fotoKtpUrl,
    "foto_selfie_url": fotoSelfieUrl,
  };
}
