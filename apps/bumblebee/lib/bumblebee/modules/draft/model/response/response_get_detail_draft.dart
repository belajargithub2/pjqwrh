import 'dart:convert';


ResponseGetDetailDraft ResponseGetDetailDraftFromJson(String str) => ResponseGetDetailDraft.fromJson(json.decode(str));

String ResponseGetDetailDraftToJson(ResponseGetDetailDraft data) => json.encode(data.toJson());

class ResponseGetDetailDraft {
  ResponseGetDetailDraft({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory ResponseGetDetailDraft.fromJson(Map<String, dynamic> json) => ResponseGetDetailDraft(
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
    this.branchId,
    this.typeOfLob,
    this.prospectId,
    this.customerName,
    this.legalName,
    this.birthDate,
    this.birthPlace,
    this.idNumber,
    this.gender,
    this.maritalStatus,
    this.mobilePhone,
    this.surgateMotherName,
    this.spouseName,
    this.spouseMobilePhone,
    this.spouseLegalName,
    this.spouseBirthDate,
    this.spouseBirthPlace,
    this.spouseIdNumber,
    this.spouseGender,
    this.spouseSurgateMotherName,
    this.disbursedAmount,
    this.agentId,
    this.bpkbOwnershipStatus,
    this.photoKtpUrl,
    this.photoKkUrl,
    this.photoStnkUrl,
    this.photoSpouseKtpUrl,
    this.assets,
  });

  String? branchId;
  String? typeOfLob;
  String? prospectId;
  String? customerName;
  String? legalName;
  String? birthDate;
  String? birthPlace;
  String? idNumber;
  String? gender;
  String? maritalStatus;
  String? mobilePhone;
  String? surgateMotherName;
  String? spouseName;
  String? spouseMobilePhone;
  String? spouseLegalName;
  String? spouseBirthDate;
  String? spouseBirthPlace;
  String? spouseIdNumber;
  String? spouseGender;
  String? spouseSurgateMotherName;
  int? disbursedAmount;
  int? agentId;
  String? bpkbOwnershipStatus;
  String? photoKtpUrl;
  String? photoKkUrl;
  String? photoStnkUrl;
  String? photoSpouseKtpUrl;
  List<Asset>? assets;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    typeOfLob: json["type_of_lob"] == null ? null : json["type_of_lob"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    legalName: json["legal_name"] == null ? null : json["legal_name"],
    birthDate: json["birth_date"] == null ? null : json["birth_date"],
    birthPlace: json["birth_place"] == null ? null : json["birth_place"],
    idNumber: json["id_number"] == null ? null : json["id_number"],
    gender: json["gender"] == null ? null : json["gender"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
    surgateMotherName: json["surgate_mother_name"] == null ? "" : json["surgate_mother_name"],
    spouseName: json["spouse_name"] == null ? "" : json["spouse_name"],
    spouseMobilePhone: json["spouse_mobile_phone"] == null ? "" : json["spouse_mobile_phone"],
    spouseLegalName: json["spouse_legal_name"] == null ? "" : json["spouse_legal_name"],
    spouseBirthDate: json["spouse_birth_date"] == null ? "" : json["spouse_birth_date"],
    spouseBirthPlace: json["spouse_birth_place"] == null ? "" : json["spouse_birth_place"],
    spouseIdNumber: json["spouse_id_number"] == null ? "" : json["spouse_id_number"],
    spouseGender: json["spouse_gender"] == null ? "" : json["spouse_gender"],
    spouseSurgateMotherName: json["spouse_surgate_mother_name"] == null ? "" : json["spouse_surgate_mother_name"],
    disbursedAmount: json["disbursed_amount"] == null ? null : json["disbursed_amount"],
    agentId: json["agent_id"] == null ? "" as int? : json["agent_id"],
    bpkbOwnershipStatus: json["bpkb_ownership_status"] == null ? null : json["bpkb_ownership_status"],
    photoKtpUrl: json["photo_ktp_url"] == null ? null : json["photo_ktp_url"],
    photoKkUrl: json["photo_kk_url"] == null ? null : json["photo_kk_url"],
    photoStnkUrl: json["photo_stnk_url"] == null ? null : json["photo_stnk_url"],
    photoSpouseKtpUrl: json["photo_spouse_ktp_url"] == null ? "" : json["photo_spouse_ktp_url"],
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    if (branchId != null) "branch_id": branchId,
    if (typeOfLob != null) "type_of_lob": typeOfLob,
    if (prospectId != null) "prospect_id": prospectId,
    if (customerName != null) "customer_name": customerName,
    if (legalName != null) "legal_name": legalName,
    if (birthDate != null) "birth_date": birthDate,
    if (birthPlace != null) "birth_place": birthPlace,
    if (idNumber != null) "id_number": idNumber,
    if (gender != null) "gender": gender,
    if (maritalStatus != null) "marital_status": maritalStatus,
    if (mobilePhone != null) "mobile_phone": mobilePhone,
    if (surgateMotherName != null) "surgate_mother_name": surgateMotherName,
    if (branchId != null) "spouse_name": spouseName,
    if (spouseName != null) "spouse_mobile_phone": spouseMobilePhone,
    if (spouseLegalName != null) "spouse_legal_name": spouseLegalName,
    if (spouseBirthDate != null) "spouse_birth_date": spouseBirthDate,
    if (spouseBirthPlace != null) "spouse_birth_place": spouseBirthPlace,
    if (spouseIdNumber != null) "spouse_id_number": spouseIdNumber,
    if (spouseGender != null) "spouse_gender": spouseGender,
    if (spouseSurgateMotherName != null)"spouse_surgate_mother_name": spouseSurgateMotherName,
    if (disbursedAmount != null) "disbursed_amount": disbursedAmount,
    if (agentId != null) "agent_id": agentId,
    if (bpkbOwnershipStatus != null) "bpkb_ownership_status": bpkbOwnershipStatus,
    if (photoKtpUrl != null) "photo_ktp_url": photoKtpUrl,
    if (photoKkUrl != null) "photo_kk_url": photoKkUrl,
    if (photoStnkUrl != null) "photo_stnk_url": photoStnkUrl,
    if (photoSpouseKtpUrl != null) "photo_spouse_ktp_url": photoSpouseKtpUrl,
    if (assets != null) "assets": List<dynamic>.from(assets!.map((x) => x.toJson())),
  };
}

class Asset {
  Asset({
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleType,
    this.licenseArea,
    this.licenseNumber,
    this.licenseCode,
    this.vehicleYear,
    this.vehicleRegistrationName,
  });


  String? vehicleBrand;

  String? vehicleModel;

  String? vehicleType;

  String? licenseArea;

  String? licenseNumber;

  String? licenseCode;

  int? vehicleYear;

  String? vehicleRegistrationName;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    vehicleBrand: json["vehicle_brand"] == null ? null : json["vehicle_brand"],
    vehicleModel: json["vehicle_model"] == null ? null : json["vehicle_model"],
    vehicleType: json["vehicle_type"] == null ? null : json["vehicle_type"],
    licenseArea: json["license_area"] == null ? null : json["license_area"],
    licenseNumber: json["license_number"] == null ? null : json["license_number"],
    licenseCode: json["license_code"] == null ? null : json["license_code"],
    vehicleYear: json["vehicle_year"] == null ? null : json["vehicle_year"],
    vehicleRegistrationName: json["vehicle_registration_name"] == null ? null : json["vehicle_registration_name"],
  );

  Map<String, dynamic> toJson() => {
    if (vehicleBrand != null) "vehicle_brand": vehicleBrand,
    if (vehicleModel != null) "vehicle_model": vehicleModel,
    if (vehicleType != null) "vehicle_type": vehicleType,
    if (licenseArea != null) "license_area": licenseArea,
    if (licenseNumber != null) "license_number": licenseNumber,
    if (licenseCode != null) "license_code": licenseCode,
    if (vehicleYear != null) "vehicle_year": vehicleYear,
    if (vehicleRegistrationName != null)"vehicle_registration_name": vehicleRegistrationName,
  };
}
