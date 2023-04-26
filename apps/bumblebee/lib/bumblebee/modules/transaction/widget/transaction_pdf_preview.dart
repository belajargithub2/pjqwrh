import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_pdf_preview_controller.dart';
import 'package:deasy_color/deasy_color.dart';

class TransactionPdfPreviewPage
    extends GetView<BumblebeeTransactionPdfPreviewController> {
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
            'Preview ${Get.arguments['title']}',
            style: TextStyle(color: DeasyColor.neutral900),
          ),
          elevation: 0,
          backgroundColor: DeasyColor.neutral000,
        ),
        body: FutureBuilder(
          future: controller.loadDocument(
              type: Get.arguments['type'],
              prospectId: Get.arguments['prospectId']),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PDF(
                swipeHorizontal: true,
              ).cachedFromUrl(dataSnapshot.data.toString(),
                  maxAgeCacheObject: Duration(hours: 8),
                  headers: controller.authorizationMap);
            }
          },
        ));
  }
}
