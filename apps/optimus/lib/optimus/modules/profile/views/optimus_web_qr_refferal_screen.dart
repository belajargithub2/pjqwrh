import 'dart:typed_data';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_web_qr_refferal_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusWebQrRefferalScreen
    extends GetView<OptimusWebQrRefferalController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(
      () => Container(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeasySizeConfigUtils.isTab || DeasySizeConfigUtils.isMobile
                ? _mobileSizeView()
                : _webSizeView(),
            const SizedBox(
              height: 32,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(color: DeasyColor.kpBlue500),
                borderRadius: BorderRadius.circular(6),
                color: DeasyColor.kpBlue50,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Image.asset(
                          IconConstant.RESOURCES_ICON_ALERT_PATH,
                          height: 24,
                          width: 24,
                          color: DeasyColor.kpBlue500,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 15)),
                      TextSpan(
                        text: ContentConstant.callCenterMessage,
                        style: TextStyle(color: DeasyColor.kpBlue500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _mobileSizeView() {
    return Column(
      children: [
        controller.timeHasEnded.isTrue
            ? _timeHasEndWidget()
            : controller.isLoading.isFalse && controller.listImage.value != null
                ? _imageQrCode()
                : _loadingWidget(),
        SizedBox(height: 16),
        controller.timeHasEnded.isFalse && controller.isLoading.isFalse
            ? _qrCountDownWidget()
            : SizedBox(),
        DottedLine(
          direction: Axis.horizontal,
          dashColor: DeasyColor.neutral400,
          dashLength: 12,
        ),
        SizedBox(height: 16),
        _howTouse(),
      ],
    );
  }

  Widget _webSizeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              controller.timeHasEnded.isTrue
                  ? _timeHasEndWidget()
                  : controller.isLoading.isFalse &&
                          controller.listImage.value != null
                      ? _imageQrCode()
                      : _loadingWidget(),
              SizedBox(height: 16),
              controller.timeHasEnded.isFalse && controller.isLoading.isFalse
                  ? _qrCountDownWidget()
                  : SizedBox()
            ],
          ),
        ),
        SizedBox(width: 30),
        SizedBox(
          height: DeasySizeConfigUtils.screenHeight! / 2,
          child: DottedLine(
            direction: Axis.vertical,
            dashColor: DeasyColor.neutral400,
            dashLength: 12,
          ),
        ),
        Expanded(child: _howTouse()),
      ],
    );
  }

  Widget _howTouse() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeasyTextView(
              text: ContentConstant.howToUse,
              fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
              fontFamily: FontFamily.medium),
          SizedBox(height: 15),
          DeasyTextView(
              text: ContentConstant.webQrHowToUse1,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              maxLines: 3),
          SizedBox(height: 16),
          DeasyTextView(
              text: ContentConstant.webQrHowToUse2,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              maxLines: 3),
          SizedBox(height: 16),
          DeasyTextView(
              text: ContentConstant.webQrHowToUse3,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              maxLines: 3),
          SizedBox(height: 16),
          Row(
            children: [
              DeasyTextView(
                text: "4. Tekan Icon ",
                maxLines: 3,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              ),
              SvgPicture.asset(
                  "${ImageConstant.RESOURCES_IMAGES_PATH}qr_code.svg"),
              Expanded(
                child: DeasyTextView(
                  text: "  untuk melakukan scan QR Code",
                  fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          DeasyTextView(
            text: ContentConstant.webQrHowToUse5,
            maxLines: 3,
            fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }

  Widget _imageQrCode() {
    return FadeInImage(
      width: 300,
      fit: BoxFit.fill,
      height: 300,
      placeholder: AssetImage(
        ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION,
      ),
      image: MemoryImage(
        Uint8List.fromList(controller.listImage.value!),
      ),
    );
  }

  Widget _loadingWidget() {
    return FullScreenSpinner();
  }

  Widget _qrCountDownWidget() {
    return Obx(
      () => Visibility(
        visible: !controller.timeHasEnded.value,
        child: TweenAnimationBuilder<Duration>(
          duration: Duration(seconds: controller.qrCodeTimer.value),
          tween: Tween(
            begin: Duration(seconds: controller.qrCodeTimer.value),
            end: Duration.zero,
          ),
          onEnd: () => controller.onEnd(),
          builder: (BuildContext context, Duration value, Widget? child) {
            final minutes = value.inMinutes;
            final seconds = value.inSeconds % 60;
            var zoomContainerSize = DeasySizeConfigUtils.isMobile
                ? 20.w
                : DeasySizeConfigUtils.isTab
                    ? 14.w
                    : 11.w;
            return Column(
              children: [
                Container(
                  width: zoomContainerSize,
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
                    endWidget: Icon(Icons.zoom_in, color: DeasyColor.kpYellow500),
                    onPress: () {
                      Get.dialog(
                          Dialog(
                            child: Image.memory(
                              Uint8List.fromList(controller.listImage.value!),
                              fit: BoxFit.contain,
                            ),
                          ),
                          routeSettings: RouteSettings());
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
          },
        ),
      ),
    );
  }

  Widget _timeHasEndWidget() {
    var reloadContainerSize = DeasySizeConfigUtils.isMobile
        ? 20.w
        : DeasySizeConfigUtils.isTab
            ? 15.w
            : 11.w;
    return Stack(
      children: [
        FadeInImage(
          width: 300,
          fit: BoxFit.fill,
          placeholder: AssetImage(
            ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION,
          ),
          image: (controller.listImage.value != null
                  ? MemoryImage(
                      Uint8List.fromList(controller.listImage.value!),
                    )
                  : AssetImage(ContentConstant.RESOURCES_DUMMY_QR))
              as ImageProvider<Object>,
        ),
        Container(
          width: 300,
          height: 305,
          color: DeasyColor.neutral000.withOpacity(0.9),
          child: Center(
            child: Container(
              width: reloadContainerSize,
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
                  child: Icon(Icons.refresh, color: DeasyColor.neutral000),
                ),
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
