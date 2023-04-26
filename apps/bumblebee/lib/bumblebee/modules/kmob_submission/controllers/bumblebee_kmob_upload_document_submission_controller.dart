import 'dart:async';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/request/request_get_image_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_agent_order.dart' as ro;
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/mapper/bumblebee_kmob_mapper.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

enum keyUploadImageEnum { KTP, KTP_PASANGAN, KARTU_KELUARGA, STNK }

class BumblebeeKMOBUploadDocumentSubmissionController extends GetxController {
  final BumblebeeKMOBSubmissionRepository? kmobSubmissionRepository;
  final BumblebeeDraftRepository? draftRepository;
  final BumblebeeKMOBSubmissionController? kmobSubmissionController;
  final BumblebeeKMOBAssetDataSubmissionController? kmobAssetDataSubmissionController;
  final BumblebeeKMOBConsumerDataSubmissionController? kmobConsumerDataSubmissionController;

  BumblebeeKMOBUploadDocumentSubmissionController({
    this.kmobSubmissionRepository,
    this.draftRepository,
    this.kmobSubmissionController,
    this.kmobAssetDataSubmissionController,
    this.kmobConsumerDataSubmissionController
  });

  final Rx<TransactionListModel> transaction = TransactionListModel().obs;
  final isMarried = false.obs;
  final successValidation = false.obs;
  final isShowDialogOrder = false.obs;
  final isShowDialogOrderSuccess = false.obs;
  final isShowDialogDraft = false.obs;
  final isShowDialogDraftSuccess = false.obs;
  final typeName = "".obs;
  final documentType = "".obs;
  final RxList<UploadImageModel> listUpload = <UploadImageModel>[].obs;
  static const ktpKonsumen = 'KTP Konsumen';
  static const ktpPasangan = 'KTP Pasangan';
  static const kartuKeluarga = 'Kartu keluarga';
  static const stnk = 'STNK';
  static const documentTypeKtp = 'KTP';
  static const documentTypeKtpPasangan = 'KTP_PASANGAN';
  static const documentTypeKk = 'KK';
  static const documentTypeStnk = 'STNK';
  final ImagePicker imagePicker = ImagePicker();
  keyUploadImageEnum? imageKey = keyUploadImageEnum.KTP;

  @override
  void onInit() {
    super.onInit();
    isMarried.value = kmobConsumerDataSubmissionController!.isMarried.value;
    Future.wait([
      addItemToList()
    ]).then((value) {
      checkImageFromLocalOrDraft();
    });
  }

  Future<List<UploadImageModel>> addMarriedItemList() async {
    listUpload.add(UploadImageModel(
        name: ktpKonsumen,
        key: keyUploadImageEnum.KTP,
        documentType: documentTypeKtp));
    listUpload.add(UploadImageModel(
        name: ktpPasangan,
        key: keyUploadImageEnum.KTP_PASANGAN,
        documentType: documentTypeKtpPasangan,
        ));
    listUpload.add(UploadImageModel(
        name: kartuKeluarga,
        key: keyUploadImageEnum.KARTU_KELUARGA,
        documentType: documentTypeKk,
        ));
    listUpload.add(UploadImageModel(
        name: stnk,
        key: keyUploadImageEnum.STNK,
        documentType: documentTypeStnk,
        ));
    return listUpload;
  }

  Future<List<UploadImageModel>> addUnMarriedItemList() async {
    listUpload.add(UploadImageModel(
        name: ktpKonsumen,
        key: keyUploadImageEnum.KTP,
        documentType: documentTypeKtp,
        ));
    listUpload.add(UploadImageModel(
        name: kartuKeluarga,
        key: keyUploadImageEnum.KARTU_KELUARGA,
        documentType: documentTypeKk,
        ));
    listUpload.add(UploadImageModel(
        name: stnk,
        key: keyUploadImageEnum.STNK,
        documentType: documentTypeStnk,
        ));
    return listUpload;
  }

  void checkUrlIsAvailable(String imagePath, String? typeName, {bool isFromCamera = false, String? imageUrl}) {
    if (imagePath.isNotEmpty) {
      int index = listUpload.indexWhere((element) => element.name == typeName);
      listUpload[index].imagePath = imagePath;
      listUpload[index].isFromCamera = isFromCamera;
      listUpload[index].imageUrl = imageUrl;
      listUpload.refresh();
      saveToLocal(imageUrl, typeName);
    }
  }

  void checkImageFromLocalOrDraft() {
    kmobSubmissionController!.showLoading();
    Future.wait([
      getImageKkFromDraftOrLocal(),
      getImageKtpFromDraftOrLocal(),
      getImageStnkFromDraftOrLocal(),
      if(isMarried.value) getImageKtpPasanganFromDraft(),
    ]).whenComplete(() => kmobSubmissionController!.hiddenLoading());
  }

  Map<String, dynamic> requestGetImageDraft({String? photoUrl, String? documentType}) {
    RequestGetImageDraft requestGetImageDraft = RequestGetImageDraft()
      ..photoUrl = photoUrl
      ..documentType = documentType
      ..prospectId = kmobSubmissionController!.prospectId.value;
    return requestGetImageDraft.toJson();
  }

  Future<void> getImageKkFromDraftOrLocal() async {
    AgentSubmission? source = kmobSubmissionController!.source.value;
    String? photoKkUrl = kmobSubmissionController!.kmobSubmissionModel.value.photoKkUrl;

    if (!isNullEmptyOrFalse(photoKkUrl) || (source == AgentSubmission.DRAFT && photoKkUrl!.isNotEmpty )) {
      int index = listUpload.indexWhere((element) => element.documentType == documentTypeKk);
      listUpload[index].draftImage = await draftRepository!.getImageDraft(requestGetImageDraft(
        photoUrl: kmobSubmissionController!.kmobSubmissionModel.value.photoKkUrl,
        documentType: listUpload[index].documentType.toLowerCase(),
      ));
      listUpload.refresh();
    }
  }

  Future<void> getImageStnkFromDraftOrLocal() async {
    AgentSubmission? source = kmobSubmissionController!.source.value;
    String? photoStnkUrl = kmobSubmissionController!.kmobSubmissionModel.value.photoStnkUrl;
    if (!isNullEmptyOrFalse(photoStnkUrl) || (source == AgentSubmission.DRAFT && photoStnkUrl!.isNotEmpty )) {
      int index = listUpload.indexWhere((element) => element.documentType == documentTypeStnk);
      listUpload[index].draftImage = await draftRepository!.getImageDraft(requestGetImageDraft(
        photoUrl: kmobSubmissionController!.kmobSubmissionModel.value.photoStnkUrl,
        documentType: listUpload[index].documentType.toLowerCase(),
      ));
      listUpload.refresh();
    }
  }

  Future<void> getImageKtpPasanganFromDraft() async {
    AgentSubmission? source = kmobSubmissionController!.source.value;
    String? photoSpouseKtpUrl = kmobSubmissionController!.kmobSubmissionModel.value.photoSpouseKtpUrl;

    if (!isNullEmptyOrFalse(photoSpouseKtpUrl) || (source == AgentSubmission.DRAFT && photoSpouseKtpUrl!.isNotEmpty )) {
      int index = listUpload.indexWhere((element) => element.documentType == documentTypeKtpPasangan);
      listUpload[index].draftImage = await draftRepository!.getImageDraft(requestGetImageDraft(
        photoUrl: kmobSubmissionController!.kmobSubmissionModel.value.photoSpouseKtpUrl,
        documentType: listUpload[index].documentType.toLowerCase(),
      ));
      listUpload.refresh();
    }
  }

  Future<void> getImageKtpFromDraftOrLocal() async {
    AgentSubmission? source = kmobSubmissionController!.source.value;
    String? photoKtpUrl = kmobSubmissionController!.kmobSubmissionModel.value.photoKtpUrl;

    if (!isNullEmptyOrFalse(photoKtpUrl) || (source == AgentSubmission.DRAFT && photoKtpUrl!.isNotEmpty )) {
      int index = listUpload.indexWhere((element) => element.documentType == documentTypeKtp);
      listUpload[index].draftImage = await draftRepository!.getImageDraft(requestGetImageDraft(
        photoUrl: kmobSubmissionController!.kmobSubmissionModel.value.photoKtpUrl,
        documentType: listUpload[index].documentType.toLowerCase(),
      ));
      listUpload.refresh();
    }
  }

  Future<KmobSubmissionModel> setDataDataToLocal({String? imageUrl, String? typeName}) async {
    KmobSubmissionModel model = kmobSubmissionController!.kmobSubmissionModel.value;
    switch (typeName) {
      case ktpKonsumen:
        model.photoKtpUrl = imageUrl;
        break;
      case ktpPasangan:
        model.photoSpouseKtpUrl = imageUrl;
        break;
      case kartuKeluarga:
        model.photoKkUrl = imageUrl;
        break;
      case stnk:
        model.photoStnkUrl = imageUrl;
        break;
    }
    return model;
  }

  bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

  void saveToLocal(String? imageUrl, String? typeName) {
    if (kmobSubmissionController!.source.value != AgentSubmission.DRAFT) {
      setDataDataToLocal(imageUrl: imageUrl, typeName: typeName).then((value) async {
        await kmobSubmissionController!.saveOrUpdateToLocal(value.toLocal());
      });
    }
  }

  void submit() {
    isShowDialogOrder.value = true;
  }

  void onTapDraft() {
    isShowDialogDraft.value = true;
  }

  Future<void> agentOrder(BuildContext? context) async {
    int imageUrlLength = listUpload.where((element) => element.imageUrl!.isNotEmpty).length;
    int imageDraftLength = listUpload.where((element) =>
    element.draftImage != null && element.imagePath.isEmpty).length;

    if ((imageUrlLength + imageDraftLength) == (isMarried.value ? 4 : 3)) {
      kmobSubmissionRepository!
          .agentOrder(context, getRequestAgentOrder())
          .then((value) {
        transaction.value.prospectId = value.data!.prospectId;
        transaction.value.customerName = value.data!.customerName;
        isShowDialogOrderSuccess.value = true;
        deleteLocal();
      });
    } else {
      successValidation.value = true;
      listUpload.refresh();
      kmobSubmissionController!.errorSnackBar(ContentConstant.errorValidationKMOBSubmission);
    }
  }

  Future<Future<List<UploadImageModel>>> addItemToList() async {
    if (isMarried.value) {
      return addMarriedItemList();
    } else {
      return addUnMarriedItemList();
    }
  }

  void onTapTakeFromCamera(UploadImageModel uploadImageModel) {
    setValue(uploadImageModel);
    Get.toNamed(
      Routes.KMOB_SUBMISSION_UPLOAD_IMAGE_FROM_CAMERA,
    )!.then((value) {
      if (value != null) {
        String imagePath = value['imagePath'];
        String? imageUrl = value['imageUrl'];
        String? typeName = value['typeName'];
        checkUrlIsAvailable(imagePath, typeName,
            isFromCamera: true, imageUrl: imageUrl);
      }
    });
  }

  String? getUrlImage(String name) {
    int index = listUpload.indexWhere((element) => element.name == name);
    KmobSubmissionModel model = kmobSubmissionController!.kmobSubmissionModel.value;

    if (index < 0) {
      return '';
    }

    switch (name) {
      case ktpKonsumen:
        return listUpload[index].imageUrl!.isNotEmpty ? listUpload[index].imageUrl : model.photoKtpUrl;
      case ktpPasangan:
        return listUpload[index].imageUrl!.isNotEmpty ? listUpload[index].imageUrl : model.photoSpouseKtpUrl;
      case kartuKeluarga:
        return listUpload[index].imageUrl!.isNotEmpty ? listUpload[index].imageUrl : model.photoKkUrl;
      case stnk:
        return listUpload[index].imageUrl!.isNotEmpty ? listUpload[index].imageUrl : model.photoStnkUrl;
      default:
        return '';
    }
  }

  void onTapTakeFromGallery(UploadImageModel uploadImageModel) async {
    setValue(uploadImageModel);
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Get.toNamed(Routes.KMOB_SUBMISSION_REVIEW_IMAGE, arguments: {
        "imagePath": image.path,
        "imageFromCamera": false,
      })!.then((value) {
        if (value != null) {
          String imagePath = value['imagePath'];
          String? imageUrl = value['imageUrl'];
          String typeName = uploadImageModel.name;
          checkUrlIsAvailable(imagePath, typeName, imageUrl: imageUrl);
        }
      });
    }
  }

  void setValue(UploadImageModel uploadImageModel) {
    typeName.value = uploadImageModel.name;
    imageKey = uploadImageModel.key;
    documentType.value = uploadImageModel.documentType;
  }

  Map<String, dynamic> getRequestAgentOrder() {
    var asset = [
      ro.Asset(
        licenseArea: kmobAssetDataSubmissionController!.licenseAreaController.text,
        licenseCode: kmobAssetDataSubmissionController!.licenseCodeController.text,
        licenseNumber: kmobAssetDataSubmissionController!.licenseNumberController.text,
        vehicleBrand: kmobAssetDataSubmissionController!.vehicleBrandController.text,
        vehicleModel: kmobAssetDataSubmissionController!.vehicleModelController.text,
        vehicleRegistrationName: kmobAssetDataSubmissionController!.vehicleRegistrationNameController.text,
        vehicleType: kmobAssetDataSubmissionController!.vehicleTypeController.text,
        vehicleYear: kmobAssetDataSubmissionController!.vehicleYearController.text.toInt(),
      )
    ];

    ro.RequestAgentOrder requestAgentOrder = ro.RequestAgentOrder()
      ..agentId = kmobSubmissionController!.agentId.value.toInt()
      ..agentIdConfins = kmobConsumerDataSubmissionController!.agentIdConfins.value
      ..assets = asset
      ..birthDate = kmobConsumerDataSubmissionController!.birthDateController.text
      ..birthPlace = kmobConsumerDataSubmissionController!.birthPlaceController.text
      ..bpkbOwnershipStatus = kmobAssetDataSubmissionController!.bpkbOwnerShipStatusId.value
      ..branchId = kmobConsumerDataSubmissionController!.branchId.value
      ..customerName = kmobConsumerDataSubmissionController!.customerNameController.text
      ..disbursedAmount = kmobAssetDataSubmissionController!.disbursedAmount.value
      ..gender = kmobConsumerDataSubmissionController!.genderController.text.toUpperCase()
      ..idNumber = kmobConsumerDataSubmissionController!.idNumberController.text
      ..legalName = kmobConsumerDataSubmissionController!.customerNameController.text.toUpperCase()
      ..maritalStatus = kmobConsumerDataSubmissionController!.maritalStatusId.value
      ..moId = kmobConsumerDataSubmissionController!.moId.value
      ..moName = kmobConsumerDataSubmissionController!.moName.value
      ..mobilePhone = kmobConsumerDataSubmissionController!.mobilePhoneController.text
      ..photoKkUrl = getUrlImage(kartuKeluarga)
      ..photoKtpUrl = getUrlImage(ktpKonsumen)
      ..photoSpouseKtpUrl = getUrlImage(ktpPasangan)
      ..photoStnkUrl = getUrlImage(stnk)
      ..bpkbOwnershipStatus = kmobAssetDataSubmissionController!.bpkbOwnerShipStatusId.value
      ..prospectId = kmobSubmissionController!.prospectId.value
      ..spouseBirthDate = kmobConsumerDataSubmissionController!.spouseBirthDateController.text
      ..spouseBirthPlace = kmobConsumerDataSubmissionController!.spouseBirthPlaceController.text
      ..spouseGender = kmobConsumerDataSubmissionController!.spouseGenderController.text.toUpperCase()
      ..spouseIdNumber = kmobConsumerDataSubmissionController!.spouseIdNumberController.text
      ..spouseLegalName = kmobConsumerDataSubmissionController!.spouseNameController.text.toUpperCase()
      ..spouseMobilePhone = kmobConsumerDataSubmissionController!.spouseMobilePhoneController.text
      ..spouseName = kmobConsumerDataSubmissionController!.spouseNameController.text
      ..spouseSurgateMotherName = kmobConsumerDataSubmissionController!.spouseSurgateMotherNameController.text
      ..surgateMotherName = kmobConsumerDataSubmissionController!.surgateMotherNameController.text
      ..typeOfLob = kmobSubmissionController!.typeOfLob.value;
    return requestAgentOrder.toJson();
  }

  void onTapReadSubmission() {
    isShowDialogOrderSuccess.value = false;
    Future<void> goToTransaction = Get.toNamed(BumblebeeRoutes.DETAIL_TRANSACTION, arguments: {
      "transaction": transaction.value,
    })!.then((value) => Get.back());

    if (goToTransaction != null) {
      deleteLocal();
    }
  }

  void onTapSaveDraft(BuildContext? context) {
    int imageUrlLength = listUpload.where((element) => element.imageUrl!.isNotEmpty).length;
    int imageDraftLength = listUpload.where((element) =>
          element.draftImage != null && element.imagePath.isEmpty).length;

    if ((imageUrlLength + imageDraftLength) == (isMarried.value ? 4 : 3)) {
      draftRepository!
          .saveToDraft(context, getRequestAgentOrder())
          .then((value) {
        deleteLocal();
        isShowDialogDraftSuccess.value = true;
      });
    } else {
      successValidation.value = true;
      listUpload.refresh();
      kmobSubmissionController!.errorSnackBar(ContentConstant.errorValidationKMOBSubmission);
    }
  }

  void deleteLocal() {
    kmobSubmissionController!.deleteLocalRecord();
  }

  void navigateBack({required bool isBackToHome}) {
    Get.back(
      result: isBackToHome
    );
  }
}
