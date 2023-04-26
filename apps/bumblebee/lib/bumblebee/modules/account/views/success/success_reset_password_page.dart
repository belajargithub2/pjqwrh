import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class SuccessResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      child: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(
              ImageConstant.RESOURCES_IMAGE_WAVE_ONE_PATH,
              width: DeasySizeConfigUtils.screenWidth,
              fit: BoxFit.fill,
            ),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(
              ImageConstant.RESOURCES_IMAGE_WAVE_TWO_PATH,
              width: DeasySizeConfigUtils.screenWidth,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: DeasySizeConfigUtils.screenHeight! * 0.03,
            child: Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Center(
                    child: SvgPicture.asset(
                        ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_PATH))),
          ),
          Positioned(
            top: DeasySizeConfigUtils.screenHeight! / 4.5,
            child: Container(
              width: DeasySizeConfigUtils.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DeasyTextView(
                    text: ContentConstant.successUpdatePassword,
                    textAlign: TextAlign.center,
                    fontSize: DeasySizeConfigUtils.blockVertical * 2,
                    fontFamily: FontFamily.medium,
                    fontColor: DeasyColor.neutral900,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      ImageConstant.RESOURCES_IMAGE_CONFIRM_PATH,
                      width: DeasySizeConfigUtils.screenWidth! * 1.2,
                      height: DeasySizeConfigUtils.screenHeight! / 3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: DeasySizeConfigUtils.screenHeight! / 14,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              )),
          Positioned(
            bottom: 60,
            left: 25,
            right: 25,
            child: DeasyCustomElevatedButton(
              text: ContentConstant.backToProfile,
              textColor: DeasyColor.neutral000,
              fontSize: 15,
              borderColor: DeasyColor.kpYellow500,
              primary: DeasyColor.kpYellow500,
              onPress: () => Get.back(),
            ),
          )
        ],
      ),
    );
  }
}
