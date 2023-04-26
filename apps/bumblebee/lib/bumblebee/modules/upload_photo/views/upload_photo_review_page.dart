import 'dart:io';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_review_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class UploadPhotoReviewPage extends GetView<UploadPhotoReviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DeasyColor.neutral000,
          title: Text(
            controller.flag.value.toLowerCase().contains("imei")
                ? 'Review Nomor ${controller.flag.value}'
                : 'Review Foto ${controller.flag.value}',
            style: TextStyle(
                color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
            onPressed: () => Get.back(result: true),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.id.value,
                              style: TextStyle(
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 1.7,
                                  color: DeasyColor.kpBlue600),
                            ),
                            Text(
                              controller.date.value,
                              style: TextStyle(
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 1.4,
                                  color: DeasyColor.neutral400),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          controller.price.value,
                          style: TextStyle(
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.9,
                              color: DeasyColor.neutral900,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 20.0),
                        Center(
                            child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                        color: DeasyColor.neutral900,
                                        width: 2)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: DeasySizeConfigUtils.isTab
                                        ? Image.file(
                                            File(controller.imagePath!),
                                            scale: 2)
                                        : Image.file(
                                            File(controller.imagePath!),
                                            scale: 3.5)))
                          ],
                        )),
                        SizedBox(height: 21.0),
                        Center(
                            child: Text(
                          controller.reviewMessage.value,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: DeasyColor.neutral900,
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.4,
                              fontWeight: FontWeight.w500),
                        )),
                        SizedBox(
                            height: DeasySizeConfigUtils.blockVertical * 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: DeasyCustomButton(
                                    text: "Lanjut",
                                    radius: 8,
                                    onPressed: () {
                                      controller.submit(context);
                                    })),
                            SizedBox(width: 16.0),
                            Expanded(
                                child: DeasyPrimaryStrokedButton(
                              text: "Foto Ulang",
                              radius: 8,
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ))
                          ],
                        ),
                      ],
                    ))),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: DeasyFullScreenLoading(
                    messageLoading: "Mohon menunggu..."))),
          ],
        ));
  }
}
