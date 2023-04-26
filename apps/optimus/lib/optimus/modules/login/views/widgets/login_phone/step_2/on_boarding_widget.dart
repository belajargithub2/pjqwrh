import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/constant/image_constant.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';

class OnBoardingWidget extends GetView<OptimusLoginPhoneStepTwoController> {
  const OnBoardingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DeasyColor.neutral000,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      elevation: 2,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              verificationBannerWidget(),
              SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
              importantMessageWidget(),
              SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
              navigationButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Column verificationBannerWidget() {
    return Column(
      children: [
        DeasyTextView(
          text: ContentConstant.otpVerification,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: DeasySizeConfigUtils.screenHeight! * 0.02,
        ),
        DeasyTextView(
          text: ContentConstant.otpVerificationWording,
          textAlign: TextAlign.center,
          maxLines: 2,
          fontColor: DeasyColor.neutral400,
        ),
        SizedBox(
          height: DeasySizeConfigUtils.screenHeight! * 0.02,
        ),
        Image.asset(ImageConstant.RESOURCES_IMG_MISSED_CALL),
      ],
    );
  }

  Column importantMessageWidget() {
    return Column(
      children: [
        Align(
          child: DeasyTextView(
            text: ContentConstant.important,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.01),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: DeasyColor.kpYellow500,
            ),
            DeasyTextView(text: ContentConstant.important1)
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: DeasyColor.kpYellow500,
            ),
            DeasyTextView(text: ContentConstant.important2)
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: DeasyColor.kpYellow500,
            ),
            DeasyTextView(text: ContentConstant.important3)
          ],
        ),
      ],
    );
  }

  Column navigationButtonWidget() {
    return Column(
      children: [
        DeasyPrimaryButton(
          text: ContentConstant.callMe,
          onPressed: () {
            controller.requestCallOtp();
          },
        ),
        SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
        DeasyPrimaryButton(
          text: ButtonConstant.back,
          textStyle: TextStyle(color: DeasyColor.kpYellow500),
          color: DeasyColor.neutral000,
          borderColor: DeasyColor.kpYellow500,
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }
}
