import 'package:camera/camera.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_save_to_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_agent_order.dart' as requestAgentOrder;
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_generate_prospect_id_agent.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_agent_order.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_generate_prospect_id_agent.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_bpkb_ownership_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_branch.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_list_license_area.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_marital_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_upload_image_kmob.dart';



final responseLocalGetSubmission = ResponseLocalGetKmobSubmission(
  branchId: "145",
  typeOfLob: "KMOB",
  prospectId: "00000000000000000000000000000000",
  customerName: "Atung Sutisna",
  legalName: "Atung",
  birthDate: "1490-01-01",
  birthPlace: "Jakarta",
  idNumber: "012312312312321",
  gender: "Male",
  maritalStatus: "S",
  mobilePhone: "082131232132",
  surgateMotherName: "Atung",
  spouseName: "Atung",
  spouseMobilePhone: "081312312312",
  spouseLegalName: "Atung",
  spouseBirthDate: "1590-01-01",
  spouseBirthPlace: "Jakarta",
  spouseIdNumber: "012312312312321",
  spouseGender: "Female",
  spouseSurgateMotherName: "Atung",
  disbursedAmount: 10000000,
  agentId: 324783294789237,
  bpkbOwnershipStatus: "Owned",
  photoKtpUrl: "https://www.google.com",
  photoKkUrl: "https://www.google.com",
  photoStnkUrl: "https://www.google.com",
  photoSpouseKtpUrl: "https://www.google.com",
  vehicleBrand: "Honda",
  vehicleModel: "Jazz",
  vehicleType: "Sedan",
  licenseArea: "B",
  licenseNumber: "132",
  licenseCode: "AB",
  vehicleYear: 1400,
  vehicleRegistrationName: "Atung",
);

final responseGenerateProspectIdAgent = ResponseGenerateProspectIdAgent(
  code: 200,
  message: "Success",
  data: DataProspectIdAgent(
    prospectId: "123456",
    createdAt: DateTime.parse("2021-01-01 00:00:00"),
  ),
);

final requestGenerateProspectIdAgent = RequestGenerateProspectIdAgent(
  branchId: "145",
  lobType: "KMOB",
);

final responseGetBranch = ResponseGetBranch(
  code: 200,
  message: "Success",
  data: [
    BranchData(
      branchId: "145",
      branchFullName: "Kreditplus",
      moId: "123",
      moName: "Kreditplus",
      agentIdConfins: "123",
    ),
    BranchData(
      branchId: "146",
      branchFullName: "Kreditplus2",
      moId: "1234",
      moName: "Kreditplus2",
      agentIdConfins: "1234",
    ),
  ],
);

final responseGetMaritalStatus = ResponseGetMaritalStatus(
  code: 200,
  message: "Success",
  data: [
    MaritalStatusData(
      id: "S",
      text: "Single",
    ),
    MaritalStatusData(
      id: "M",
      text: "Married",
    ),
  ],
);

final listBranchData = [
  BranchData(
    branchId: "145",
    branchFullName: "Kreditplus",
    moId: "123",
    moName: "Kreditplus",
    agentIdConfins: "123",
  ),
  BranchData(
    branchId: "146",
    branchFullName: "Kreditplus2",
    moId: "1234",
    moName: "Kreditplus2",
    agentIdConfins: "1234",
  ),
];

final kmobSubmissionModelDummy = KmobSubmissionModel(
  branchId: "145",
  typeOfLob: "KMOB",
  prospectId: "00000000000000000000000000000000",
  customerName: "Atung Sutisna",
  legalName: "Atung",
  birthDate: "1490-01-01",
  birthPlace: "Jakarta",
  idNumber: "012312312312321",
  gender: "Male",
  maritalStatus: "S",
  mobilePhone: "082131232132",
  surgateMotherName: "Atung",
  spouseName: "Atung",
  spouseMobilePhone: "081312312312",
  spouseLegalName: "Atung",
  spouseBirthDate: "1590-01-01",
  spouseBirthPlace: "Jakarta",
  spouseIdNumber: "012312312312321",
  spouseGender: "Female",
  spouseSurgateMotherName: "Atung",
  disbursedAmount: 10000000,
  agentId: 324783294789237,
  bpkbOwnershipStatus: "Owned",
  photoKtpUrl: "https://www.google.com",
  photoKkUrl: "https://www.google.com",
  photoStnkUrl: "https://www.google.com",
  photoSpouseKtpUrl: "https://www.google.com",
  vehicleBrand: "Honda",
  vehicleModel: "Jazz",
  vehicleType: "Sedan",
  licenseArea: "B",
  licenseNumber: "132",
  licenseCode: "AB",
  vehicleYear: 1400,
  vehicleRegistrationName: "Atung",
);


final responseGetBpkbOwnerShipStatusDummy = ResponseGetBpkbOwnerShipStatus(
  code: 200,
  message: "Success",
  data: [
    DataBpkbOwnerShipStatus(
      code: "O",
      name: "Owned",
    ),
    DataBpkbOwnerShipStatus(
      code: "L",
      name: "Leased",
    ),
  ],
);

final responseGetBpkbOwnerShipStatusDummyEmpty = ResponseGetBpkbOwnerShipStatus(
  code: 200,
  message: "Success",
  data: [
  ],
);

final responseGetAssetBrandsDummy = ResponseGetAssetBrands(
  code: 200,
  message: "Success",
  data: [
    DataAssetBrand(
      brandName: "Honda",
    ),
    DataAssetBrand(
      brandName: "Toyota",
    ),
    DataAssetBrand(
      brandName: "Suzuki",
    ),
  ],
);

final responseGetAssetBrandsDummyEmpty = ResponseGetAssetBrands(
  code: 200,
  message: "Success",
  data: [],
);

final responseGetAssetTypesDummy = ResponseGetAssetTypes(
  code: 200,
  message: "Success",
  data: [
    DataAssetType(
      typeName: "Sedan",
    ),
    DataAssetType(
      typeName: "SUV",
    ),
    DataAssetType(
      typeName: "MPV",
    ),
  ],
);

final responseGetAssetTypesDummyEmpty = ResponseGetAssetTypes(
  code: 200,
  message: "Success",
  data: [],
);

final responseGetAssetTypesEmptyDummy = ResponseGetAssetTypes(
  code: 200,
  message: "Success",
  data: [],
);

final requestGetBranddummy = RequestGetAssetBrands(
    limit: 1,
    page : 1,
    brandName : "toyota",
    assetTypeId : 1,
);

final requestGetModelDummy = RequestGetAssetModels(
    limit: 1,
    page : 1,
    modelName : "toyota",
    assetTypeId : 1,
    brandName : "toyota",
);

final responseGetAssetModelsDummy = ResponseGetAssetModel(
  code: 200,
  message: "Success",
  data: [
    DataAssetModel(
      modelName: "Jazz",
    ),
    DataAssetModel(
      modelName: "Avanza",
    ),
    DataAssetModel(
      modelName: "Innova",
    ),
  ],
);
final responseGetAssetModelsDummyEmpty = ResponseGetAssetModel(
  code: 200,
  message: "Success",
  data: [],
);

final requestGetTypeDummy = RequestGetAssetTypes(
    limit: 10,
    page : 1,
    typeName : "toyota",
    brandName: "toyota",
    assetTypeId: 1,
    modelName: "Jazz",
);

final responseGetListLicenseAreaDummy = ResponseGetListLicenseArea(
  code: 200,
  message: "Success",
  data: [
    LicenseArea(
      region: "B",
      policeNo: [
        "AB",
        "CD",
        "EF",
      ],
    ),
    LicenseArea(
      region: "C",
      policeNo: [
        "GH",
        "IJ",
        "KL",
      ],
    ),
  ],
);

final responseAgentOrderDummy = ResponseAgentOrder(
  code: 200,
  message: "Success",
  data: DataAgentOrder(
    agentId: 123
  ));

final responseSaveToDraftDummy = ResponseSaveToDraft(
  agentId: 123,
);

final listUploadDummy = [
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP_PASANGAN', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
];

final listUploadNotMarriedDummy = [
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
];

final listUploadMarriedDummy = [
  UploadImageModel(name: 'KTP', key: keyUploadImageEnum.KTP, documentType: 'KTP', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'KTP Pasangan', key: keyUploadImageEnum.KTP_PASANGAN, documentType: 'KTP_PASANGAN', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'Kartu keluarga', key: keyUploadImageEnum.KARTU_KELUARGA, documentType: 'KK', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
  UploadImageModel(name: 'STNK', key: keyUploadImageEnum.STNK, documentType: 'STNK', imagePath: 'https://www.google.com', imageUrl: 'https://www.google.com'),
];

final requestAgentOrdersDummy = requestAgentOrder.RequestAgentOrder(
  agentId: 007007,
  agentIdConfins: "0034832",
  assets: [
    requestAgentOrder.Asset(
      vehicleBrand: "Toyota",
      vehicleType: "Sedan",
      vehicleModel: "Avanza",
      licenseArea: "B",
      licenseCode: "AB",
      licenseNumber: "1234",
      vehicleRegistrationName: "Atung",
      vehicleYear: 2019,
    )
  ],
  birthDate: "1490-01-01",
  birthPlace: "Jakarta",
  branchId: "007",
  customerName: "Atung",
  disbursedAmount: 10000000,
  gender: "L",
  idNumber: "012312312312321",
  legalName: "ATUNG",
  maritalStatus: "M",
  moId: "007",
  moName: "Atung",
  mobilePhone: "08123456789",
  photoKkUrl: "https://www.google.com",
  photoSpouseKtpUrl: "https://www.google.com",
  photoStnkUrl: "https://www.google.com",
  photoKtpUrl: '',
  bpkbOwnershipStatus: "L",
  prospectId: "123456789",
  spouseBirthDate: "1490-01-01",
  spouseBirthPlace: "Jakarta",
  spouseGender: "F",
  spouseIdNumber: "012312312312321",
  spouseLegalName: "ATUNG",
  spouseMobilePhone: "08123456789",
  spouseName: "Atung",
  spouseSurgateMotherName: "Jamila",
  surgateMotherName: "Luna maya",
  typeOfLob: "KMOB",
);


final CameraController cameraController = CameraController(
    const CameraDescription(
        name: 'cam',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90),
    ResolutionPreset.max);

final responseUploadImageKmobDummy = ResponseUploadImageKmob(
  code: 200,
  message: "Success",
  data: Data(
    mediaType: "image",
    mediaUrl: "https://www.google.com",
    path: "https://www.google.com",
    referenceNo: "123456789",
    status: "Success",
    type: "KTP"
  ),
);