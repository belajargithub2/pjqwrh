import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_timer/deasy_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/controllers/bumblebee_email_verification_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/button_constant.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class BumblebeeEmailVerificationScreen extends GetView<BumblebeeEmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
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
                            top: DeasySizeConfigUtils.screenHeight! / 32,
                            child: Container(
                                width: DeasySizeConfigUtils.screenWidth,
                                child: Center(
                                    child: SvgPicture.asset(
                                      ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_PATH))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.19.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImageConstant.RESOURCES_IMAGE_EMAIL_VERIFICATION,
                            ),
                            SizedBox(
                              height: 4.36.h,
                            ),
                            DeasyTextView(
                              text: ContentConstant.pleaseVerifyEmail,
                              fontSize: 4.86.w,
                              fontFamily: FontFamily.medium,
                            ),
                            SizedBox(
                              height: 2.19.h,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: ContentConstant.checkEmailInbox,
                                style: TextStyle(
                                  color: DeasyColor.neutral400,
                                  fontFamily: getFontFamily(FontFamily.medium),
                                  fontSize: 3.4.w,
                                  height: 1.6
                                ),
                                children: [
                                  TextSpan(
                                    text: controller.email,
                                    style: TextStyle(
                                      color: DeasyColor.neutral900,
                                      fontFamily: getFontFamily(FontFamily.medium),
                                      fontSize: 3.4.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.78.h,
                            ),
                            DeasyTextView(
                              text: ContentConstant.hasReceiveEmail,
                              textAlign: TextAlign.center,
                              fontColor: DeasyColor.neutral400,
                              fontSize: 3.4.w,
                              fontFamily: FontFamily.medium,
                            ),
                            SizedBox(
                              height: 1.17.h,
                            ),
                            Obx(() => Container(
                              width: 70.w,
                              child: DeasyCustomElevatedButton(
                                fontSize: 3.w,
                                text: ButtonConstant.resendVerificationEmail,
                                textColor: controller.isFinished.isTrue
                                  ? DeasyColor.neutral000
                                  : DeasyColor.neutral400,
                                borderColor: controller.isFinished.isTrue
                                  ? DeasyColor.kpYellow500
                                  : DeasyColor.neutral200,
                                primary: controller.isFinished.isTrue
                                  ? DeasyColor.kpYellow500
                                  : DeasyColor.neutral200,
                                paddingButton: 10,
                                endWidget: controller.isFinished.isTrue || controller.duration.value == null
                                  ? null
                                  : DeasyMinutesTimerWidget(
                                      duration: controller.duration.value!,
                                      fontColor: DeasyColor.neutral400,
                                      fontFamily: FontFamily.light,
                                      fontSize: 3.w,
                                      onEnd: () {
                                        controller.isFinished(true);
                                      },
                                      parenthesis: true,
                                    ),
                                radius: 8,
                                onPress: () {
                                  if (controller.isFinished.isTrue) {
                                    controller.resendEmail();
                                  }
                                },
                              ),
                            )),
                            Container(
                              width: 70.w,
                              child: DeasyCustomElevatedButton(
                                text: ButtonConstant.backToLoginPage,
                                textColor: DeasyColor.kpYellow500,
                                borderColor: DeasyColor.kpYellow500,
                                primary: DeasyColor.neutral000,
                                fontSize: 3.w,
                                paddingButton: 10,
                                radius: 8,
                                onPress: () async {
                                  await controller.clearRetryCountAndTime();
                                  Get.offAllNamed(BumblebeeRoutes.LOGIN);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isLoading.value,
                    child:
                        DeasyFullScreenLoading(messageLoading: "Mohon menunggu..."),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
