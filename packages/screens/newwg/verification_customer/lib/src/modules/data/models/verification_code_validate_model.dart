class VerificationCodeValidateModel {
  VerificationCodeValidateModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  VerificationCodeValidateData? data;
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
}

class CustomerPhoto {
    CustomerPhoto({
        this.urlPhotoKtp,
        this.urlPhotoSelfie,
    });

    String? urlPhotoKtp;
    String? urlPhotoSelfie;
}