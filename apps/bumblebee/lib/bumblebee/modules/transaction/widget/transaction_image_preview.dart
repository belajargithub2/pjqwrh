import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_image_preview_controller.dart';
import 'package:deasy_color/deasy_color.dart';

class TransactionImagePreview
    extends GetView<BumblebeeTransactionImagePreviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: DeasyColor.neutral900,
              ),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            'Preview ${controller.title!.toUpperCase()}',
            style: TextStyle(color: DeasyColor.neutral900),
          ),
          elevation: 0,
          backgroundColor: DeasyColor.neutral000,
        ),
        body: controller.obx(
            (state) => Container(
                  height: Get.height,
                  width: Get.width,
                  child: Image.memory(state!, scale: 3),
                ),
            onLoading: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            onEmpty: Center(
              child: Text('Tidak ada data'),
            ),
            onError: (e) => Center(
                  child: Text('Failed to load'),
                )));
  }
}
