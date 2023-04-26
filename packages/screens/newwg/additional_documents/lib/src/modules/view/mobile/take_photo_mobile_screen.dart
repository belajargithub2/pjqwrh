import 'package:additional_documents/src/modules/constans/icons.dart';
import 'package:additional_documents/src/modules/controller/take_photo_controller.dart';
import 'package:camera/camera.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TakePhotoMobileScreen extends GetView<TakePhotoController> {
  const TakePhotoMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              _cameraView(),
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.chevron_left),
                ),
                title: DeasyTextView(
                  text: controller.title.value,
                  fontColor: DeasyColor.neutral000,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DeasyTextView(
                      text: controller.info.value,
                      fontColor: DeasyColor.neutral000,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 34.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: DeasyColor.neutral800,
                          iconSize: 24.0,
                          onPressed: () => controller.toggleFlash(),
                          icon: controller.isFlashOn.isTrue
                              ? const Icon(Icons.flash_on)
                              : const Icon(Icons.flash_off),
                        ),
                        IconButton(
                          onPressed: () => controller.takePicture(),
                          iconSize: 50.0,
                          icon: SvgPicture.asset(
                            IconsConstant.icShutter,
                            color: DeasyColor.neutral800,
                          ),
                        ),
                        IconButton(
                          color: DeasyColor.neutral800,
                          iconSize: 24.0,
                          onPressed: () => controller.switchCamera(),
                          icon: const Icon(Icons.flip_camera_ios),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraView() {
    return Center(
      child: controller.isLoadingCam.isTrue || controller.cameraInitialized.isFalse
          ? FullScreenSpinner()
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CameraPreview(controller.cameraController.value!),
            ),
    );
  }
}
