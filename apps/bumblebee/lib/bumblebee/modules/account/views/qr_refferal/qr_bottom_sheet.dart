import 'dart:typed_data';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/qr_refferal_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class QrBottomSheet {
  final controller = Get.find<QrRefferalController>();

  showBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: Get.context!,
      builder: (context) {
        return Obx(
          () => FractionallySizedBox(
            heightFactor: 0.80,
            child: Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: DeasySizeConfigUtils.screenWidth! / 5,
                      color: DeasyColor.neutral400,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      child: Text(
                        ContentConstant.qrRefferalTitle,
                        style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller.timeHasEnded.isTrue
                        ? _timeHasEndWidget()
                        : controller.isLoading.isFalse &&
                                controller.listImage.value != null
                            ? _imageQrCode()
                            : FullScreenSpinner(),
                    controller.timeHasEnded.isFalse &&
                            controller.isLoading.isFalse
                        ? _qrCountDownWidget()
                        : SizedBox(),
                    Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      padding: EdgeInsets.all(15),
                      child: _caraPenggunaanWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imageQrCode() {
    return FadeInImage(
      width: 250,
      fit: BoxFit.fill,
      placeholder: AssetImage(
        ImageConstant.RESOURCES_IMAGE_DEASY_LOADING_ANIMATION,
      ),
      image: MemoryImage(
        Uint8List.fromList(controller.listImage.value!),
      ),
    );
  }

  Widget _timeHasEndWidget() {
    return Padding(
      padding: EdgeInsets.only(top: DeasySizeConfigUtils.blockVertical),
      child: Stack(
        children: [
          FadeInImage(
            width: 235,
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
            width: 235,
            height: 240,
            color: DeasyColor.neutral000.withOpacity(0.9),
            child: Center(
              child: Container(
                width: 35.w,
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.qrMuatUlang,
                  paddingButton: 8,
                  radius: 4,
                  fontSize: 15.sp,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  endWidget: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(Icons.refresh, color: DeasyColor.neutral000),
                  ),
                  onPress: () {
                    controller.fetchMerchantQrCode();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _qrCountDownWidget() {
    return TweenAnimationBuilder<Duration>(
      duration: Duration(seconds: controller.qrCodeTimer.value),
      tween: Tween(
        begin: Duration(seconds: controller.qrCodeTimer.value),
        end: Duration.zero,
      ),
      onEnd: () => controller.onEnd(),
      builder: (BuildContext context, Duration value, Widget? child) {
        final minutes = value.inMinutes;
        final seconds = value.inSeconds % 60;
        bool isEnd = seconds == 0 && minutes == 0 ? false : true;
        return Column(
          children: [
            Visibility(
              visible: isEnd,
              child: DeasyTextView(
                text: ContentConstant.expiredQrCode,
                fontColor: DeasyColor.neutral900,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
              ),
            ),
            Visibility(
              visible: isEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DeasyTextView(
                  text: '$minutes:$seconds',
                  fontFamily: FontFamily.medium,
                  fontColor: DeasyColor.kpYellow500,
                  fontSize: DeasySizeConfigUtils.blockVertical * 2.3,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }

  _caraPenggunaanWidget({int number = 1, int content = 20}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ContentConstant.qrHowToUse,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: number,
              child: Text('1. '),
            ),
            Expanded(
              flex: content,
              child: Text(
                ContentConstant.qrNumberOne,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Text('2.')),
            Expanded(
              flex: content,
              child: Text(
                ContentConstant.qrNumberTwo,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Text('3.')),
            Expanded(
              flex: content,
              child: Text(
                ContentConstant.qrNumberthree,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(flex: number, child: Text('4.')),
            Expanded(
              flex: content,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: DeasyColor.neutral900),
                  children: [
                    TextSpan(text: ContentConstant.qrTekanIcon),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: SvgPicture.asset(
                          '${ImageConstant.RESOURCES_ICON_QR_REFFERAL}',
                          height: 20,
                          width: 20,
                          color: DeasyColor.kpYellow500,
                        ),
                      ),
                    ),
                    TextSpan(text: ContentConstant.qrUntukScan),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Text('5.')),
            Expanded(
              flex: content,
              child: Text(ContentConstant.qrNumberFive),
            ),
          ],
        ),
      ],
    );
  }
}
