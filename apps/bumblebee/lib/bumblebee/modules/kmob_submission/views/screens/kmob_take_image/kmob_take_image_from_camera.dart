import 'package:camera/camera.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_take_image_from_camera_controller.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class KMOBTakeImageFromCameraScreen
    extends GetView<BumblebeeKMOBTakeImageFromCameraController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    if (controller.isNotGranted.value == true) {
      requestPermissionWidget();
    }
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget requestPermissionWidget() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ContentConstant.cameraPemission),
            SizedBox(height: 20),
            DeasyCustomButton(
                text: ContentConstant.tryAgain,
                onPressed: () {
                  controller.isCamInitialized.value = false;
                  controller.initCamera();
                }),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            ImageConstant.RESOURCES_IMAGE_BACKGROUND_UPLOAD_IMAGE,
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight,
            fit: BoxFit.fill,
          ),
          Container(
            width: DeasySizeConfigUtils.screenWidth,
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: DeasyColor.neutral000,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(Get.context!, {
                      "url": controller.url,
                      "typeName": controller
                          .kmobUploadDocumentSubmissionController!
                          .typeName
                          .value
                    });
                  },
                ),
                DeasyTextView(
                  text:
                      "Ambil Foto ${controller.kmobUploadDocumentSubmissionController!.typeName.value}",
                  fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
                  fontFamily: FontFamily.medium,
                  fontColor: DeasyColor.neutral000,
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: DeasySizeConfigUtils.screenWidth! - 50,
                height: DeasySizeConfigUtils.screenHeight! / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Obx(() {
                  if (controller.isCamInitialized.isFalse) {
                    return Scaffold(
                      body: AbsorbPointer(
                        absorbing: true,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [SizedBox(), FullScreenSpinner()],
                        ),
                      ),
                    );
                  } else {
                    return AspectRatio(
                      aspectRatio: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Transform.scale(
                          scale:
                              controller.camController!.value.aspectRatio + 0.8,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1 /
                                  controller.camController!.value.aspectRatio,
                              child: CameraPreview(controller.camController!),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: DeasyTextView(
                    text: ContentConstant.makeSureThePhotoMustBeClear,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
                    fontFamily: FontFamily.medium,
                    fontColor: DeasyColor.neutral000,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Obx(() => controller.isFlashOn.value
                          ? SvgPicture.asset(
                              IconConstant.RESOURCES_ICON_FLASH_CAMERA,
                              height: DeasySizeConfigUtils.blockVertical * 4,
                              color: DeasyColor.kpBlue600,
                              width: DeasySizeConfigUtils.blockVertical * 4)
                          : SvgPicture.asset(
                              IconConstant.RESOURCES_ICON_FLASH_CAMERA,
                              height: DeasySizeConfigUtils.blockVertical * 4,
                              width: DeasySizeConfigUtils.blockVertical * 4,
                            )),
                      onTap: () => controller.toggleFlash(),
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                          IconConstant.RESOURCES_ICON_SHUTTER_BUTTON_CAMERA,
                          height: DeasySizeConfigUtils.blockVertical * 8,
                          width: DeasySizeConfigUtils.blockVertical * 8),
                      onTap: () {
                        controller.captureImage().then((value) {
                          if (value != null) {
                            Get.toNamed(Routes.KMOB_SUBMISSION_REVIEW_IMAGE,
                                    arguments: {
                                  "imagePath": controller.imagePath,
                                  "scaleCamera": controller.scaleCamera,
                                  "ratioCamera": controller.ratioCamera,
                                  "imageFromCamera": true
                                })!
                                .then((value) {
                              if (value != null) {
                                Navigator.pop(Get.context!, {
                                  "imagePath": value["imagePath"],
                                  "imageUrl": value["imageUrl"],
                                  "typeName": value["typeName"],
                                });
                              }
                            });
                          }
                        });
                      },
                    ),
                    InkWell(
                        child: SvgPicture.asset(
                            IconConstant.RESOURCES_ICON_SWITCH_CAMERA,
                            height: DeasySizeConfigUtils.blockVertical * 3,
                            width: DeasySizeConfigUtils.blockVertical * 3),
                        onTap: () => controller.toggleCameraLens())
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
