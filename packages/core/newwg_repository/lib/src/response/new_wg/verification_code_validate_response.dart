import 'dart:convert';

VerificationCodeValidateResponse verificationCodeValidateResponseFromJson(String str) => VerificationCodeValidateResponse.fromJson(json.decode(str));

String verificationCodeValidateResponseToJson(VerificationCodeValidateResponse data) => json.encode(data.toJson());

class VerificationCodeValidateResponse {
    VerificationCodeValidateResponse({
        this.code,
        this.messages,
        this.data,
        this.errors,
    });

    int? code;
    String? messages;
    VerificationCodeValidateData? data;
    VerificationCodeValidateError? errors;

    factory VerificationCodeValidateResponse.fromJson(Map<String, dynamic> json) => VerificationCodeValidateResponse(
        code: json["code"],
        messages: json["messages"],
        data: json["data"] == null ? null : VerificationCodeValidateData.fromJson(json["data"]),
        errors: json["errors"] == null ? null : VerificationCodeValidateError.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "messages": messages,
        "data": data?.toJson(),
        "errors": errors?.toJson(),
    };
}

class VerificationCodeValidateData {
    VerificationCodeValidateData({
        this.customerId,
        this.sessionId,
        this.customerData,
    });

    int? customerId;
    String? sessionId;
    CustomerData? customerData;

    factory VerificationCodeValidateData.fromJson(Map<String, dynamic> json) => VerificationCodeValidateData(
        customerId: json["customer_id"],
        sessionId: json["session_id"],
        customerData: json["customer_data"] == null ? null : CustomerData.fromJson(json["customer_data"]),
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "session_id": sessionId,
        "customer_data": customerData?.toJson(),
    };
}

class CustomerData {
    CustomerData({
        this.idNumber,
        this.legalName,
        this.birthDate,
        this.birthPlace,
        this.gender,
        this.legalAddress,
        this.legalRt,
        this.legalRw,
        this.legalKelurahan,
        this.legalKecamatan,
        this.religion,
        this.religionDescription,
        this.maritalStatus,
        this.maritalStatusDescription,
        this.professionId,
        this.professionDescription,
        this.nationality,
        this.nationalityDescription,
        this.customerPhoto,
    });

    String? idNumber;
    String? legalName;
    String? birthDate;
    String? birthPlace;
    String? gender;
    String? legalAddress;
    String? legalRt;
    String? legalRw;
    String? legalKelurahan;
    String? legalKecamatan;
    String? religion;
    String? religionDescription;
    String? maritalStatus;
    String? maritalStatusDescription;
    String? professionId;
    String? professionDescription;
    String? nationality;
    String? nationalityDescription;
    CustomerPhoto? customerPhoto;

    factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        idNumber: json["id_number"],
        legalName: json["legal_name"],
        birthDate: json["birth_date"],
        birthPlace: json["birth_place"],
        gender: json["gender"],
        legalAddress: json["legal_address"],
        legalRt: json["legal_rt"],
        legalRw: json["legal_rw"],
        legalKelurahan: json["legal_kelurahan"],
        legalKecamatan: json["legal_kecamatan"],
        religion: json["religion"],
        religionDescription: json["religion_description"],
        maritalStatus: json["marital_status"],
        maritalStatusDescription: json["marital_status_description"],
        professionId: json["profession_id"],
        professionDescription: json["profession_description"],
        nationality: json["nationality"],
        nationalityDescription: json["nationality_description"],
        customerPhoto: json["customer_photo"] == null ? null : CustomerPhoto.fromJson(json["customer_photo"]),
    );

    Map<String, dynamic> toJson() => {
        "id_number": idNumber,
        "legal_name": legalName,
        "birth_date": birthDate,
        "birth_place": birthPlace,
        "gender": gender,
        "legal_address": legalAddress,
        "legal_rt": legalRt,
        "legal_rw": legalRw,
        "legal_kelurahan": legalKelurahan,
        "legal_kecamatan": legalKecamatan,
        "religion": religion,
        "religion_description": religionDescription,
        "marital_status": maritalStatus,
        "marital_status_description": maritalStatusDescription,
        "profession_id": professionId,
        "profession_description": professionDescription,
        "nationality": nationality,
        "nationality_description": nationalityDescription,
        "customer_photo": customerPhoto?.toJson(),
    };
}

class CustomerPhoto {
    CustomerPhoto({
        this.urlPhotoKtp,
        this.urlPhotoSelfie,
    });

    String? urlPhotoKtp;
    String? urlPhotoSelfie;

    factory CustomerPhoto.fromJson(Map<String, dynamic> json) => CustomerPhoto(
        urlPhotoKtp: json["url_photo_ktp"],
        urlPhotoSelfie: json["url_photo_selfie"],
    );

    Map<String, dynamic> toJson() => {
        "url_photo_ktp": urlPhotoKtp,
        "url_photo_selfie": urlPhotoSelfie,
    };
}

class VerificationCodeValidateError {
    VerificationCodeValidateError({
        this.code,
        this.message,
    });

    int? code;
    String? message;

    factory VerificationCodeValidateError.fromJson(Map<String, dynamic> json) => VerificationCodeValidateError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
