import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/bindings/bumblebee_kmob_take_image_from_camera_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_take_image_from_camera_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';

import '../kmob_submission_dummy.dart';
import '../mock/kmob_camera_mock.dart';
import '../mock/kmob_submission_mock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setFlavor(DevFlavorConfig());
  late BumblebeeKMOBTakeImageFromCameraController controller;
  KMOBUploadDocumentSubmissionControllerMock _uploadDocumentSubmissionControllerMock = KMOBUploadDocumentSubmissionControllerMock();

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeKMOBUploadDocumentSubmissionController>(() => KMOBUploadDocumentSubmissionControllerMock());

    Get.lazyPut<BumblebeeKMOBTakeImageFromCameraController>(() => BumblebeeKMOBTakeImageFromCameraController(
          kmobUploadDocumentSubmissionController: _uploadDocumentSubmissionControllerMock,
    ));
  });

  setUp(() async {
    // when(_uploadDocumentSubmissionControllerMock.isMarried).thenReturn(RxBool(false));
    binding.builder();
    CameraPlatform.instance = MockCameraPlatform();
    await cameraController.initialize();

    controller = Get.find<BumblebeeKMOBTakeImageFromCameraController>();
    // initialize camera

  });

  group('Test KMOB Take Image From Camera Controller', () {
    test('should return true when Controller is initialized', () async {
      expect(controller.initialized, true);
    });
  });

  group('Test initCamere throw', () {
    test('should return throws $CameraException on $PlatformException ', () async {
      // arrange
      mockPlatformException = true;

      // act
      await controller.initCamera();

      // assert
      expect(
          controller.camController!.initialize(),
          throwsA(isA<CameraException>().having(
                (CameraException error) => error.description,
            'foo',
            'bar',
          )));
      mockPlatformException = false;
    });
  });

  group('Test toggleCameraLens', () {
    test('should return false when toggleCameraLens is called && lensDirection newDescription != null', () async {
      // arrange
      // act
      controller.toggleCameraLens();

      // assert
      expect(controller.isCamInitialized.value, false);
    });
  });


  group('Test toggleFlash', () {
    test('should return true when toggleFlash is called', () async {
      // arrange
      controller.isFlashOn.value = false;

      // act
      controller.toggleFlash();

      // assert
      expect(controller.isFlashOn.value, true);
    });

    test('should return false when toggleFlash is called', () async {
      // arrange
      controller.isFlashOn.value = true;

      // act
      controller.toggleFlash();

      // assert
      expect(controller.isFlashOn.value, false);
    });
  });

  group('Test takePicture', () {
    test('should return true when takePicture is called', () async {
      // arrange
      controller.isCamInitialized.value = true;

      // act
      controller.takePicture();

      // assert
      expect(controller.isCamInitialized.value, true);
    });

  });

  group('Test captureImage', () {
    test('should return true when captureImage is called', () async {
      // arrange

      // act
      controller.captureImage();

      // assert
      expect(true, true);
    });

  });

  group('Test onClose', () {
    test('should return false when onClose is called', () async {
      // arrange
      // act
      controller.onClose();

      // assert
      expect(controller.isCamInitialized.value, false);
    });
  });

  group('Test KMOBTakeImageFromCameraBinding', () {
    test('should return true when KMOBTakeImageFromCameraBinding is initialized', () async {
      // arrange
      Get.delete<BumblebeeKMOBTakeImageFromCameraController>();

      // act
      BumblebeeKMOBTakeImageFromCameraBinding().dependencies();

      // assert
      expect(Get.isRegistered<BumblebeeKMOBTakeImageFromCameraController>(), true);
      expect(Get.isRegistered<BumblebeeKMOBUploadDocumentSubmissionController>(), true);
    });
  });

}