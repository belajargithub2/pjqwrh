import 'dart:convert';

ResponseSaveToDraft responseSaveToDraftFromJson(String str) => ResponseSaveToDraft.fromJson(json.decode(str));

String responseSaveToDraftToJson(ResponseSaveToDraft data) => json.encode(data.toJson());

class ResponseSaveToDraft {
  ResponseSaveToDraft({
    this.agentId,
    this.agentIdConfins,
    this.assets,
    this.birthDate,
    this.birthPlace,
    this.bpkbOwnershipStatus,
    this.branchId,
    this.customerName,
    this.disbursedAmount,
    this.gender,
    this.idNumber,
    this.legalName,
    this.maritalStatus,
    this.moId,
    this.moName,
    this.mobilePhone,
    this.photoKkUrl,
    this.photoKtpUrl,
    this.photoSpouseKtpUrl,
    this.photoStnkUrl,
    this.prospectId,
    this.spouseBirthDate,
    this.spouseBirthPlace,
    this.spouseGender,
    this.spouseIdNumber,
    this.spouseLegalName,
    this.spouseMobilePhone,
    this.spouseName,
    this.spouseSurgateMotherName,
    this.surgateMotherName,
    this.typeOfLob,
  });

  int? agentId;
  String? agentIdConfins;
  List<Asset>? assets;
  String? birthDate;
  String? birthPlace;
  String? bpkbOwnershipStatus;
  String? branchId;
  String? customerName;
  int? disbursedAmount;
  String? gender;
  String? idNumber;
  String? legalName;
  String? maritalStatus;
  String? moId;
  String? moName;
  String? mobilePhone;
  String? photoKkUrl;
  String? photoKtpUrl;
  String? photoSpouseKtpUrl;
  String? photoStnkUrl;
  String? prospectId;
  String? spouseBirthDate;
  String? spouseBirthPlace;
  String? spouseGender;
  String? spouseIdNumber;
  String? spouseLegalName;
  String? spouseMobilePhone;
  String? spouseName;
  String? spouseSurgateMotherName;
  String? surgateMotherName;
  String? typeOfLob;

  factory ResponseSaveToDraft.fromJson(Map<String, dynamic> json) => ResponseSaveToDraft(
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    agentIdConfins: json["agent_id_confins"] == null ? null : json["agent_id_confins"],
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
    birthDate: json["birth_date"] == null ? null : json["birth_date"],
    birthPlace: json["birth_place"] == null ? null : json["birth_place"],
    bpkbOwnershipStatus: json["bpkb_ownership_status"] == null ? null : json["bpkb_ownership_status"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    disbursedAmount: json["disbursed_amount"] == null ? null : json["disbursed_amount"],
    gender: json["gender"] == null ? null : json["gender"],
    idNumber: json["id_number"] == null ? null : json["id_number"],
    legalName: json["legal_name"] == null ? null : json["legal_name"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    moId: json["mo_id"] == null ? null : json["mo_id"],
    moName: json["mo_name"] == null ? null : json["mo_name"],
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
    photoKkUrl: json["photo_kk_url"] == null ? null : json["photo_kk_url"],
    photoKtpUrl: json["photo_ktp_url"] == null ? null : json["photo_ktp_url"],
    photoSpouseKtpUrl: json["photo_spouse_ktp_url"] == null ? null : json["photo_spouse_ktp_url"],
    photoStnkUrl: json["photo_stnk_url"] == null ? null : json["photo_stnk_url"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    spouseBirthDate: json["spouse_birth_date"] == null ? null : json["spouse_birth_date"],
    spouseBirthPlace: json["spouse_birth_place"] == null ? null : json["spouse_birth_place"],
    spouseGender: json["spouse_gender"] == null ? null : json["spouse_gender"],
    spouseIdNumber: json["spouse_id_number"] == null ? null : json["spouse_id_number"],
    spouseLegalName: json["spouse_legal_name"] == null ? null : json["spouse_legal_name"],
    spouseMobilePhone: json["spouse_mobile_phone"] == null ? null : json["spouse_mobile_phone"],
    spouseName: json["spouse_name"] == null ? null : json["spouse_name"],
    spouseSurgateMotherName: json["spouse_surgate_mother_name"] == null ? null : json["spouse_surgate_mother_name"],
    surgateMotherName: json["surgate_mother_name"] == null ? null : json["surgate_mother_name"],
    typeOfLob: json["type_of_lob"] == null ? null : json["type_of_lob"],
  );

  Map<String, dynamic> toJson() => {
    "agent_id": agentId == null ? null : agentId,
    "agent_id_confins": agentIdConfins == null ? null : agentIdConfins,
    "assets": assets == null ? null : List<dynamic>.from(assets!.map((x) => x.toJson())),
    "birth_date": birthDate == null ? null : birthDate,
    "birth_place": birthPlace == null ? null : birthPlace,
    "bpkb_ownership_status": bpkbOwnershipStatus == null ? null : bpkbOwnershipStatus,
    "branch_id": branchId == null ? null : branchId,
    "customer_name": customerName == null ? null : customerName,
    "disbursed_amount": disbursedAmount == null ? null : disbursedAmount,
    "gender": gender == null ? null : gender,
    "id_number": idNumber == null ? null : idNumber,
    "legal_name": legalName == null ? null : legalName,
    "marital_status": maritalStatus == null ? null : maritalStatus,
    "mo_id": moId == null ? null : moId,
    "mo_name": moName == null ? null : moName,
    "mobile_phone": mobilePhone == null ? null : mobilePhone,
    "photo_kk_url": photoKkUrl == null ? null : photoKkUrl,
    "photo_ktp_url": photoKtpUrl == null ? null : photoKtpUrl,
    "photo_spouse_ktp_url": photoSpouseKtpUrl == null ? null : photoSpouseKtpUrl,
    "photo_stnk_url": photoStnkUrl == null ? null : photoStnkUrl,
    "prospect_id": prospectId == null ? null : prospectId,
    "spouse_birth_date": spouseBirthDate == null ? null : spouseBirthDate,
    "spouse_birth_place": spouseBirthPlace == null ? null : spouseBirthPlace,
    "spouse_gender": spouseGender == null ? null : spouseGender,
    "spouse_id_number": spouseIdNumber == null ? null : spouseIdNumber,
    "spouse_legal_name": spouseLegalName == null ? null : spouseLegalName,
    "spouse_mobile_phone": spouseMobilePhone == null ? null : spouseMobilePhone,
    "spouse_name": spouseName == null ? null : spouseName,
    "spouse_surgate_mother_name": spouseSurgateMotherName == null ? null : spouseSurgateMotherName,
    "surgate_mother_name": surgateMotherName == null ? null : surgateMotherName,
    "type_of_lob": typeOfLob == null ? null : typeOfLob,
  };
}

class Asset {
  Asset({
    this.licenseArea,
    this.licenseCode,
    this.licenseNumber,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleRegistrationName,
    this.vehicleType,
    this.vehicleYear,
  });

  String? licenseArea;
  String? licenseCode;
  String? licenseNumber;
  String? vehicleBrand;
  String? vehicleModel;
  String? vehicleRegistrationName;
  String? vehicleType;
  int? vehicleYear;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    licenseArea: json["license_area"] == null ? null : json["license_area"],
    licenseCode: json["license_code"] == null ? null : json["license_code"],
    licenseNumber: json["license_number"] == null ? null : json["license_number"],
    vehicleBrand: json["vehicle_brand"] == null ? null : json["vehicle_brand"],
    vehicleModel: json["vehicle_model"] == null ? null : json["vehicle_model"],
    vehicleRegistrationName: json["vehicle_registration_name"] == null ? null : json["vehicle_registration_name"],
    vehicleType: json["vehicle_type"] == null ? null : json["vehicle_type"],
    vehicleYear: json["vehicle_year"] == null ? null : json["vehicle_year"],
  );

  Map<String, dynamic> toJson() => {
    "license_area": licenseArea == null ? null : licenseArea,
    "license_code": licenseCode == null ? null : licenseCode,
    "license_number": licenseNumber == null ? null : licenseNumber,
    "vehicle_brand": vehicleBrand == null ? null : vehicleBrand,
    "vehicle_model": vehicleModel == null ? null : vehicleModel,
    "vehicle_registration_name": vehicleRegistrationName == null ? null : vehicleRegistrationName,
    "vehicle_type": vehicleType == null ? null : vehicleType,
    "vehicle_year": vehicleYear == null ? null : vehicleYear,
  };
}
