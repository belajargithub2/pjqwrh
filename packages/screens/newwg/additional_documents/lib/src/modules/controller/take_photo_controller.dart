import 'package:additional_documents/src/modules/constans/enums.dart';
import 'package:additional_documents/src/modules/constans/icons.dart';
import 'package:additional_documents/src/modules/constans/strings.dart';
import 'package:additional_documents/src/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:permission_handler/permission_handler.dart';

class TakePhotoController extends GetxController {
  // camera config
  final isLoadingCam = false.obs;
  final error = ''.obs;
  final cameras = <CameraDescription>[].obs;
  final cameraController = Rxn<CameraController>();
  late CameraDescription cameraDescription;
  XFile? imageFile;
  final imageBytes = Rxn<Uint8List>();
  final previewImagePath = "".obs;
  final isFlashOn = false.obs;
  final title = "".obs;
  final info = "".obs;
  final phoneNumber = "".obs;
  photoTypes photoType = photoTypes.ktp;
  final cameraInitialized = false.obs;

  @override
  void dispose() {
    imageBytes.value?.clear();
    cameraController.value?.dispose();
    cameraInitialized(false);
    super.dispose();
  }

  void init() async {
    imageCache.clear();
    Map<String, dynamic> args = Get.arguments;
    phoneNumber(args['mobile_phone']);
    photoType = args['type_id'] ?? photoType;
    setTitle();
    setInfo();
    await setCameraDirection();
    await checkCameraPermission();
  }

  setTitle() {
    if (photoType == photoTypes.ktp) {
      title(StringConstant.takePhotoKtp);
    } else {
      title(StringConstant.takePhotoSelfie);
    }
  }

  setInfo() {
    if (photoType == photoTypes.ktp) {
      info(StringConstant.ensureKtp);
    } else {
      info(StringConstant.ensureSelfie);
    }
  }

  setCameraDirection() async {
    cameras.value = await availableCameras();
    if (photoType == photoTypes.ktp) {
      cameraDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      cameraDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }
  }

  Future<void> _initializeCamera() async {
    isLoadingCam(true);
    cameraController.value = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await cameraController.value?.initialize();
    cameraInitialized(true);
    cameraController.value?.setFlashMode(FlashMode.off);
  }

  Future<void> checkCameraPermission() async {
    isLoadingCam(true);
    final result = await Permission.camera.request();
    if (result != PermissionStatus.granted) {
      // Tampilkan pesan jika pengguna menolak izin
      await DeasyBaseDialogs.getInstance().iconDialog(
          context: Get.context!,
          barrierDismissible: false,
          title: StringConstant.cameraPermission,
          subTitle: StringConstant.cameraPermissionInfo,
          icon: SvgPicture.asset(IconsConstant.icWarning),
          okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
          onPressButtonOk: () {
            Get.back();
          });
    }
    await _initializeCamera();
    isLoadingCam(false);
  }

  takePicture() async {
    isLoadingCam(true);
    imageFile = await cameraController.value?.takePicture();
    imageBytes.value = (await imageFile?.readAsBytes())!;
    previewImagePath.value = imageFile!.path;
    cameraController.value?.dispose();
    var args = {
      "image_url": imageBytes.value,
      "image_path": previewImagePath.value,
      "mobile_phone": phoneNumber.value,
      "type_id": photoType,
    };
    Get.toNamed(
      NewWgAdditionalDocumentsRoutes.NEWWG_ADD_DOCS_PHOTO_PREV,
      arguments: args,
    )?.whenComplete(() => init());
    isFlashOn(false);
  }

  void switchCamera() async {
    // get current lens direction (front / rear)
    final lensDirection = cameraController.value!.description.lensDirection;
    if (lensDirection == CameraLensDirection.front) {
      cameraDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      cameraDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    await _initializeCamera().whenComplete(() => isLoadingCam(false));
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    cameraController.value
        ?.setFlashMode(isFlashOn.isTrue ? FlashMode.always : FlashMode.off);
  }
}
