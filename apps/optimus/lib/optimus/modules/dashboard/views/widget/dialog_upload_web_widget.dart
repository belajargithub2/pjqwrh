import 'package:camera/camera.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/model/transaction_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class DialogUploadWebWidget extends GetView<DashboardMainController> {
  final TransactionResponseData transaction;
  final String? prospectId;
  final String flag;

  DialogUploadWebWidget(this.transaction, this.prospectId, this.flag);

  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: dialogBody()),
          if (controller.isUploading.isTrue)
            AbsorbPointer(child: FullScreenSpinner())
        ],
      ),
    );
  }

  Widget dialogBody() {
    switch (controller.uploadStep.value) {
      case EnumUploadStep.init:
        return dialogInitWidget();
      case EnumUploadStep.instruction:
        return dialogInstructionWidget();
      case EnumUploadStep.takePhoto:
        return dialogTakePhotoWidget();
      case EnumUploadStep.preview:
        return dialogPreviewWidget();
      case EnumUploadStep.confirm:
        return dialogConfirmWidget();
      case EnumUploadStep.errorUpload:
        return dialogErrorWidget();
      case EnumUploadStep.uploaded:
        return dialogUploadedWidget();
      default:
        return dialogInitWidget();
    }
  }

  Widget dialogInstructionWidget() {
    return Container(
      width: 500,
      height: 405,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.0),
          DeasyTextView(
            text: flag.isContainIgnoreCase(ContentConstant.NOMOR_IMEI)
                ? "Upload ${ContentConstant.IMEI}"
                : "Upload $flag",
            fontSize: 20.0,
            fontFamily: FontFamily.bold,
          ),
          SizedBox(height: 25.0),
          SvgPicture.asset(flag.isContainIgnoreCase(ContentConstant.NOMOR_IMEI)
              ? ImageConstant.RESOURCES_IMAGE_IMEI_INSTRUCTOR_IMAGE
              : ImageConstant.RESOURCES_IMAGE_BUKTI_TERIMA_INSTRUCTOR_IMAGE),
          SizedBox(height: 25.0),
          DeasyTextView(
              text: flag.isContainIgnoreCase(ContentConstant.NOMOR_IMEI)
                  ? ContentConstant.takeImageImeiFromLabel.replaceAll("\n", " ")
                  : ContentConstant.takeImageBuktiTerimaLabel
                      .replaceAll("\n", " "),
              fontSize: 14.0,
              fontColor: DeasyColor.kpBlue600,
              fontFamily: FontFamily.medium,
              textAlign: TextAlign.center,
              maxLines: 3),
          SizedBox(height: 25.0),
          DeasyPrimaryButton(
              text: ButtonConstant.ok,
              width: 90.0,
              onPressed: () {
                controller.activateCamera();
              })
        ],
      ),
    );
  }

  Widget dialogInitWidget() {
    return Container(
      width: 500,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.0),
          Center(
              child: DeasyTextView(
            text: "Upload $flag",
            fontSize: 20.0,
            fontFamily: FontFamily.bold,
          )),
          SizedBox(height: 24.0),
          Center(
            child: DeasyTextView(
              text: controller.getDialogHeaderText(flag),
              fontSize: 14.0,
              fontColor: DeasyColor.neutral400,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: DeasyColor.neutral100),
            child: DottedBorder(
                borderType: BorderType.RRect,
                color: controller.highlight.isTrue
                    ? DeasyColor.dms2ED477
                    : DeasyColor.semanticInfo300,
                strokeWidth: controller.highlight.isTrue ? 5 : 1,
                radius: Radius.circular(8.0),
                dashPattern: controller.highlight.isTrue ? [1] : [9],
                child: flag.isContainIgnoreCase(ContentConstant.BAST)
                    ? InkWell(
                        onTap: () {
                          controller.chooseFileIP();
                        },
                        child: Stack(
                          children: [
                            DropzoneView(
                                onCreated: (dropZoneController) => controller
                                    .dropZoneController = dropZoneController,
                                onHover: () {
                                  controller.highlight.value = true;
                                },
                                onLeave: () {
                                  controller.highlight.value = false;
                                },
                                onDrop: (ev) {
                                  controller.onDropFile(ev);
                                }),
                            dialogInitContent()
                          ],
                        ))
                    : dialogInitContent()),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget dialogInitContent() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        flag.isContainIgnoreCase(ContentConstant.BAST)
            ? SvgPicture.asset(
                "${IconConstant.RESOURCES_ICON_PATH}ic_upload_photo.svg")
            : SvgPicture.asset(
                "${IconConstant.RESOURCES_ICON_PATH}ic_photo.svg"),
        SizedBox(height: 15.0),
        flag.isContainIgnoreCase(ContentConstant.BAST)
            ? DeasyTextView(
                text: ContentConstant.dropFileHere,
                fontColor: DeasyColor.neutral400,
                fontSize: 14.0,
              )
            : DeasyPrimaryStrokedButton(
                text: ContentConstant.takeImageFromCamera,
                onPressed: () {
                  controller.showInstructionDialog();
                },
                backgroundColor: Colors.transparent,
                color: DeasyColor.kpBlue500,
                width: 200,
                textStyle: TextStyle(color: DeasyColor.kpBlue500),
              )
      ],
    ));
  }

  Widget dialogTakePhotoWidget() {
    if (DeasySizeConfigUtils.isTab || DeasySizeConfigUtils.isMobile) {
      return takePhotoMobileWidget();
    } else {
      return takePhotoDesktopWidget();
    }
  }

  Widget takePhotoMobileWidget() {
    return Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18.0),
            Center(
                child: DeasyTextView(
              text: ContentConstant.takeImageFromCamera,
              fontSize: 20.0,
              fontFamily: FontFamily.bold,
            )),
            SizedBox(height: 24.0),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: DeasyColor.neutral100),
                  child: takePhotoContainerWidget()),
            ),
            SizedBox(height: 24.0),
            controller.previewImagePath.isEmpty
                ? DeasyPrimaryButton(
                    text: ContentConstant.photo,
                    suffixIcon:
                        Icon(Icons.camera_alt, color: DeasyColor.neutral000),
                    onPressed: () async {
                      await controller.takePhoto();
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DeasyPrimaryStrokedButton(
                          text: ContentConstant.retakePhoto,
                          width: controller.drawerBodyWidth / 3,
                          onPressed: () {
                            controller.showInstructionDialog();
                          }),
                      SizedBox(width: 18.0),
                      DeasyPrimaryButton(
                          text: ContentConstant.continueUpload,
                          width: controller.drawerBodyWidth / 3,
                          onPressed: () {
                            controller.showPreviewDialog();
                          }),
                    ],
                  ),
            SizedBox(height: 18.0),
          ],
        ));
  }

  Widget takePhotoDesktopWidget() {
    return Container(
        width: 500,
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18.0),
            Center(
                child: DeasyTextView(
              text: ContentConstant.takeImageFromCamera,
              fontSize: 20.0,
              fontFamily: FontFamily.bold,
            )),
            SizedBox(height: 24.0),
            Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: DeasyColor.neutral100),
                child: takePhotoContainerWidget()),
            SizedBox(height: 24.0),
            controller.previewImagePath.isEmpty
                ? DeasyPrimaryButton(
                    width: controller.drawerBodyWidth / 100 * 11,
                    text: ContentConstant.photo,
                    suffixIcon:
                        Icon(Icons.camera_alt, color: DeasyColor.neutral000),
                    onPressed: () async {
                      controller.imageFile = await controller
                          .cameraController.value!
                          .takePicture();
                      controller.imageBytes =
                          await controller.imageFile!.readAsBytes();
                      controller.previewImagePath.value =
                          controller.imageFile!.path;
                      await controller.cameraController.value!.dispose();
                      controller.isInitialized(false);
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DeasyPrimaryStrokedButton(
                          text: ContentConstant.retakePhoto,
                          width: 150,
                          onPressed: () {
                            controller.showInstructionDialog();
                          }),
                      SizedBox(width: 18.0),
                      DeasyPrimaryButton(
                          text: ContentConstant.continueUpload,
                          width: 150,
                          onPressed: () {
                            controller.showPreviewDialog();
                          }),
                    ],
                  ),
            SizedBox(height: 18.0),
          ],
        ));
  }

  Widget dialogPreviewWidget() {
    if (DeasySizeConfigUtils.isTab || DeasySizeConfigUtils.isMobile) {
      return previewPhotoMobileWidget();
    } else {
      return previewPhotoDesktopWidget();
    }
  }

  Widget previewPhotoMobileWidget() {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.0),
          Center(
              child: DeasyTextView(
            text: "Upload $flag",
            fontSize: 20.0,
            fontFamily: FontFamily.bold,
          )),
          SizedBox(height: 24.0),
          Center(
            child: DeasyTextView(
              text: controller.getDialogHeaderText(flag),
              fontSize: 14.0,
              fontColor: DeasyColor.neutral400,
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: DeasyColor.neutral100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(controller.imageBytes, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(IconConstant.RESOURCES_ICON_EXCLAMATION),
              SizedBox(width: 12),
              Expanded(
                  child: Text(
                "$flag tidak dapat diubah setelah ter-upload",
                style: TextStyle(color: DeasyColor.transactionIncomingColor),
                maxLines: 3,
              ))
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeasyPrimaryStrokedButton(
                  text: ContentConstant.reuploadPhoto,
                  width: controller.drawerBodyWidth / 3,
                  onPressed: () {
                    controller.showInstructionDialog();
                  }),
              SizedBox(width: 18.0),
              DeasyPrimaryButton(
                  text: ContentConstant.uploadButton,
                  width: controller.drawerBodyWidth / 3,
                  onPressed: () {
                    controller.showConfirmDialog();
                  }),
            ],
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget previewPhotoDesktopWidget() {
    return Container(
      width: 500,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.0),
          Center(
              child: DeasyTextView(
            text: "Upload $flag",
            fontSize: 20.0,
            fontFamily: FontFamily.bold,
          )),
          SizedBox(height: 24.0),
          Center(
            child: DeasyTextView(
              text: controller.getDialogHeaderText(flag),
              fontSize: 14.0,
              fontColor: DeasyColor.neutral400,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.0),
          Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: DeasyColor.neutral100),
              child: Transform.scale(
                scale: 1,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(controller.imageBytes, fit: BoxFit.cover),
                ),
              )),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(IconConstant.RESOURCES_ICON_EXCLAMATION),
              SizedBox(width: 12),
              Text("$flag tidak dapat diubah setelah ter-upload",
                  style: TextStyle(color: DeasyColor.transactionIncomingColor))
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeasyPrimaryStrokedButton(
                  text: ContentConstant.reuploadPhoto,
                  width: 150,
                  onPressed: () {
                    controller.showInstructionDialog();
                  }),
              SizedBox(width: 18.0),
              DeasyPrimaryButton(
                  text: ContentConstant.uploadButton,
                  width: 150,
                  onPressed: () {
                    controller.showConfirmDialog();
                  }),
            ],
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget dialogConfirmWidget() {
    return Container(
      width: 500,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.0),
          SvgPicture.asset(IconConstant.RESOURCES_ICON_DIALOG_ECOMMERCE),
          SizedBox(height: 32.0),
          DeasyTextView(
            text: ContentConstant.uploadPhotoConfirmation,
            fontSize: 18.0,
            fontColor: Colors.black,
            fontWeight: FontWeight.w500,
            maxLines: 2,
          ),
          SizedBox(height: 24.0),
          DeasyTextView(
              text: ContentConstant.makeSureImage,
              fontSize: 14.0,
              fontColor: DeasyColor.neutral400,
              textAlign: TextAlign.center,
              maxLines: 5),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: DeasyCustomButton(
                      text: ContentConstant.uploadButton,
                      radius: 8.0,
                      onPressed: () {
                        controller.uploadSelectedFile(prospectId, flag);
                      })),
              SizedBox(width: 12.0),
              Expanded(
                  child: DeasyPrimaryStrokedButton(
                text: ButtonConstant.back,
                radius: 8.0,
                onPressed: () {
                  controller.showPreviewDialog();
                },
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget dialogErrorWidget() {
    return Container(
      width: 350,
      height: 300,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.0),
          SvgPicture.asset(IconConstant.RESOURCES_ICON_FAILED),
          SizedBox(height: 25.0),
          DeasyTextView(
              text: DialogConstant.titleNeedVerification,
              fontSize: 14.0,
              fontColor: DeasyColor.neutral900,
              fontFamily: FontFamily.medium,
              textAlign: TextAlign.center,
              maxLines: 3),
          SizedBox(height: 25.0),
          DeasyTextView(
              text: controller.uploadErrorMessage.value,
              fontSize: 14.0,
              fontColor: DeasyColor.neutral400,
              fontFamily: FontFamily.light,
              textAlign: TextAlign.center,
              maxLines: 3),
          SizedBox(height: 25.0),
          DeasyPrimaryButton(
              text: ButtonConstant.ok,
              width: 90.0,
              onPressed: () {
                Get.back();
              })
        ],
      ),
    );
  }

  Widget dialogUploadedWidget() {
    return Container(
      width: 400,
      height: (DeasySizeConfigUtils.isMobile || DeasySizeConfigUtils.isTab)
          ? 300
          : 350,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "${ImageConstant.RESOURCES_IMAGES_PATH}img_success_upload.svg",
            width: (DeasySizeConfigUtils.isMobile || DeasySizeConfigUtils.isTab)
                ? 200
                : 250,
            height:
                (DeasySizeConfigUtils.isMobile || DeasySizeConfigUtils.isTab)
                    ? 200
                    : 250,
          ),
          DeasyTextView(
              text: flag.isContainIgnoreCase(ContentConstant.NOMOR_IMEI)
                  ? "${ContentConstant.IMEI} Berhasil di Upload"
                  : "$flag Berhasil di Upload",
              fontSize:
                  (DeasySizeConfigUtils.isMobile || DeasySizeConfigUtils.isTab)
                      ? DeasySizeConfigUtils.blockHorizontal! * 4.5
                      : DeasySizeConfigUtils.blockHorizontal,
              fontFamily: FontFamily.medium),
          SizedBox(height: 25.0),
          DeasyPrimaryButton(
              text: ContentConstant.refillForm,
              width: double.infinity,
              onPressed: () {
                Get.back();
                controller.fetchApiAllOrdersByPage(
                    page: controller.transactionResponse.value.pageInfo!.page);
                controller.onFinishClearField();
              })
        ],
      ),
    );
  }

  takePhotoContainerWidget() {
    var isMobile =
        (DeasySizeConfigUtils.isMobile || DeasySizeConfigUtils.isTab);

    if (isMobile || controller.browserType!.isContainIgnoreCase("safari")) {
      return cameraPreviewWidget();
    }

    if (!isMobile && !controller.browserType!.isContainIgnoreCase("safari")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Transform.scale(
            scale: 1,
            alignment: Alignment.center,
            child: cameraPreviewWidget()),
      );
    }
  }

  cameraPreviewWidget() {
    if (controller.previewImagePath.isEmpty) {
      return cameraWidget();
    } else {
      return Image.memory(controller.imageBytes, fit: BoxFit.cover);
    }
  }

  cameraWidget() {
    if (controller.isLoadingCam.isTrue) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.cameras.isEmpty) {
      return Container(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: DeasyTextView(
              text: ContentConstant.cameraAccessNotAllowed,
              fontFamily: FontFamily.light,
              fontColor: DeasyColor.neutral400,
              fontSize: 12.0,
              lineHeight: 1.7,
              maxLines: 7,
              textAlign: TextAlign.center,
            ),
          ));
    }

    if (controller.error.isNotEmpty) {
      return Container(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: DeasyTextView(
              text: "Error: ${controller.error}",
              fontFamily: FontFamily.light,
              fontColor: DeasyColor.neutral400,
              fontSize: 12.0,
              lineHeight: 1.7,
              maxLines: 7,
              textAlign: TextAlign.center,
            ),
          ));
    }

    if (controller.cameraController.value != null &&
        controller.isInitialized.isTrue) {
      return CameraPreview(controller.cameraController.value!);
    }
  }
}
