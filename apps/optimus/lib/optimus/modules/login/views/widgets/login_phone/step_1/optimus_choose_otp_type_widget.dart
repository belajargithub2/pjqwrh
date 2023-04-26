import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_one_controller.dart';

class OptimusChooseOtpTypeWidget
    extends GetView<OptimusLoginPhoneStepOneController> {
  const OptimusChooseOtpTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(
      () => Center(
        child: controller.isLoading.value
            ? FullScreenSpinner()
            : FadeInAnimation(
                delay: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.02,
                    ),
                    wordingWidget(),
                    SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.05,
                    ),
                    navigationButtonWidget(),
                    SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.02,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Column wordingWidget() {
    return Column(
      children: [
        DeasyTextView(
          text: ContentConstant.chooseOtpMethod,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: DeasySizeConfigUtils.screenHeight! * 0.03,
        ),
        DeasyTextView(
          text: ContentConstant.chooseOtpTypeWording1,
          textAlign: TextAlign.center,
          maxLines: 2,
          fontColor: DeasyColor.neutral400,
        ),
        DeasyTextView(
          text: ContentConstant.chooseOtpTypeWording2,
          textAlign: TextAlign.center,
          maxLines: 2,
          fontColor: DeasyColor.neutral400,
        ),
        Obx(
          () => DeasyTextView(
            text: controller.phoneHint.value,
            textAlign: TextAlign.center,
            maxLines: 2,
            fontColor: DeasyColor.neutral400,
          ),
        ),
      ],
    );
  }

  Column navigationButtonWidget() {
    return Column(
      children: [
        DeasyPrimaryButton(
          text: ContentConstant.sendMissedCallMethod,
          textStyle: TextStyle(color: DeasyColor.kpYellow500),
          onPressed: () {
            controller.requestOTP(ContentConstant.MISSCALLOTP);
          },
          leadIcon: Icon(
            Icons.phone,
            color: DeasyColor.kpYellow500,
          ),
          borderColor: DeasyColor.kpYellow500,
          color: DeasyColor.neutral000,
        ),
        SizedBox(
          height: DeasySizeConfigUtils.screenHeight! * 0.02,
        ),
        DeasyPrimaryButton(
          text: ContentConstant.sendSmsMethod,
          textStyle: TextStyle(color: DeasyColor.kpYellow500),
          onPressed: () {
            controller.requestOTP(ContentConstant.SMSOTP);
          },
          leadIcon: Icon(
            Icons.mail,
            color: DeasyColor.kpYellow500,
          ),
          borderColor: DeasyColor.kpYellow500,
          color: DeasyColor.neutral000,
        ),
      ],
    );
  }
}
