import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/image_constant.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_2/on_boarding_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_2/otp_verification_widget.dart';

class OptimusRequestOtpContainerWidget
    extends GetView<OptimusLoginPhoneStepTwoController> {
  const OptimusRequestOtpContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      margin: DeasySizeConfigUtils.isMobile
          ? EdgeInsets.symmetric(horizontal: 2)
          : EdgeInsets.symmetric(
              horizontal: DeasySizeConfigUtils.isTab ? 50 : 150),
      height: DeasySizeConfigUtils.screenHeight,
      child: Column(
        mainAxisAlignment: DeasySizeConfigUtils.isMobile
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeasySizeConfigUtils.isMobile
              ? SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.05,
                )
              : SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.08,
                ),
          Image.asset(ImageConstant.RESOURCES_IMAGE_KP_LOGO),
          Obx(
            () => Stack(
              children: [
                Visibility(
                  visible: controller.isOnBoardingShow.value,
                  child: FadeInAnimation(
                    delay: 1,
                    child: OnBoardingWidget(),
                  ),
                ),
                Visibility(
                  visible: !controller.isOnBoardingShow.value,
                  child: FadeInAnimation(
                    delay: 1,
                    child: OtpVerificationWidget(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.07),
        ],
      ),
    );
  }
}
