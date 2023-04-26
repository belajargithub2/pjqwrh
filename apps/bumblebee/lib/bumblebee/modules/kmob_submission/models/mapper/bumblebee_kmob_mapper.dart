
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_get_detail_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';

const EMPTY = "";
const ZERO = 0;

extension LocalToModelMapper on ResponseLocalGetKmobSubmission {
  KmobSubmissionModel toModel() {
    return KmobSubmissionModel(
      branchId : this.branchId ?? EMPTY ,
      typeOfLob : this.typeOfLob ?? EMPTY,
      prospectId : this.prospectId ?? EMPTY,
      customerName : this.customerName ?? EMPTY,
      legalName : this.legalName ?? EMPTY,
      birthDate : this.birthDate ?? EMPTY,
      birthPlace : this.birthPlace ?? EMPTY,
      idNumber : this.idNumber ?? EMPTY,
      gender : this.gender ?? EMPTY,
      maritalStatus : this.maritalStatus ?? EMPTY,
      mobilePhone : this.mobilePhone ?? EMPTY,
      surgateMotherName : this.surgateMotherName ?? EMPTY,
      spouseName : this.spouseName ?? EMPTY,
      spouseMobilePhone : this.spouseMobilePhone ?? EMPTY,
      spouseLegalName : this.spouseLegalName ?? EMPTY,
      spouseBirthDate : this.spouseBirthDate ?? EMPTY,
      spouseBirthPlace : this.spouseBirthPlace ?? EMPTY,
      spouseIdNumber : this.spouseIdNumber ?? EMPTY,
      spouseGender : this.spouseGender ?? EMPTY,
      spouseSurgateMotherName : this.spouseSurgateMotherName ?? EMPTY,
      disbursedAmount : this.disbursedAmount ?? ZERO,
      bpkbOwnershipStatus: this.bpkbOwnershipStatus ?? EMPTY,
      agentId : this.agentId ?? ZERO,
      photoKtpUrl : this.photoKtpUrl ?? EMPTY,
      photoKkUrl : this.photoKkUrl ?? EMPTY,
      photoStnkUrl : this.photoStnkUrl ?? EMPTY,
      photoSpouseKtpUrl : this.photoSpouseKtpUrl ?? EMPTY,
      vehicleBrand : this.vehicleBrand ?? EMPTY,
      vehicleModel : this.vehicleModel ?? EMPTY,
      vehicleType : this.vehicleType ?? EMPTY,
      licenseArea : this.licenseArea ?? EMPTY,
      licenseNumber : this.licenseNumber ?? EMPTY,
      licenseCode : this.licenseCode ?? EMPTY,
      vehicleYear : this.vehicleYear ?? ZERO,
      vehicleRegistrationName : this.vehicleRegistrationName ?? EMPTY,
    );
  }
}

extension ModelToLocalMapper on KmobSubmissionModel{
  ResponseLocalGetKmobSubmission toLocal() {
    return ResponseLocalGetKmobSubmission(
      branchId : this.branchId ?? EMPTY ,
      typeOfLob : this.typeOfLob ?? EMPTY,
      prospectId : this.prospectId ?? EMPTY,
      customerName : this.customerName ?? EMPTY,
      legalName : this.legalName ?? EMPTY,
      birthDate : this.birthDate ?? EMPTY,
      birthPlace : this.birthPlace ?? EMPTY,
      idNumber : this.idNumber ?? EMPTY,
      gender : this.gender ?? EMPTY,
      maritalStatus : this.maritalStatus ?? EMPTY,
      mobilePhone : this.mobilePhone ?? EMPTY,
      surgateMotherName : this.surgateMotherName ?? EMPTY,
      spouseName : this.spouseName ?? EMPTY,
      spouseMobilePhone : this.spouseMobilePhone ?? EMPTY,
      spouseLegalName : this.spouseLegalName ?? EMPTY,
      spouseBirthDate : this.spouseBirthDate ?? EMPTY,
      spouseBirthPlace : this.spouseBirthPlace ?? EMPTY,
      spouseIdNumber : this.spouseIdNumber ?? EMPTY,
      spouseGender : this.spouseGender ?? EMPTY,
      spouseSurgateMotherName : this.spouseSurgateMotherName ?? EMPTY,
      disbursedAmount : this.disbursedAmount ?? ZERO,
      agentId : this.agentId ?? ZERO,
      bpkbOwnershipStatus : this.bpkbOwnershipStatus ?? EMPTY,
      photoKtpUrl : this.photoKtpUrl ?? EMPTY,
      photoKkUrl : this.photoKkUrl ?? EMPTY,
      photoStnkUrl : this.photoStnkUrl ?? EMPTY,
      photoSpouseKtpUrl : this.photoSpouseKtpUrl ?? EMPTY,
      vehicleBrand : this.vehicleBrand ?? EMPTY,
      vehicleModel : this.vehicleModel ?? EMPTY,
      vehicleType : this.vehicleType ?? EMPTY,
      licenseArea : this.licenseArea ?? EMPTY,
      licenseNumber : this.licenseNumber ?? EMPTY,
      licenseCode : this.licenseCode ?? EMPTY,
      vehicleYear : this.vehicleYear ?? ZERO,
      vehicleRegistrationName : this.vehicleRegistrationName ?? EMPTY,
    );
  }
}

extension ResponseGetAllDraftMapper on ResponseGetDetailDraft {
  KmobSubmissionModel toDomain() {
    return KmobSubmissionModel(
      branchId : this.data!.branchId ?? EMPTY ,
      typeOfLob : this.data!.typeOfLob ?? EMPTY,
      prospectId : this.data!.prospectId ?? EMPTY,
      customerName : this.data!.customerName ?? EMPTY,
      legalName : this.data!.legalName ?? EMPTY,
      birthDate : this.data!.birthDate ?? EMPTY,
      birthPlace : this.data!.birthPlace ?? EMPTY,
      idNumber : this.data!.idNumber ?? EMPTY,
      gender : this.data!.gender ?? EMPTY,
      maritalStatus : this.data!.maritalStatus ?? EMPTY,
      mobilePhone : this.data!.mobilePhone ?? EMPTY,
      surgateMotherName : this.data!.surgateMotherName ?? EMPTY,
      spouseName : this.data!.spouseName ?? EMPTY,
      spouseMobilePhone : this.data!.spouseMobilePhone ?? EMPTY,
      spouseLegalName : this.data!.spouseLegalName ?? EMPTY,
      spouseBirthDate : this.data!.spouseBirthDate ?? EMPTY,
      spouseBirthPlace : this.data!.spouseBirthPlace ?? EMPTY,
      spouseIdNumber : this.data!.spouseIdNumber ?? EMPTY,
      spouseGender : this.data!.spouseGender ?? EMPTY,
      spouseSurgateMotherName : this.data!.spouseSurgateMotherName ?? EMPTY,
      disbursedAmount : this.data!.disbursedAmount ?? ZERO,
      agentId : this.data!.agentId ?? ZERO,
      bpkbOwnershipStatus : this.data!.bpkbOwnershipStatus ?? EMPTY,
      photoKtpUrl : this.data!.photoKtpUrl ?? EMPTY,
      photoKkUrl : this.data!.photoKkUrl ?? EMPTY,
      photoStnkUrl : this.data!.photoStnkUrl ?? EMPTY,
      photoSpouseKtpUrl : this.data!.photoSpouseKtpUrl ?? EMPTY,
      vehicleBrand : this.data!.assets!.first.vehicleBrand ?? EMPTY,
      vehicleModel : this.data!.assets!.first.vehicleModel ?? EMPTY,
      vehicleType : this.data!.assets!.first.vehicleType ?? EMPTY,
      licenseArea : this.data!.assets!.first.licenseArea ?? EMPTY,
      licenseNumber : this.data!.assets!.first.licenseNumber ?? EMPTY,
      licenseCode : this.data!.assets!.first.licenseCode ?? EMPTY,
      vehicleYear : this.data!.assets!.first.vehicleYear ?? ZERO,
      vehicleRegistrationName : this.data!.assets!.first.vehicleRegistrationName ?? EMPTY,
    );
  }
}
