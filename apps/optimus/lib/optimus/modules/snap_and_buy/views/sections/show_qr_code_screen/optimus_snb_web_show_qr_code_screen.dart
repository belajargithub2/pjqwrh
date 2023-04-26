import 'dart:typed_data';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_show_qr_controller.dart';

class OptimusSnbWebShowQrCodeScreen
    extends GetWidget<OptimusShowQrCodeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeasyTextView(
            text: ContentConstant.scanQrCode,
            fontSize: 14.sp,
            fontColor: DeasyColor.neutral800,
            fontFamily: FontFamily.bold,
            isSelectable: true,
          ),
          SizedBox(height: 8),
          DeasyTextView(
            text: ContentConstant.profQrCode,
            maxLines: 2,
            isSelectable: true,
            fontSize: 11.sp,
            fontColor: DeasyColor.neutral600,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 1,
            width: double.infinity,
            color: DeasyColor.kpBlue200,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Obx(() => controller.timeHasEnded.isTrue
                      ? _timeHasEndWidget()
                      : controller.isLoading.isFalse &&
                              controller.listImage.value != null
                          ? _imageQrCode()
                          : _loadingWidget()),
                  SizedBox(height: 16),
                  Obx(() => controller.listImage.value != null
                      ? _snbCountDownWidget()
                      : SizedBox()),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _imageQrCode() {
    return FadeInImage(
        width: 300,
        fit: BoxFit.fill,
        height: 300,
        placeholder:
            AssetImage(ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION),
        image: MemoryImage(Uint8List.fromList(controller.listImage.value!)));
  }

  Widget _loadingWidget() {
    return FullScreenSpinner();
  }

  Widget _snbCountDownWidget() {
    return Obx(() => Visibility(
          visible: !controller.timeHasEnded.value,
          child: TweenAnimationBuilder<Duration>(
              duration: Duration(seconds: controller.qrCodeTimer.value),
              tween: Tween(
                  begin: Duration(seconds: controller.qrCodeTimer.value),
                  end: Duration.zero),
              onEnd: () => controller.onEnd(),
              builder: (BuildContext context, Duration value, Widget? child) {
                final minutes = value.inMinutes;
                final seconds = value.inSeconds % 60;
                return Column(
                  children: [
                    Container(
                      width: 10.5.w,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: DeasyCustomElevatedButton(
                        text: ContentConstant.previewQrCode,
                        paddingButton: 0.01,
                        radius: 4,
                        fontSize: 10.sp,
                        textColor: DeasyColor.kpYellow500,
                        borderColor: DeasyColor.kpYellow500,
                        primary: DeasyColor.neutral000,
                        endWidget:
                            Icon(Icons.zoom_in, color: DeasyColor.kpYellow500),
                        onPress: () {
                          Get.dialog(
                            Dialog(
                              child: Image.memory(
                                Uint8List.fromList(controller.listImage.value!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    DeasyTextView(
                        text: ContentConstant.expiredQrCode,
                        fontColor: DeasyColor.neutral900,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: DeasyTextView(
                          text: '$minutes:$seconds',
                          fontFamily: FontFamily.medium,
                          fontColor: DeasyColor.kpYellow500,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.3),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }),
        ));
  }

  Widget _timeHasEndWidget() {
    return Stack(
      children: [
        FadeInImage(
            width: 300,
            fit: BoxFit.fill,
            height: 300,
            placeholder: AssetImage(
                ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION),
            image:
                MemoryImage(Uint8List.fromList(controller.listImage.value!))),
        Container(
          width: 300,
          height: 300,
          color: DeasyColor.neutral000.withOpacity(0.9),
          child: Center(
            child: Container(
              width: 10.w,
              child: DeasyCustomElevatedButton(
                text: "Muat Ulang",
                paddingButton: 8,
                radius: 4,
                fontSize: 11.sp,
                textColor: DeasyColor.neutral000,
                borderColor: DeasyColor.kpYellow500,
                primary: DeasyColor.kpYellow500,
                endWidget: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(Icons.refresh, color: DeasyColor.neutral000)),
                onPress: () {
                  controller.refreshQr();
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
