import 'package:camera/camera.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class UploadPhotoCameraController extends GetxController {
  final isLoading = false.obs;
  final isCamInitialized = false.obs;
  final price = ''.obs;
  final date = ''.obs;
  final id = ''.obs;
  final flag = ''.obs;
  final cameraMessage = ''.obs;
  String? imagePath;
  CameraController? camController;
  List<CameraDescription> cameras = [];
  final isFlashOn = false.obs;
  final isNotGranted = false.obs;
  final isEmptyCustReceipt = false.obs;
  final isValidationLayoutShown = false.obs;
  final hasImei = false.obs;

  get transitionDurationDefault => Duration(milliseconds: 200);

  @override
  void onInit() {
    initCamera();
    price.value = Get.arguments['price'];
    date.value = Get.arguments['date'];
    id.value = Get.arguments['id'];
    flag.value = Get.arguments['flag'];
    isEmptyCustReceipt.value = Get.arguments['is_empty_cust_receipt'];
    hasImei.value = Get.arguments['has_imei'] ?? false;
    setCameraMessage(flag.value);
    update();
    super.onInit();
  }

  void setCameraMessage(String parameterFlag) {
    if (parameterFlag.isContainIgnoreCase("bast")) {
      cameraMessage.value = ContentConstant.bastCameraMessage;
    } else if (parameterFlag.isContainIgnoreCase("imei")) {
      cameraMessage.value = "";
    } else {
      cameraMessage.value = ContentConstant.receiptCameraMessage;
    }
  }

  Future initCamera({CameraDescription? newCameraDescription}) async {
    cameras = await availableCameras();
    if (camController != null) await camController!.dispose();
    if (newCameraDescription != null) {
      camController = CameraController(newCameraDescription, ResolutionPreset.max, enableAudio: false);
    } else {
      camController = CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    }

    camController!.addListener(() {
      if (camController!.value.hasError) {
        print('Camera Error: ${camController!.value.errorDescription}');
      }
    });

    try {
      await camController!.initialize();
      if (camController != null) {
        isCamInitialized.value = true;
        isNotGranted.value = false;
        update();
      }
    } on CameraException catch (e) {
      print(e);
      isCamInitialized.value = true;
      isNotGranted.value = true;
      update();
    }
  }

  void toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection =  camController!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    }
    else {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      isCamInitialized.value = false;
      update();
      initCamera(newCameraDescription: newDescription);
    }
    else {
      print('Asked camera not available');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<String?> captureImage() async {
    String? filePath =  await takePicture();
    if (filePath != null) {
      imagePath = filePath;
      return filePath;
    } else {
      return null;
    }
  }

  Future<String?> takePicture() async {
    XFile imageFileX;

    if (!camController!.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    if (camController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      imageFileX = await camController!.takePicture();
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    return imageFileX.path;
  }

  Future<dynamic>? gotoReview() {
    if (isFlashOn.isTrue) {
      toggleFlash();
    }

    return Get.toNamed(Routes.UPLOAD_PHOTO_REVIEW,
        arguments: {
          "price": price.value,
          "id": id.value,
          "date": date.value,
          "image": imagePath,
          "flag" : flag.value
        }
    );
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    if (isFlashOn.value) {
      camController!.setFlashMode(FlashMode.torch);
    } else {
      camController!.setFlashMode(FlashMode.off);
    }
  }
}
