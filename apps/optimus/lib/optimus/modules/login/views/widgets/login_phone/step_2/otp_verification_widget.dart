import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_2/optimus_otp_input_widget.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OtpVerificationWidget
    extends GetView<OptimusLoginPhoneStepTwoController> {
  const OtpVerificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Card(
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
                    wordingWidget(),
                    SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
                    otpInputWidget(),
                    timerCountDownWidget(),
                    SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
                    resendButtonWidget()
                  ],
                ),
              ),
            ),
          ),
          if (controller.isLoading.isTrue) FullScreenSpinner(),
        ],
      ),
    );
  }

  Widget resendButtonWidget() {
    return Obx(() => Column(
          children: [
            DeasyTextView(
              text: ContentConstant.otpNotReceive,
              fontColor: DeasyColor.neutral400,
            ),
            SizedBox(height: 5),
            DeasyPrimaryButton(
              text: ContentConstant.resendOtpCode,
              textStyle: TextStyle(
                color: controller.canRequestOTP.value
                    ? DeasyColor.neutral000
                    : DeasyColor.neutral400,
              ),
              color: controller.canRequestOTP.value
                  ? DeasyColor.kpYellow500
                  : DeasyColor.neutral50,
              borderColor: controller.canRequestOTP.value
                  ? DeasyColor.kpYellow500
                  : DeasyColor.neutral50,
              onPressed: () {
                controller.canRequestOTP.value ? controller.requestOTP() : null;
              },
            ),
          ],
        ));
  }

  Column otpInputWidget() {
    return Column(
      children: [
        SizedBox(
          width: DeasySizeConfigUtils.isDesktopOrWeb
              ? DeasySizeConfigUtils.screenWidth! * 0.2
              : DeasySizeConfigUtils.screenWidth! * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OptimusOtpInputWidget(
                controller.fieldOne,
                controller.focusNodeOne,
                true,
                0,
              ),
              OptimusOtpInputWidget(
                controller.fieldTwo,
                controller.focusNodeTwo,
                false,
                1,
              ),
              OptimusOtpInputWidget(
                controller.fieldThree,
                controller.focusNodeThree,
                false,
                2,
              ),
              OptimusOtpInputWidget(
                controller.fieldFour,
                controller.focusNodeFour,
                false,
                3,
              ),
              OptimusOtpInputWidget(
                controller.fieldFive,
                controller.focusNodeFive,
                false,
                4,
              ),
              OptimusOtpInputWidget(
                controller.fieldSix,
                controller.focusNodeSix,
                false,
                5,
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget timerCountDownWidget() {
    return Obx(() => Visibility(
          visible: !controller.canRequestOTP.value,
          child: TweenAnimationBuilder<Duration>(
            duration: controller.otpTimer.value,
            tween: Tween(
              begin: controller.otpTimer.value,
              end: Duration.zero,
            ),
            onEnd: () {
              controller.canRequestOTP(true);
              DeasyPocket().removeOtpTimer();
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DeasyTextView(
                  text: '$minutes:$seconds',
                  fontFamily: FontFamily.medium,
                  fontColor: DeasyColor.neutral400,
                  fontSize: DeasySizeConfigUtils.blockVertical * 2,
                ),
              );
            },
          ),
        ));
  }

  Column wordingWidget() {
    return Column(
      children: [
        DeasyTextView(
          text: ContentConstant.otpVerification,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
        if (controller.requestOtpType.value == ContentConstant.MISSCALLOTP)
          DeasyTextView(
            text: ContentConstant.otpMissedCallInputWording,
            fontColor: DeasyColor.neutral400,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        if (controller.requestOtpType.value == ContentConstant.SMSOTP)
          Column(
            children: [
              DeasyTextView(
                text: ContentConstant.otpSmsInputWording,
                fontColor: DeasyColor.neutral400,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              DeasyTextView(
                text: controller.phoneHint.value,
                fontColor: DeasyColor.neutral400,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DeasyTextView(
              text: ContentConstant.phoneNumberWrong,
              fontColor: DeasyColor.neutral400,
            ),
            InkWell(
              child: DeasyTextView(
                text: ContentConstant.relogin,
                fontColor: DeasyColor.kpYellow500,
              ),
              onTap: (() {
                Get.offAllNamed(OptimusRoutes.LOGIN);
              }),
            )
          ],
        ),
      ],
    );
  }
}
