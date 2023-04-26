import 'package:camera/camera.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_camera_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/dialog.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class UploadPhotoCameraPage extends GetView<UploadPhotoCameraController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();

    return Obx(() {
      if (controller.isCamInitialized.value == false) {
        return AbsorbPointer(
          absorbing: true,
          child: Stack(
            alignment: Alignment.center,
            children: [SizedBox(), FullScreenSpinner()],
          ),
        );
      } else if (controller.isNotGranted.value == true) {
        return Scaffold(
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Text("Mohon izinkan akses untuk kamera"),
              SizedBox(height: 20),
              DeasyCustomButton(
                  text: "Coba Lagi",
                  onPressed: () {
                    controller.isCamInitialized.value = false;
                    controller.initCamera();
                  })
            ])));
      } else if (controller.isCamInitialized.value == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.isEmptyCustReceipt.isTrue) {
            if (DeasySizeConfigUtils.isMobile) {
              if (controller.isValidationLayoutShown.isFalse) {
                showEmptyReceiptDialog();
                controller.isValidationLayoutShown.value = true;
              }
            } else {
              if (controller.isValidationLayoutShown.isFalse) {
                showEmptyReceiptBottomSheet(context);
                controller.isValidationLayoutShown.value = true;
              }
            }
          } else {
            showInstructionDialog(context);
          }
        });
        return Container(
          child: Stack(
            children: [
              Transform.scale(
                scale: DeasySizeConfigUtils.isMobile ? 1.3 : 1.7,
                alignment: Alignment.center,
                child: CameraPreview(controller.camController!),
              ),
              Scaffold(
                  appBar: AppBar(
                    title: Text('Ambil Foto',
                        style: TextStyle(
                            color: DeasyColor.neutral000,
                            fontWeight: FontWeight.bold)),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: DeasyColor.neutral000),
                      onPressed: () => Get.back(),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  backgroundColor: Colors.transparent,
                  body: Container(
                      padding: EdgeInsets.all(
                          DeasySizeConfigUtils.blockHorizontal! * 6),
                      margin: EdgeInsets.only(
                          bottom: DeasySizeConfigUtils.blockVertical * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.cameraMessage.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: DeasyColor.neutral000,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 1.7),
                          ),
                          SizedBox(
                              height: DeasySizeConfigUtils.blockVertical * 4.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Obx(() => !controller.isFlashOn.value
                                    ? SvgPicture.asset(
                                        'resources/images/icons/ic_blitz.svg',
                                        height:
                                            DeasySizeConfigUtils.blockVertical *
                                                4,
                                        width:
                                            DeasySizeConfigUtils.blockVertical *
                                                4)
                                    : SvgPicture.asset(
                                        'resources/images/icons/ic_blitz.svg',
                                        height:
                                            DeasySizeConfigUtils.blockVertical *
                                                4,
                                        width:
                                            DeasySizeConfigUtils.blockVertical *
                                                4,
                                        color: HexColor("#01A3DE"),
                                      )),
                                onTap: () => controller.toggleFlash(),
                              ),
                              InkWell(
                                child: SvgPicture.asset(
                                    'resources/images/icons/ic_shutter_button.svg',
                                    height:
                                        DeasySizeConfigUtils.blockVertical * 8,
                                    width:
                                        DeasySizeConfigUtils.blockVertical * 8),
                                onTap: () {
                                  controller.captureImage().then((image) {
                                    if (image != null) {
                                      controller.gotoReview()!.then((result) {
                                        if (result != null) {
                                          showInstructionDialog(context);
                                        }
                                      });
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                  child: SvgPicture.asset(
                                      'resources/images/icons/ic_switch_cam.svg',
                                      height:
                                          DeasySizeConfigUtils.blockVertical *
                                              3,
                                      width:
                                          DeasySizeConfigUtils.blockVertical *
                                              3),
                                  onTap: () {
                                    controller.toggleCameraLens();
                                  })
                            ],
                          )
                        ],
                      ))),
            ],
          ),
        );
      } else {
        return Scaffold(
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Text("Mohon izinkan akses untuk kamera"),
              SizedBox(height: 20),
              DeasyCustomButton(
                  text: "Coba Lagi",
                  onPressed: () {
                    controller.isCamInitialized.value = false;
                    controller.initCamera();
                  })
            ])));
      }
    });
  }

  Future<dynamic> showEmptyReceiptBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight! / 4,
            margin: EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'resources/images/icons/ic_dialog_ecommerce.svg'),
                SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.03),
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: Text(
                      "Maaf, Kamu Belum Mengupload Bukti Terima",
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 2),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.03,
                ),
                Text(
                  'Upload Bukti Terima dahulu sebelum mengupload BAST',
                  style: TextStyle(
                      color: DeasyColor.neutral400,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.7),
                ),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DeasyPrimaryStrokedButton(
                        text: "Kembali ke List",
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                        width: DeasySizeConfigUtils.blockHorizontal! * 1.7),
                    Expanded(
                      child: DeasyPrimaryButton(
                        text: "Upload Bukti Terima",
                        onPressed: () {
                          controller.flag.value = "Bukti Terima";
                          Get.back();
                          showInstructionBuktiTerimaDialog(Get.context!);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> showEmptyReceiptDialog() {
    return Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: DeasyColor.neutral000,
        title: "",
        content: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DeasySizeConfigUtils.blockHorizontal! * 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'resources/images/icons/ic_failed_generate.svg'),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                DeasyTextView(
                  textAlign: TextAlign.center,
                  text: "Maaf, Kamu Belum Mengupload Bukti Terima",
                  maxLines: 3,
                  fontSize: DeasySizeConfigUtils.blockHorizontal! * 5.35,
                  fontColor: DeasyColor.neutral900,
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
                DeasyTextView(
                    text: "Upload Bukti Terima dahulu sebelum mengupload BAST",
                    fontSize: DeasySizeConfigUtils.blockHorizontal! * 3.9,
                    fontColor: DeasyColor.neutral400,
                    textAlign: TextAlign.center,
                    maxLines: 5),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: DeasyCustomButton(
                      text: "Ambil Foto Bukti Terima",
                      radius: 8,
                      onPressed: () {
                        controller.flag.value = "bukti terima";
                        Get.back();
                        showInstructionBuktiTerimaDialog(Get.context!);
                      }),
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 2),
                ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: double.infinity),
                    child: DeasyPrimaryStrokedButton(
                      text: "Kembali ke List",
                      radius: 8,
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                    )),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
              ],
            )));
  }

  void showInstructionDialog(BuildContext context) {
    if (controller.hasImei.isTrue) {
      showInstructionImeiDialog(context);
    } else {
      showInstructionBuktiTerimaDialog(context);
    }
  }

  showInstructionBuktiTerimaDialog(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder:
            (context, Animation<double> a1, Animation<double> a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: DialogUtil.dialogBuktiTerimaCamera(
                  context: context,
                  onButtonPress: () {
                    Get.back();
                  }),
            ),
          );
        },
        transitionDuration: controller.transitionDurationDefault,
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
  }

  showInstructionImeiDialog(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder:
            (context, Animation<double> a1, Animation<double> a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: DialogUtil.dialogImeiCamera(
                  context: context,
                  onButtonPress: () {
                    Get.back();
                  }),
            ),
          );
        },
        transitionDuration: controller.transitionDurationDefault,
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
  }
}
