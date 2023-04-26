
import 'package:hive/hive.dart';

part 'response_local_get_kmob_submission.g.dart';

@HiveType(typeId: 1)
class ResponseLocalGetKmobSubmission {
  ResponseLocalGetKmobSubmission({
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

  @HiveField(0)
  String? branchId;

  @HiveField(1)
  String? typeOfLob;

  @HiveField(2)
  String? prospectId;

  @HiveField(3)
  String? customerName;

  @HiveField(4)
  String? legalName;

  @HiveField(5)
  String? birthDate;

  @HiveField(6)
  String? birthPlace;

  @HiveField(7)
  String? idNumber;

  @HiveField(8)
  String? gender;

  @HiveField(9)
  String? maritalStatus;

  @HiveField(10)
  String? mobilePhone;

  @HiveField(11)
  String? surgateMotherName;

  @HiveField(12)
  String? spouseName;

  @HiveField(13)
  String? spouseMobilePhone;

  @HiveField(14)
  String? spouseLegalName;

  @HiveField(15)
  String? spouseBirthDate;

  @HiveField(16)
  String? spouseBirthPlace;

  @HiveField(17)
  String? spouseIdNumber;

  @HiveField(18)
  String? spouseGender;

  @HiveField(19)
  String? spouseSurgateMotherName;

  @HiveField(20)
  int? disbursedAmount;

  @HiveField(21)
  int? agentId;

  @HiveField(22)
  String? bpkbOwnershipStatus;

  @HiveField(23)
  String? photoKtpUrl;

  @HiveField(24)
  String? photoKkUrl;

  @HiveField(25)
  String? photoStnkUrl;

  @HiveField(26)
  String? photoSpouseKtpUrl;

  @HiveField(27)
  String? vehicleBrand;

  @HiveField(28)
  String? vehicleModel;

  @HiveField(29)
  String? vehicleType;

  @HiveField(30)
  String? licenseArea;

  @HiveField(31)
  String? licenseNumber;

  @HiveField(32)
  String? licenseCode;

  @HiveField(33)
  int? vehicleYear;

  @HiveField(34)
  String? vehicleRegistrationName;
}
