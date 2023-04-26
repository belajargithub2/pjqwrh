import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_timer/deasy_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_website/core/constant/button_constant.dart';
import 'package:kreditplus_deasy_website/core/constant/content_constant.dart';
import 'package:kreditplus_deasy_website/core/constant/image_constant.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/controllers/optimus_email_verification_controller.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusEmailVerificationCard extends GetView<OptimusEmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
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
            fontSize: 1.39.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 1.63.h,
          ),
          DeasyTextView(
            text: ContentConstant.checkEmailInbox1,
            fontColor: DeasyColor.neutral500,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 0.58.h,
          ),
          DeasyTextView(
            text: ContentConstant.checkEmailInbox2,
            fontColor: DeasyColor.neutral500,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 0.58.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeasyTextView(
                text: ContentConstant.checkEmailInbox3,
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral500,
                fontSize: 0.97.w,
                fontFamily: FontFamily.medium,
              ),
              SizedBox(
                width: 0.3.w,
              ),
              DeasyTextView(
                text: controller.email,
                fontSize: 0.97.w,
                fontFamily: FontFamily.medium,
              ),
            ],
          ),
          SizedBox(
            height: 4.36.h,
          ),
          DeasyTextView(
            text: ContentConstant.hasReceiveEmail,
            textAlign: TextAlign.center,
            fontColor: DeasyColor.neutral500,
            fontSize: 0.97.w,
            fontFamily: FontFamily.medium,
          ),
          SizedBox(
            height: 2.18.h,
          ),
          Obx(() => Container(
            width: 20.83.w,
            child: DeasyCustomElevatedButton(
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
                    fontSize: 14,
                    onEnd: () {
                      controller.isFinished(true);
                    },
                    parenthesis: true,
                  ),
              radius: 6,
              onPress: () {
                if (controller.isFinished.isTrue) {
                  controller.resendEmail();
                }
              },
            ),
          )),
          SizedBox(
            height: 1.63.h,
          ),
          Container(
            width: 20.83.w,
            child: DeasyCustomElevatedButton(
              text: ButtonConstant.backToLoginPage,
              textColor: DeasyColor.kpYellow500,
              borderColor: DeasyColor.kpYellow500,
              primary: DeasyColor.neutral000,
              paddingButton: 10,
              radius: 6,
              onPress: () async {
                await controller.clearRetryCountAndTime();
                Get.offAllNamed(OptimusRoutes.LOGIN);
              },
            ),
          ),
        ],
      ),
    );
  }
}