import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'dart:typed_data';

class DialogPreviewDownloadedImageWebWidget
    extends GetView<DashboardMainController> {
  final String flag;
  final Uint8List? byte;

  DialogPreviewDownloadedImageWebWidget(this.flag, this.byte);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(DeasySizeConfigUtils.blockHorizontal!),
        backgroundColor: DeasyColor.neutral000,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          width: Get.width / 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeasyTextView(
                    text: "Preview $flag",
                    fontWeight: FontWeight.bold,
                    fontColor: DeasyColor.neutral900,
                    fontSize: DeasySizeConfigUtils.blockHorizontal! * 1.5,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                        controller.onFinishClearField();
                      },
                      icon: Icon(Icons.close, color: DeasyColor.neutral900))
                ],
              ),
              Expanded(
                  child: Center(
                      child: Container(
                          color: DeasyColor.neutral000,
                          child: Image.memory(byte!, scale: 1))))
            ],
          ),
        ));
  }
}
