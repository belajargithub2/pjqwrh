import 'dart:io';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_review_image_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';

class KMOBReviewImageScreen
    extends GetView<BumblebeeKMOBReviewImageController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      appBar: _appBarWidget() as PreferredSizeWidget?,
      body: _bodyWidget(),
    );
  }

  Widget _appBarWidget() {
    return AppBar(
      titleSpacing: 2,
      backgroundColor: DeasyColor.neutral000,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
        onPressed: () => Get.back(),
      ),
      title: Obx(() => DeasyTextView(
            text:
                "Review Foto ${controller.kmobUploadDocumentSubmissionController!.typeName.value}",
            maxLines: 2,
            fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
            fontFamily: FontFamily.light,
            fontColor: DeasyColor.neutral900,
          )),
    );
  }

  Widget _bodyWidget() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Stack(
            children: [
              Container(
                width: DeasySizeConfigUtils.screenWidth! / 1.3,
                height: DeasySizeConfigUtils.screenHeight! / 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        ImageConstant.RESOURCES_IMAGE_BACKGROUND_UPLOAD_IMAGE),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(
                      color: DeasyColor.neutral900, // Set border color
                      width: 2.0), // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: DeasySizeConfigUtils.screenWidth! / 1.5,
                    height: DeasySizeConfigUtils.screenHeight! / 4.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Obx(() => controller.imageFromCamera.value
                        ? _loadImageFromCamera()
                        : _loadImageFromGallery()),
                  ),
                ),
              ),
              Obx(() => controller.isSuccessUpload.value
                  ? successDialog()
                  : SizedBox())
            ],
          ),
          Spacer(),
          DeasyTextView(
            text: ContentConstant.makeSureThePhotoMustBeClear,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
            fontFamily: FontFamily.light,
            fontColor: DeasyColor.neutral900,
          ),
          Spacer(),
          _footerWidget(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _footerWidget() {
    return Container(
      color: DeasyColor.neutral000,
      width: DeasySizeConfigUtils.screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: DeasyCustomElevatedButton(
                text: "Upload",
                primary: DeasyColor.kpYellow500,
                fontSize: 16,
                textColor: DeasyColor.neutral000,
                paddingButton: 15,
                borderColor: DeasyColor.kpYellow500,
                onPress: () {
                  controller.uploadImage(Get.context);
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: DeasyCustomElevatedButton(
                text: "Foto Ulang",
                primary: DeasyColor.neutral000,
                textColor: DeasyColor.kpYellow500,
                fontSize: 16,
                paddingButton: 15,
                borderColor: DeasyColor.kpYellow500,
                onPress: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadImageFromCamera() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Transform.scale(
        scale: controller.scaleCamera.value,
        child: Center(
          child: AspectRatio(
              aspectRatio: controller.ratioCamera.value,
              child: Image.file(
                File(
                  controller.imagePath.value,
                ),
                fit: BoxFit.fitWidth,
              )),
        ),
      ),
    );
  }

  Widget _loadImageFromGallery() {
    return Image.file(
      File(
        controller.imagePath.value,
      ),
      fit: BoxFit.fill,
    );
  }

  Widget successDialog() {
    controller.isSuccessUpload.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
          title: "",
          barrierDismissible: false,
          backgroundColor: DeasyColor.neutral000,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconConstant.RESOURCES_ICON_CHECKLIST,
              ),
              SizedBox(
                height: 30,
              ),
              DeasyTextView(
                text: ContentConstant.successUpload,
                fontColor: DeasyColor.neutral900,
                maxLines: 3,
                textAlign: TextAlign.center,
                fontSize: DeasySizeConfigUtils.blockHorizontal! * 4.7,
              ),
              SizedBox(
                height: 20,
              ),
              DeasyTextView(
                text:
                    '${controller.kmobUploadDocumentSubmissionController!.typeName.value} berhasil\nter-upload',
                maxLines: 3,
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral400,
              ),
              SizedBox(
                height: 15,
              ),
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: () {
                  Get.back();
                  controller.successUpload(Get.context!);
                },
                child: Container(
                  decoration: new BoxDecoration(
                      color: DeasyColor.kpYellow500,
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0))),
                  width: DeasySizeConfigUtils.screenWidth! / 2,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      ContentConstant.upload,
                      style: TextStyle(color: DeasyColor.neutral000),
                    ),
                  )),
                ),
              )
            ],
          ));
    });
    return SizedBox();
  }
}
