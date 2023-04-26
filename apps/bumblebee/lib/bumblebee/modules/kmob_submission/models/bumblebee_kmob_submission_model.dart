
import 'dart:typed_data';

import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';

class UploadImageModel {
  String name;
  String imagePath;
  String? imageUrl;
  Uint8List? draftImage;
  bool isFromCamera;
  keyUploadImageEnum? key;
  String documentType;

  UploadImageModel({
    this.name = "",
    this.imagePath = "",
    this.imageUrl = "",
    this.draftImage,
    this.isFromCamera = false,
    this.key,
    this.documentType = "",
  });
}

class KmobSubmissionModel {
  KmobSubmissionModel({
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
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleType,
    this.licenseArea,
    this.licenseNumber,
    this.licenseCode,
    this.vehicleYear,
    this.vehicleRegistrationName,
  });

  String? branchId = '';
  String? typeOfLob = '';
  String? prospectId = '';
  String? customerName = '';
  String? legalName = '';
  String? birthDate = '';
  String? birthPlace = '';
  String? idNumber = '';
  String? gender = '';
  String? maritalStatus = '';
  String? mobilePhone = '';
  String? surgateMotherName = '';
  String? spouseName = '';
  String? spouseMobilePhone = '';
  String? spouseLegalName = '';
  String? spouseBirthDate = '';
  String? spouseBirthPlace = '';
  String? spouseIdNumber = '';
  String? spouseGender = '';
  String? spouseSurgateMotherName = '';
  int? disbursedAmount = 0;
  int? agentId = 0;
  String? bpkbOwnershipStatus = '';
  String? photoKtpUrl = '';
  String? photoKkUrl = '';
  String? photoStnkUrl = '';
  String? photoSpouseKtpUrl = '';
  String? vehicleBrand = '';
  String? vehicleModel = '';
  String? vehicleType = '';
  String? licenseArea = '';
  String? licenseNumber = '';
  String? licenseCode = '';
  int? vehicleYear = 0;
  String? vehicleRegistrationName = '';
}

class LicenceAreaModel {
  String? region;
  List<PoliceNoItem>? policeNoList;

  LicenceAreaModel({
    this.region,
    this.policeNoList,
  });
}

class PoliceNoItem {
  String? policeNo;

  PoliceNoItem({
    this.policeNo,
  });
}