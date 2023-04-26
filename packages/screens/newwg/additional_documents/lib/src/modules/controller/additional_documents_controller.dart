import 'package:additional_documents/src/modules/constans/icons.dart';
import 'package:additional_documents/src/modules/constans/strings.dart';
import 'package:additional_documents/src/modules/constans/enums.dart';
import 'package:camera/camera.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg/config/auth_config.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/stepper.dart';

class AdditionalDocumentsController extends GetxController {
  final stepperController = Get.find<StepperContainerController>();
  final formKey = GlobalKey<FormState>();
  final isKtpFilled = true.obs;
  final isSelfieFilled = true.obs;
  final isSuccessUpload = false.obs;
  final ktpUrl = "".obs;
  final selfieUrl = "".obs;
  final customer = 0.obs;

  // camera config
  final showDialogCameraWeb = false.obs;
  final title = "".obs;
  final subTitle = "".obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final cameras = <CameraDescription>[].obs;
  final cameraController = Rxn<CameraController>();
  final cameraDescription = Rxn<CameraDescription>();
  final cameraInitialized = false.obs;
  XFile? imageFile;
  final imageBytes = Rxn<Uint8List>();
  final previewImagePath = "".obs;
  final repository = Get.find<NewWgRepositoryImpl>();
  final phoneNumber = "".obs;
  photoTypes photoType = photoTypes.ktp;

  @override
  void onInit() {
    phoneNumber.value = stepperController.phoneNumber.value;
    super.onInit();
  }

  setCustomerId(int? cId) {
    if (cId != null) {
      customer(cId);
    }
  }

  Future<void> callbackFromPreview(
      photoTypes photoType, String photoUrl) async {
    selectType(photoType);
    setImageUrl(photoUrl);
  }

  Future<void> initCam() async {
    try {
      cameraController.value = CameraController(
        cameraDescription.value!,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController.value!.initialize();
      cameraInitialized(true);
      isLoading(false);
    } catch (e) {
      handleCameraError(e);
    }
  }

  Future<void> activateCamera() async {
    previewImagePath("");
    try {
      isLoading(true);
      await getCameras();
      if (cameraDescription.value != null) {
        initCam();
      } else {
        cameras.clear();
        isLoading(false);
      }
    } catch (e) {
      handleCameraError(e);
    }
  }

  void handleCameraError(e) {
    isLoading(false);
    if (e is CameraException &&
        (e.code.contains("CameraAccessDenied") ||
            e.code.contains("AudioAccessDenied"))) {
      cameras.clear();
    } else {
      error.value = "$e";
    }
  }

  bool isContainExternalCam() {
    var isContain = false;
    for (var element in cameras) {
      if (element.lensDirection == CameraLensDirection.external) {
        isContain = true;
      }
    }

    return isContain;
  }

  bool isContainRearCam() {
    var isContain = false;
    for (var element in cameras) {
      if (element.lensDirection == CameraLensDirection.back) {
        isContain = true;
      }
    }

    return isContain;
  }

  Future<void> getCameras() async {
    try {
      cameras.clear();
      cameras.value = await availableCameras();
      if (DeasyResponsive.isTablet(Get.context!) ||
          DeasyResponsive.isMobile(Get.context!)) {
        if (isContainRearCam()) {
          cameraDescription.value = cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.back);
        } else if (isContainExternalCam()) {
          cameraDescription.value = cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.external);
        } else {
          cameraDescription.value = cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.front);
        }
      } else {
        if (isContainExternalCam()) {
          cameraDescription.value = cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.external);
        } else {
          cameraDescription.value = cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.front);
        }
      }
    } catch (e) {
      handleCameraError(e);
    }
  }

  AdditionalDocumentsSubmitRequest requestData() {
    int customerId = customer.value;
    String uploadSource = AuthConfig.instance.appSource;
    CustomerDocument ktpDoc =
        CustomerDocument(typeId: photoTypes.ktp.name, url: ktpUrl.value);
    CustomerDocument selfieDoc = CustomerDocument(
        typeId: photoTypes.selfieWithOfficer.name, url: selfieUrl.value);
    List<CustomerDocument> customerDocument = [ktpDoc, selfieDoc];
    return AdditionalDocumentsSubmitRequest(
        customerId: customerId,
        uploadSource: uploadSource,
        customerDocument: customerDocument);
  }

  void submit() {
    isLoading(true);
    if (ktpUrl.isEmpty) {
      isKtpFilled(false);
    }
    if (selfieUrl.isEmpty) {
      isSelfieFilled(false);
    }
    if (ktpUrl.isNotEmpty && selfieUrl.isNotEmpty) {
      AdditionalDocumentsSubmitRequest data = requestData();
      repository.submitAdditionalDocuments(Get.context!, data).then((res) {
        if (res.code == 200) {
          stepperController.goToPesanan();
        }
      });
    }
  }

  selectType(photoTypes type) {
    photoType = type;
  }

  setImageUrl(String? url) {
    if (photoType == photoTypes.ktp) {
      ktpUrl("");
      ktpUrl("$url");
    } else {
      selfieUrl("");
      selfieUrl("$url");
    }
  }

  takePicture() async {
    isLoading(true);
    imageFile = await cameraController.value?.takePicture();
    imageBytes.value = (await imageFile?.readAsBytes())!;
    previewImagePath.value = imageFile!.path;
    cameraController.value?.dispose();
    cameraInitialized(false);
    isLoading(false);
  }

  uploadPhoto() async {
    isLoading(true);
    imageFile?.readAsBytes().then((value) {
      List<int> bytes = value.cast();
      repository
          .uploadAddDocs(Get.context!, phoneNumber.value, photoType.name, bytes)
          .then((res) {
        if (res.code == 200) {
          setImageUrl(res.data?.mediaUrl);
          isSuccessUpload(true);
        }
      }).whenComplete(() {
        isLoading(false);
        _showDialogStatusUpload();
      });
    });
  }

  _showDialogStatusUpload() {
    DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      barrierDismissible: false,
      title: isSuccessUpload.isTrue
          ? StringConstant.titleDialogSuccess
          : StringConstant.titleDialogFailed,
      subTitle: isSuccessUpload.isTrue
          ? StringConstant.subTitleDialogSuccess
          : StringConstant.subTitleDialogFailed,
      fontSizeTitle: 20.0,
      fontSizeSubTitle: 14.0,
      icon: SvgPicture.asset(
        isSuccessUpload.isTrue
            ? IconsConstant.icSuccess
            : IconsConstant.icFailed,
      ),
      okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
      buttonOkText: isSuccessUpload.isTrue
          ? StringConstant.buttonOk
          : StringConstant.buttonBack,
      onPressButtonOk: () {
        cameraController.value?.dispose();
        if (isSuccessUpload.isTrue) {
          previewImagePath("");
          Navigator.of(Get.overlayContext!).pop();
        }
        Navigator.of(Get.overlayContext!).pop();
      },
    );
  }

  Future<Uint8List> getImageFromUrl(String url) async {
    final response =
        await repository.getImageCustomer(Get.context!, url, false);
    return response!;
  }
}
