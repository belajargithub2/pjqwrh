import 'dart:convert';

ResponseAgentOrder responseAgentOrderFromJson(String str) => ResponseAgentOrder.fromJson(json.decode(str));

String responseAgentOrderToJson(ResponseAgentOrder data) => json.encode(data.toJson());

class ResponseAgentOrder {
  ResponseAgentOrder({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  DataAgentOrder? data;

  factory ResponseAgentOrder.fromJson(Map<String, dynamic> json) => ResponseAgentOrder(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DataAgentOrder.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class DataAgentOrder {
  DataAgentOrder({
    this.branchId,
    this.moId,
    this.moName,
    this.agentIdConfins,
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
  String? moId;
  String? moName;
  String? agentIdConfins;
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

  factory DataAgentOrder.fromJson(Map<String, dynamic> json) => DataAgentOrder(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    moId: json["mo_id"] == null ? null : json["mo_id"],
    moName: json["mo_name"] == null ? null : json["mo_name"],
    agentIdConfins: json["agent_id_confins"] == null ? null : json["agent_id_confins"],
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
    surgateMotherName: json["surgate_mother_name"] == null ? null : json["surgate_mother_name"],
    spouseName: json["spouse_name"] == null ? null : json["spouse_name"],
    spouseMobilePhone: json["spouse_mobile_phone"] == null ? null : json["spouse_mobile_phone"],
    spouseLegalName: json["spouse_legal_name"] == null ? null : json["spouse_legal_name"],
    spouseBirthDate: json["spouse_birth_date"] == null ? null : json["spouse_birth_date"],
    spouseBirthPlace: json["spouse_birth_place"] == null ? null : json["spouse_birth_place"],
    spouseIdNumber: json["spouse_id_number"] == null ? null : json["spouse_id_number"],
    spouseGender: json["spouse_gender"] == null ? null : json["spouse_gender"],
    spouseSurgateMotherName: json["spouse_surgate_mother_name"] == null ? null : json["spouse_surgate_mother_name"],
    disbursedAmount: json["disbursed_amount"] == null ? null : json["disbursed_amount"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    bpkbOwnershipStatus: json["bpkb_ownership_status"] == null ? null : json["bpkb_ownership_status"],
    photoKtpUrl: json["photo_ktp_url"] == null ? null : json["photo_ktp_url"],
    photoKkUrl: json["photo_kk_url"] == null ? null : json["photo_kk_url"],
    photoStnkUrl: json["photo_stnk_url"] == null ? null : json["photo_stnk_url"],
    photoSpouseKtpUrl: json["photo_spouse_ktp_url"] == null ? null : json["photo_spouse_ktp_url"],
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId == null ? null : branchId,
    "mo_id": moId == null ? null : moId,
    "mo_name": moName == null ? null : moName,
    "agent_id_confins": agentIdConfins == null ? null : agentIdConfins,
    "type_of_lob": typeOfLob == null ? null : typeOfLob,
    "prospect_id": prospectId == null ? null : prospectId,
    "customer_name": customerName == null ? null : customerName,
    "legal_name": legalName == null ? null : legalName,
    "birth_date": birthDate == null ? null : birthDate,
    "birth_place": birthPlace == null ? null : birthPlace,
    "id_number": idNumber == null ? null : idNumber,
    "gender": gender == null ? null : gender,
    "marital_status": maritalStatus == null ? null : maritalStatus,
    "mobile_phone": mobilePhone == null ? null : mobilePhone,
    "surgate_mother_name": surgateMotherName == null ? null : surgateMotherName,
    "spouse_name": spouseName == null ? null : spouseName,
    "spouse_mobile_phone": spouseMobilePhone == null ? null : spouseMobilePhone,
    "spouse_legal_name": spouseLegalName == null ? null : spouseLegalName,
    "spouse_birth_date": spouseBirthDate == null ? null : spouseBirthDate,
    "spouse_birth_place": spouseBirthPlace == null ? null : spouseBirthPlace,
    "spouse_id_number": spouseIdNumber == null ? null : spouseIdNumber,
    "spouse_gender": spouseGender == null ? null : spouseGender,
    "spouse_surgate_mother_name": spouseSurgateMotherName == null ? null : spouseSurgateMotherName,
    "disbursed_amount": disbursedAmount == null ? null : disbursedAmount,
    "agent_id": agentId == null ? null : agentId,
    "bpkb_ownership_status": bpkbOwnershipStatus == null ? null : bpkbOwnershipStatus,
    "photo_ktp_url": photoKtpUrl == null ? null : photoKtpUrl,
    "photo_kk_url": photoKkUrl == null ? null : photoKkUrl,
    "photo_stnk_url": photoStnkUrl == null ? null : photoStnkUrl,
    "photo_spouse_ktp_url": photoSpouseKtpUrl == null ? null : photoSpouseKtpUrl,
    "assets": assets == null ? null : List<dynamic>.from(assets!.map((x) => x.toJson())),
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
    "vehicle_brand": vehicleBrand == null ? null : vehicleBrand,
    "vehicle_model": vehicleModel == null ? null : vehicleModel,
    "vehicle_type": vehicleType == null ? null : vehicleType,
    "license_area": licenseArea == null ? null : licenseArea,
    "license_number": licenseNumber == null ? null : licenseNumber,
    "license_code": licenseCode == null ? null : licenseCode,
    "vehicle_year": vehicleYear == null ? null : vehicleYear,
    "vehicle_registration_name": vehicleRegistrationName == null ? null : vehicleRegistrationName,
  };
}
