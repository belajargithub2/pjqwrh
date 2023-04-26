import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/widgets/kmob_submission_item_upload_image_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class KMOBUploadDocumentSubmissionTabScreen
    extends GetView<BumblebeeKMOBUploadDocumentSubmissionController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      color: DeasyColor.neutral50,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _uploadDocumentWidget(),
          _spaceWidget(),
          _footerWidget(),
          _showDialogOrder(),
          _showDialogOrderSuccess()
        ],
      ),
    );
  }

  Widget _uploadDocumentWidget() {
    final double itemHeight =
        (DeasySizeConfigUtils.screenHeight! - kToolbarHeight - 24) / 3;
    final double itemWidth = DeasySizeConfigUtils.screenWidth! / 2;

    return Container(
      height: DeasySizeConfigUtils.screenHeight! / 1.45,
      padding: EdgeInsets.all(8.0),
      color: DeasyColor.neutral000,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: DeasyTextView(
              text: "Upload Dokumen",
              fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
              fontFamily: FontFamily.bold,
            ),
          ),
          CustomScrollView(
            primary: false,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: Obx(() => SliverGrid.count(
                      crossAxisSpacing: 20,
                      childAspectRatio: itemWidth /
                          (controller.successValidation.value
                              ? itemHeight + 20
                              : itemHeight),
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: controller.listUpload
                          .map((item) => KMOBSubmissionUploadImageWidget(
                                item: item,
                                checkValidation:
                                    controller.successValidation.value,
                                takeFromCamera: () {
                                  controller.onTapTakeFromCamera(item);
                                },
                                takeFromGallery: () {
                                  controller.onTapTakeFromGallery(item);
                                },
                              ))
                          .toList(),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spaceWidget() {
    return SizedBox(height: 10);
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
                text: "Kirim",
                primary: DeasyColor.kpYellow500,
                fontSize: 16,
                textColor: DeasyColor.neutral000,
                paddingButton: 15,
                borderColor: DeasyColor.kpYellow500,
                onPress: () {
                  controller.submit();
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: DeasyCustomElevatedButton(
                text: "Simpan ke Draft",
                primary: DeasyColor.neutral000,
                textColor: DeasyColor.kpYellow500,
                fontSize: 16,
                paddingButton: 15,
                borderColor: DeasyColor.kpYellow500,
                onPress: () {
                  controller.onTapDraft();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showDialogOrder() {
    controller.isShowDialogOrder.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
          title: "",
          backgroundColor: DeasyColor.neutral000,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconConstant.RESOURCES_ICON_WARNING_PATH,
              ),
              SizedBox(
                height: 20,
              ),
              DeasyTextView(
                text: "Pastikan Data Sudah\nBenar dan Tepat",
                fontColor: DeasyColor.neutral900,
                maxLines: 3,
                textAlign: TextAlign.center,
                fontSize: DeasySizeConfigUtils.blockHorizontal! * 4.7,
              ),
              SizedBox(
                height: 15,
              ),
              DeasyTextView(
                text: 'Data yang sudah dikirim tidak\ndapat diganti kembali',
                maxLines: 3,
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral400,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DeasyCustomElevatedButton(
                    text: " Kembali ",
                    textColor: DeasyColor.kpYellow500,
                    borderColor: DeasyColor.kpYellow500,
                    primary: DeasyColor.neutral000,
                    paddingButton: 12,
                    onPress: () {
                      Get.back();
                    },
                  ),
                  DeasyCustomElevatedButton(
                    text: "  Kirim  ",
                    textColor: DeasyColor.neutral000,
                    borderColor: DeasyColor.kpYellow500,
                    primary: DeasyColor.kpYellow500,
                    paddingButton: 12,
                    onPress: () {
                      Get.back();
                      controller.agentOrder(Get.context);
                    },
                  ),
                ],
              )
            ],
          ));
    });
    return SizedBox();
  }

  Widget showDialogOrderSuccess() {
    controller.isShowDialogOrderSuccess.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
          title: "",
          backgroundColor: DeasyColor.neutral000,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconConstant.RESOURCES_ICON_CHECKLIST,
              ),
              SizedBox(
                height: 25,
              ),
              DeasyTextView(
                text: ContentConstant.successOrder,
                fontColor: DeasyColor.neutral900,
                maxLines: 3,
                textAlign: TextAlign.center,
                fontSize: DeasySizeConfigUtils.blockHorizontal! * 4.7,
              ),
              SizedBox(
                height: 15,
              ),
              DeasyTextView(
                text: ContentConstant.successOrderDetail,
                maxLines: 3,
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral400,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.readSubmission,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  paddingButton: 12,
                  onPress: () {
                    Get.back();
                    controller.onTapReadSubmission();
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.backToHome,
                  textColor: DeasyColor.kpYellow500,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.neutral000,
                  paddingButton: 12,
                  onPress: () {
                    Get.back();
                    controller.navigateBack(isBackToHome: true);
                  },
                ),
              ),
            ],
          ));
    });
    return SizedBox();
  }

  Widget _showDialogOrder() {
    return Obx(() {
      if (controller.isShowDialogOrder.value) {
        return showDialogOrder();
      } else {
        return SizedBox();
      }
    });
  }

  Widget _showDialogOrderSuccess() {
    return Obx(() {
      if (controller.isShowDialogOrderSuccess.value) {
        return showDialogOrderSuccess();
      } else {
        return SizedBox();
      }
    });
  }
}
