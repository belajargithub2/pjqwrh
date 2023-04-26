import 'package:additional_documents/src/modules/constans/strings.dart';
import 'package:additional_documents/src/modules/controller/preview_photo_controller.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';

class PhotoPreviewMobileScreen extends GetView<PreviewPhotoController> {
  const PhotoPreviewMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DeasyColor.neutral000,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: DeasyColor.neutral900,
          ),
          onPressed: () => Get.back(),
        ),
        title: DeasyTextView(
          text: controller.title.value,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => controller.isLoading.isTrue
              ? FullScreenSpinner()
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: DeasyColor.neutral900,
                          width: 2,
                        ),
                      ),
                      child: Image.memory(
                        controller.imageUrl.value!,
                        fit: BoxFit.cover,
                        height: 360.0,
                        width: 240,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DeasyTextView(
                      text: controller.info.value,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 37.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: DeasyPrimaryButton(
                              text: StringConstant.rePhoto,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textStyle: TextStyle(
                                color:
                                    AppConfig.instance.buttonTextSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              color: AppConfig.instance.buttonSecondaryColor,
                              borderColor:
                                  AppConfig.instance.buttonPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: DeasyPrimaryButton(
                              text: StringConstant.upload,
                              onPressed: () {
                                controller.uploadPhoto();
                              },
                              textStyle: TextStyle(
                                color:
                                    AppConfig.instance.buttonTextPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              color: AppConfig.instance.buttonPrimaryColor,
                              borderColor:
                                  AppConfig.instance.buttonPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
