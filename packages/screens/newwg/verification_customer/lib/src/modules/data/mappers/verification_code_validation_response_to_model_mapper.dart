import 'package:deasy_helper/deasy_helper.dart';
import 'package:newwg_repository/newwg_repository.dart' as response;
import 'package:verification_customer/src/modules/constans/strings.dart';
import 'package:verification_customer/src/modules/data/models/verification_code_validate_model.dart';

const EMPTY = "-";
const ZERO = 0;

extension VerificationCodeValidateResponseToModelMapper
    on response.VerificationCodeValidateResponse {
  VerificationCodeValidateModel toModel() {
    return VerificationCodeValidateModel(
      code: code,
      message: messages,
      data: VerificationCodeValidateData(
          customerId: data!.customerId ?? ZERO,
          sessionId: data!.sessionId ?? EMPTY,
          customerData: CustomerData(
            idNumber: data!.customerData!.idNumber ?? EMPTY,
            legalName: data!.customerData!.legalName ?? EMPTY,
            birthDate: data!.customerData!.birthDate
                ?.toFormattedDate(format: StringConstant.birthDateFormat, convertToLocal: false) ?? EMPTY,
            birthPlace: data!.customerData!.birthPlace ?? EMPTY,
            gender: data!.customerData!.gender ?? EMPTY,
            legalAddress: data!.customerData!.legalAddress ?? EMPTY,
            legalRt: data!.customerData!.legalRt ?? EMPTY,
            legalRw: data!.customerData!.legalRw ?? EMPTY,
            legalKelurahan: data!.customerData!.legalKelurahan ?? EMPTY,
            legalKecamatan: data!.customerData!.legalKecamatan ?? EMPTY,
            religion: data!.customerData!.religion ?? EMPTY,
            religionDescription: data!.customerData!.religionDescription ?? EMPTY,
            maritalStatus: data!.customerData!.maritalStatus ?? EMPTY,
            maritalStatusDescription: data!.customerData!.maritalStatusDescription ?? EMPTY,
            professionId: data!.customerData!.professionId ?? EMPTY,
            professionDescription: data!.customerData!.professionDescription ?? EMPTY,
            nationality: data!.customerData!.nationality ?? EMPTY,
            nationalityDescription: data!.customerData!.nationalityDescription ?? EMPTY,
            customerPhoto: CustomerPhoto(
              urlPhotoKtp: data!.customerData!.customerPhoto!.urlPhotoKtp ?? EMPTY,
              urlPhotoSelfie: data!.customerData!.customerPhoto!.urlPhotoSelfie ?? EMPTY,
            ),
          ),
      ),
    );
  }
}
