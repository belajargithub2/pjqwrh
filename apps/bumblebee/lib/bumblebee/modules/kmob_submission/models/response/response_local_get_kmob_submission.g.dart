// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_local_get_kmob_submission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseLocalGetKmobSubmissionAdapter
    extends TypeAdapter<ResponseLocalGetKmobSubmission> {
  @override
  final int typeId = 1;

  @override
  ResponseLocalGetKmobSubmission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseLocalGetKmobSubmission(
      branchId: fields[0] as String?,
      typeOfLob: fields[1] as String?,
      prospectId: fields[2] as String?,
      customerName: fields[3] as String?,
      legalName: fields[4] as String?,
      birthDate: fields[5] as String?,
      birthPlace: fields[6] as String?,
      idNumber: fields[7] as String?,
      gender: fields[8] as String?,
      maritalStatus: fields[9] as String?,
      mobilePhone: fields[10] as String?,
      surgateMotherName: fields[11] as String?,
      spouseName: fields[12] as String?,
      spouseMobilePhone: fields[13] as String?,
      spouseLegalName: fields[14] as String?,
      spouseBirthDate: fields[15] as String?,
      spouseBirthPlace: fields[16] as String?,
      spouseIdNumber: fields[17] as String?,
      spouseGender: fields[18] as String?,
      spouseSurgateMotherName: fields[19] as String?,
      disbursedAmount: fields[20] as int?,
      agentId: fields[21] as int?,
      bpkbOwnershipStatus: fields[22] as String?,
      photoKtpUrl: fields[23] as String?,
      photoKkUrl: fields[24] as String?,
      photoStnkUrl: fields[25] as String?,
      photoSpouseKtpUrl: fields[26] as String?,
      vehicleBrand: fields[27] as String?,
      vehicleModel: fields[28] as String?,
      vehicleType: fields[29] as String?,
      licenseArea: fields[30] as String?,
      licenseNumber: fields[31] as String?,
      licenseCode: fields[32] as String?,
      vehicleYear: fields[33] as int?,
      vehicleRegistrationName: fields[34] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseLocalGetKmobSubmission obj) {
    writer
      ..writeByte(35)
      ..writeByte(0)
      ..write(obj.branchId)
      ..writeByte(1)
      ..write(obj.typeOfLob)
      ..writeByte(2)
      ..write(obj.prospectId)
      ..writeByte(3)
      ..write(obj.customerName)
      ..writeByte(4)
      ..write(obj.legalName)
      ..writeByte(5)
      ..write(obj.birthDate)
      ..writeByte(6)
      ..write(obj.birthPlace)
      ..writeByte(7)
      ..write(obj.idNumber)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.maritalStatus)
      ..writeByte(10)
      ..write(obj.mobilePhone)
      ..writeByte(11)
      ..write(obj.surgateMotherName)
      ..writeByte(12)
      ..write(obj.spouseName)
      ..writeByte(13)
      ..write(obj.spouseMobilePhone)
      ..writeByte(14)
      ..write(obj.spouseLegalName)
      ..writeByte(15)
      ..write(obj.spouseBirthDate)
      ..writeByte(16)
      ..write(obj.spouseBirthPlace)
      ..writeByte(17)
      ..write(obj.spouseIdNumber)
      ..writeByte(18)
      ..write(obj.spouseGender)
      ..writeByte(19)
      ..write(obj.spouseSurgateMotherName)
      ..writeByte(20)
      ..write(obj.disbursedAmount)
      ..writeByte(21)
      ..write(obj.agentId)
      ..writeByte(22)
      ..write(obj.bpkbOwnershipStatus)
      ..writeByte(23)
      ..write(obj.photoKtpUrl)
      ..writeByte(24)
      ..write(obj.photoKkUrl)
      ..writeByte(25)
      ..write(obj.photoStnkUrl)
      ..writeByte(26)
      ..write(obj.photoSpouseKtpUrl)
      ..writeByte(27)
      ..write(obj.vehicleBrand)
      ..writeByte(28)
      ..write(obj.vehicleModel)
      ..writeByte(29)
      ..write(obj.vehicleType)
      ..writeByte(30)
      ..write(obj.licenseArea)
      ..writeByte(31)
      ..write(obj.licenseNumber)
      ..writeByte(32)
      ..write(obj.licenseCode)
      ..writeByte(33)
      ..write(obj.vehicleYear)
      ..writeByte(34)
      ..write(obj.vehicleRegistrationName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseLocalGetKmobSubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
