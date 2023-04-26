import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';

class BumblebeeKMOBTakeImageFromCameraController extends GetxController {
  final BumblebeeKMOBUploadDocumentSubmissionController? kmobUploadDocumentSubmissionController;
  BumblebeeKMOBTakeImageFromCameraController({this.kmobUploadDocumentSubmissionController});

  CameraController? camController;
  List<CameraDescription> cameras = [];
  double ratioCamera = 0.0;
  double scaleCamera = 0.0;
  String? imagePath;
  String url = "";

  final isFlashOn = false.obs;
  final isNotGranted = false.obs;
  final isCamInitialized = false.obs;

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }

  @override
  void onClose() {
    camController!.dispose();
    isCamInitialized.value = false;
    super.onClose();
  }

  Future<void> initCamera({CameraDescription? newCameraDescription}) async {
    cameras = await availableCameras();
    if (newCameraDescription != null) {
      camController = CameraController(
          newCameraDescription, ResolutionPreset.max,
          enableAudio: false);
    } else {
      camController = CameraController(cameras.first, ResolutionPreset.max, enableAudio: false);
    }

    try {
      await camController!.initialize();
      if (camController != null) {
        isCamInitialized.value = true;
        isNotGranted.value = false;
        update();
      }
    } on CameraException catch (_) {
      isCamInitialized.value = true;
      isNotGranted.value = true;
      update();
    }

    camController!.setFlashMode(FlashMode.off);
  }

  void toggleCameraLens() {
    final lensDirection = camController!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      isCamInitialized.value = false;
      update();
      initCamera(newCameraDescription: newDescription);
    }
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    if (isFlashOn.value) {
      camController!.setFlashMode(FlashMode.torch);
    } else {
      camController!.setFlashMode(FlashMode.off);
    }
  }

  Future<String?> captureImage() async {
    String? filePath =  await takePicture();

    if (filePath != null) {
      camController!.setFlashMode(FlashMode.off);
      imagePath = filePath;
      scaleCamera = camController!.value.aspectRatio + 0.6;
      ratioCamera = 1.2 / camController!.value.aspectRatio;
      return filePath;
    } else {
      return null;
    }
  }

  Future<String?> takePicture() async {
    XFile imageFileX;
    isFlashOn.value = false;
    if (!camController!.value.isInitialized) {
      return null;
    }

    if (camController!.value.isTakingPicture) {
      return null;
    }

    try {
      imageFileX = await camController!.takePicture();
    } on CameraException catch (_) {
      return null;
    }
    return imageFileX.path;
  }
}
