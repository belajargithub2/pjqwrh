import 'dart:async';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/mapper/bumblebee_kmob_mapper.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_bpkb_ownership_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_list_license_area.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_validate_police_no.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_brands.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_models.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_get_asset_types.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_validate_police_no.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeKMOBAssetDataSubmissionController extends GetxController {
  final BumblebeeKMOBSubmissionRepository? bumblebeeKmobSubmissionRepository;
  final BumblebeeKMOBSubmissionController? bumblebeeKmobSubmissionController;
  final BumblebeeDraftRepository? bumblebeeDraftRepository;

  BumblebeeKMOBAssetDataSubmissionController({
    this.bumblebeeKmobSubmissionRepository,
    this.bumblebeeKmobSubmissionController,
    this.bumblebeeDraftRepository
  });

  final formAssetDataKey = GlobalKey<FormState>();
  final vehicleBrandController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final disbursedAmountController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final licenseCodeController = TextEditingController();
  final bpkbOwnerShipStatusController = TextEditingController();
  final vehicleYearController = TextEditingController();
  final licenseAreaController = TextEditingController();
  final listviewController = ScrollController();
  final searchBrandController = TextEditingController();
  final searchModelController = TextEditingController();
  final searchTypeController = TextEditingController();
  final vehicleRegistrationNameController = TextEditingController();
  final searchPlatController = TextEditingController();

  Timer? debounce;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;
  final assetTypeId = 1.obs; // for kmob always 1
  final bpkbOwnerShipStatusId = ''.obs;
  final RxList<DataBpkbOwnerShipStatus> listBpkbOwnerShipStatus = <DataBpkbOwnerShipStatus>[].obs;

  final initialLimitBrand = ContentConstant.INITIAL_LIMIT.obs;
  final initialPageBrand = ContentConstant.INITIAL_PAGE.obs;
  final RxList<DataAssetBrand> listBrand = <DataAssetBrand>[].obs;
  final listBrandVisible = false.obs;
  final isLoadMoreBrand = false.obs;

  final initialLimitModel = ContentConstant.INITIAL_LIMIT.obs;
  final initialPageModel = ContentConstant.INITIAL_PAGE.obs;
  final RxList<DataAssetModel> listModel = <DataAssetModel>[].obs;
  final listModelVisible = false.obs;
  final isLoadMoreModel = false.obs;
  final isModelEnabled = false.obs;

  final initialLimitType = ContentConstant.INITIAL_LIMIT.obs;
  final initialPageType = ContentConstant.INITIAL_PAGE.obs;
  final RxList<DataAssetType> listType = <DataAssetType>[].obs;
  final listTypeVisible = false.obs;
  final isLoadMoreType = false.obs;
  final isTypeEnabled = false.obs;
  final isShowBottomSheetLicenseArea = false.obs;
  final disbursedAmount = 0.obs;
  final RxList<LicenceAreaModel> listLicenceArea = <LicenceAreaModel>[].obs;
  static const DEFAULT_PAGE = 1;
  static const FIVE_HUNDRED_MILLISECOND = 500;
  static const ONE_THOUSAND_MILLISECOND = 1000;
  static const extractNumberOnlyRegExp = r'[^0-9]';

  @override
  void onInit() {
    Future.wait([
      fetchApiBpkbOwnerShipStatus(),
      fetchApiBrand(),
      fetchApiGetPlat(),
    ]).then((value) {
      checkDraftAssetData();
    });
    super.onInit();
  }

  @override
  void onClose() {
    debounce?.cancel();
    super.onClose();
  }

  Future<List<DataBpkbOwnerShipStatus>> fetchApiBpkbOwnerShipStatus() async {
    ResponseGetBpkbOwnerShipStatus response = await bumblebeeKmobSubmissionRepository!.getBpkbOwnerShipStatus();
    listBpkbOwnerShipStatus.value = response.data!;
    return listBpkbOwnerShipStatus.value;
  }

  Map<String, dynamic> getRequestBrand({String brandName = ""}) {
    RequestGetAssetBrands requestGetBrand = RequestGetAssetBrands()
      ..limit = initialLimitBrand.value
      ..page = initialPageBrand.value
      ..brandName = brandName
      ..assetTypeId = assetTypeId.value;
    return requestGetBrand.toJson();
  }

  Map<String, dynamic> getRequestAssetModel({String modelName = ""}) {
    RequestGetAssetModels requestGetAssetModels = RequestGetAssetModels()
      ..limit = initialLimitModel.value
      ..page = initialPageModel.value
      ..modelName = modelName
      ..brandName = vehicleBrandController.text
      ..assetTypeId = assetTypeId.value;
    return requestGetAssetModels.toJson();
  }

  Map<String, dynamic> getRequestAssetType({String typeName = ""}) {
    RequestGetAssetTypes requestGetAssetTypes = RequestGetAssetTypes()
      ..limit = initialLimitType.value
      ..page = initialPageType.value
      ..modelName = vehicleModelController.text
      ..typeName = typeName
      ..brandName = vehicleBrandController.text
      ..assetTypeId = assetTypeId.value;
    return requestGetAssetTypes.toJson();
  }

  void updateListModel(ResponseGetAssetModel responseGetAssetModel) {
    if (responseGetAssetModel.data!.length > 0) {
      initialPageModel.value++;
      listModel.addAll(responseGetAssetModel.data!);
      listModel.toSet().toList();
      listModel.refresh();
      isLoadMoreModel.value = true;
    } else {
      isLoadMoreModel.value = false;
    }
  }

  Future<ResponseGetAssetModel> fetchApiModel({int page = DEFAULT_PAGE, String modelName = ""}) async {
    try {
      ResponseGetAssetModel responseGetAssetModel =  await bumblebeeKmobSubmissionRepository!
          .getAssetModels(getRequestAssetModel(modelName: modelName));
      updateListModel(responseGetAssetModel);
      return responseGetAssetModel;
    } catch (_) {
      isLoadMoreModel.value = false;
      return ResponseGetAssetModel();
    }
  }

  void updateListType(ResponseGetAssetTypes response) {
    if (response.data!.length > 0) {
      initialPageType.value++;
      listType.addAll(response.data!);
      listType.toSet().toList();
      listType.refresh();
      isLoadMoreType.value = true;
    } else {
      isLoadMoreType.value = false;
    }
  }

  Future<ResponseGetAssetTypes> fetchApiType({int page = DEFAULT_PAGE, String typeName = ""}) async {
    try {
      ResponseGetAssetTypes response = await bumblebeeKmobSubmissionRepository!.getAssetTypes(requestBody: getRequestAssetType(typeName: typeName));
      updateListType(response);
      return response;
    } catch (_) {
      isLoadMoreType.value = false;
      return ResponseGetAssetTypes();
    }
  }


  void updateListBrand(ResponseGetAssetBrands response){
    if (response.data!.length > 0) {
      initialPageBrand.value++;
      listBrand.addAll(response.data!);
      listBrand.toSet().toList();
      listBrand.refresh();
      isLoadMoreBrand.value = true;
    } else {
      isLoadMoreBrand.value = false;
    }
  }
  
  Future<ResponseGetAssetBrands> fetchApiBrand({int page = DEFAULT_PAGE, String brandName = ""}) async {
    try {
      ResponseGetAssetBrands response = await bumblebeeKmobSubmissionRepository!.getBrand(requestBody: getRequestBrand(brandName: brandName));
      updateListBrand(response);
      return response;
    } catch(_) {
      isLoadMoreBrand.value = false;
      return ResponseGetAssetBrands();
    }
  }

  void onTapBrand() {
    listBrandVisible.toggle();
  }

  void onTapModel() {
    listModelVisible.toggle();
  }

  void onTapType() {
    listTypeVisible.toggle();
  }

  void onChangeFindBrand(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce =
        Timer(const Duration(milliseconds: FIVE_HUNDRED_MILLISECOND), () async {
      listBrand.clear();
      listBrand.refresh();
      initialPageBrand.value = 1;
      if (text.isEmpty) {
        fetchApiBrand(page: initialPageBrand.value);
      } else {
        listBrand.clear();
        listBrand.refresh();
        fetchApiBrand(brandName: text);
      }
    });
  }

  void onChangeFindModel(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce =
        Timer(const Duration(milliseconds: FIVE_HUNDRED_MILLISECOND), () async {
      listModel.clear();
      listModel.refresh();
      initialPageModel.value = 1;
      if (text.isEmpty) {
        fetchApiModel(page: initialPageModel.value);
      } else {
        listModel.clear();
        listModel.refresh();
        fetchApiModel(modelName: text);
      }
    });
  }

  void onChangeFindType(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce =
        Timer(const Duration(milliseconds: FIVE_HUNDRED_MILLISECOND), () async {
      listType.clear();
      listType.refresh();
      initialPageType.value = 1;
      if (text.isEmpty) {
        fetchApiType(page: initialPageType.value);
      } else {
        listType.clear();
        listType.refresh();
        fetchApiType(typeName: text);
      }
    });
  }

  Future<bool> loadMoreBrand() async {
    if (isLoadMoreBrand.isTrue) {
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      if (searchBrandController.text.isNotEmpty) {
        fetchApiBrand(page: initialPageBrand.value, brandName: searchBrandController.text);
      } else {
        fetchApiBrand(page: initialPageBrand.value);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loadMoreModel() async {
    if (isLoadMoreModel.isTrue) {
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      if (searchModelController.text.isNotEmpty) {
        fetchApiModel(page: initialPageModel.value, modelName: searchModelController.text);
      } else {
        fetchApiModel(page: initialPageBrand.value);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loadMoreType() async {
    if (isLoadMoreType.isTrue) {
      await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
      if (searchTypeController.text.isNotEmpty) {
        fetchApiType(page: initialPageType.value, typeName: searchTypeController.text);
      } else {
        fetchApiType(page: initialPageBrand.value);
      }
      return true;
    } else {
      return false;
    }
  }

  void onTapBrandItem(DataAssetBrand listBrand) {
    vehicleBrandController.text = listBrand.brandName!;
    listBrandVisible.value = false;
    clearModelAndType();
  }

  void onTapModelItem(DataAssetModel dataAssetModel) {
    vehicleModelController.text = dataAssetModel.modelName!;
    listModelVisible.value = false;
    clearType();
  }

  void onTapTypeItem(DataAssetType dataAssetType) {
    vehicleTypeController.text = dataAssetType.typeName!;
    listTypeVisible.value = false;
  }

  void clearModelAndType() {
    listModel.clear();
    listType.clear();
    searchTypeController.clear();
    searchModelController.clear();
    vehicleModelController.clear();
    vehicleTypeController.clear();

    initialPageModel.value = ContentConstant.INITIAL_PAGE;
    initialPageType.value = ContentConstant.INITIAL_PAGE;
    isModelEnabled.value = true;
    isTypeEnabled.value = false;

    fetchApiModel();
  }

  void clearType() {
    listType.clear();
    searchTypeController.clear();
    vehicleTypeController.clear();

    initialPageType.value = ContentConstant.INITIAL_PAGE;
    isTypeEnabled.value = true;

    fetchApiType();
  }

  Future<void> refreshBrand() async {
    await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
    listBrand.clear();
    initialPageBrand.value = 1;
    if (searchBrandController.text.isEmpty) {
      fetchApiBrand();
    } else {
      fetchApiBrand(brandName: searchBrandController.text);
    }
  }

  Future<bool> refreshModel() async {
    await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
    listBrand.clear();
    initialPageBrand.value = 1;

    if (searchModelController.text.isNotEmpty) {
      fetchApiModel(page: initialPageModel.value, modelName: searchModelController.text);
    } else {
      fetchApiModel(page: initialPageModel.value);
    }
    return true;
  }

  Future<bool> refreshType() async {
    await Future.delayed(Duration(milliseconds: ONE_THOUSAND_MILLISECOND));
    listType.clear();
    initialPageType.value = 1;

    if (searchTypeController.text.isNotEmpty) {
      fetchApiType(page: initialPageType.value, typeName: searchTypeController.text);
    } else {
      fetchApiType(page: initialPageType.value);
    }
    return true;
  }

  Future<String> onChangeYearPicker(DateTime val) async {
    String year = DateFormat(DateConstant.yearFormat).format(val);
    vehicleYearController.text = year;
    return year;
  }

  void submit() async {
    autoValidate.value = AutovalidateMode.always;
    if (formAssetDataKey.currentState!.validate()) {
      ResponseValidatePoliceNo responseValidatePoliceNo = await validatePoliceNo();
      if (responseValidatePoliceNo.code == 200) {
        saveToLocalAndGotoUploadDocumentSection();
      }
    } else {
      bumblebeeKmobSubmissionController!.errorSnackBar(ContentConstant.errorValidationKMOBSubmission);
    }
  }

  void saveToLocalAndGotoUploadDocumentSection () async {
    if (bumblebeeKmobSubmissionController!.source.value == AgentSubmission.NEW) {
      setDataDataToLocal().then((value) async {
        await bumblebeeKmobSubmissionController!.saveOrUpdateToLocal(value.toLocal());
      });
    }
    bumblebeeKmobSubmissionController!.goToUploadDocumentSection();
  }

  Future<KmobSubmissionModel> setDataDataToLocal() async {
    KmobSubmissionModel model = bumblebeeKmobSubmissionController!.kmobSubmissionModel.value
      ..bpkbOwnershipStatus = bpkbOwnerShipStatusController.text
      ..licenseArea = licenseAreaController.text
      ..licenseCode = licenseCodeController.text
      ..licenseNumber = licenseNumberController.text
      ..vehicleBrand = vehicleBrandController.text
      ..vehicleModel = vehicleModelController.text
      ..disbursedAmount = disbursedAmountController.text.replaceAll(RegExp(extractNumberOnlyRegExp),'').toInt()
      ..vehicleRegistrationName = vehicleRegistrationNameController.text
      ..vehicleType = vehicleTypeController.text
      ..vehicleYear = vehicleYearController.text.toInt();
    return model;
  }

  void onChangeDisbursedAmount(String val) {
    if (val.isNotEmpty) {
      disbursedAmount.value = int.parse(val);
      String value = val.toCurrency();
      disbursedAmountController.text = value;
      disbursedAmountController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
  }

  Future<List<DataBpkbOwnerShipStatus>> filterLicenseStatus(String? filter) async {
    List<DataBpkbOwnerShipStatus> list = [];
    for (var item in listBpkbOwnerShipStatus) {
      if (item.name!.isContainIgnoreCase(filter!)) {
        list.add(item);
      }
    }
    return list;
  }

  void onChangeBpkbOwnerShipStatus(DataBpkbOwnerShipStatus result) {
    bpkbOwnerShipStatusController.text = result.name!;
    bpkbOwnerShipStatusId.value = result.code!;
  }

  void checkDraftAssetData() {
      KmobSubmissionModel model = bumblebeeKmobSubmissionController!.kmobSubmissionModel.value;
      licenseAreaController.text = model.licenseArea!;
      licenseNumberController.text = model.licenseNumber!;
      licenseAreaController.text = model.licenseArea!;
      licenseCodeController.text = model.licenseCode!;
      licenseNumberController.text = model.licenseNumber!;
      vehicleBrandController.text = model.vehicleBrand!;
      vehicleModelController.text = model.vehicleModel!;
      vehicleTypeController.text = model.vehicleType!;
      disbursedAmount.value = model.disbursedAmount ?? 0;
      vehicleRegistrationNameController.text = model.vehicleRegistrationName!;
      if (model.vehicleYear != null && model.disbursedAmount != 0) vehicleYearController.text = model.vehicleYear.toString();
      if (model.disbursedAmount != null && model.disbursedAmount != 0) disbursedAmountController.text = model.disbursedAmount.toString().toCurrency();
      if (model.bpkbOwnershipStatus != null) getBpkpOwnershipStatusById(model.bpkbOwnershipStatus);
      if (model.vehicleModel != null) enabledVehicleModel(model.vehicleModel!);
      if (model.vehicleType != null) enabledVehicleType(model.vehicleType!);
  }

  void enabledVehicleType(String type) {
    if (type.isNotEmpty && type != null) {
      listType.clear();
      isTypeEnabled.value = true;
      fetchApiType(page: DEFAULT_PAGE, typeName: type);
    }
  }

  void enabledVehicleModel(String vehicleModel) {
    if (vehicleModel.isNotEmpty && vehicleModel != null) {
      listModel.clear();
      isModelEnabled.value = true;
      fetchApiModel(page: DEFAULT_PAGE, modelName: vehicleModel);
    }
  }

  void getBpkpOwnershipStatusById(String? name) async {
      DataBpkbOwnerShipStatus? dataBpkbOwnerShipStatus = listBpkbOwnerShipStatus
          .firstWhereOrNull((data) => data.name == name);

        if (dataBpkbOwnerShipStatus != null) {
          bpkbOwnerShipStatusController.text = dataBpkbOwnerShipStatus.name!;
          bpkbOwnerShipStatusId.value = dataBpkbOwnerShipStatus.code!;
        }
  }

  Future<List<LicenceAreaModel>> fetchApiGetPlat() async {
    listLicenceArea.clear();
    ResponseGetListLicenseArea responseGetListLicenseArea = await bumblebeeKmobSubmissionRepository!.getListLicenseArea();

    responseGetListLicenseArea.data!.forEach((element) {
      listLicenceArea.add(LicenceAreaModel(
        region: element.region,
        policeNoList: setPoliceNo(element.policeNo!),
      ));
    });

    return listLicenceArea.toSet().toList();
  }

  void onChangeLicenseArea(String value) async {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      await fetchApiGetPlat();
      if (value.isNotEmpty) {
        searchPlatController.text = value;
        searchPlatController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
        listLicenceArea.value = findPlatInNestedList(value);
      }
    });
  }

  List<LicenceAreaModel> findPlatInNestedList(String value) {
    List<LicenceAreaModel> list = [];
    listLicenceArea.forEach((element) {
      if (element.region!.isContainIgnoreCase(value)) {
        list.add(element);
      } else {
        element.policeNoList!.forEach((policeNo) {
          if (policeNo.policeNo!.isContainIgnoreCase(value)) {
            int index = list.indexWhere((l) => element.region!.isEqualIgnoreCase(l.region!));
            if (index == -1) {
              list.add(LicenceAreaModel(
                region: element.region,
                policeNoList: [policeNo],
              ));
            } else {
              list[index].policeNoList!.add(policeNo);
            }
          }
        });
      }
    });
    return list;
  }

  void onTapChipPlatNo(String val) {
    licenseAreaController.text = val;
    listLicenceArea.refresh();
  }

  bool isChipSelected(String? policeNo) {
    if (licenseAreaController.text == policeNo) {
      return true;
    }
    return false;
  }

  RequestValidatePoliceNo requestValidatePoliceNo() {
    RequestValidatePoliceNo model = RequestValidatePoliceNo()
    ..licenseArea = licenseAreaController.text
    ..licenseCode = licenseCodeController.text
    ..licenseNumber = licenseNumberController.text;
    return model;
  }

  Future<ResponseValidatePoliceNo> validatePoliceNo() async {
    return bumblebeeKmobSubmissionRepository!.validatePoliceNo(Get.context, requestBody: requestValidatePoliceNo().toJson());
  }

  List<PoliceNoItem> setPoliceNo(List<String> policeNo) {
    List<PoliceNoItem> list = [];
    policeNo.forEach((element) {
      list.add(PoliceNoItem(policeNo: element));
    });
    return list;
  }

}
