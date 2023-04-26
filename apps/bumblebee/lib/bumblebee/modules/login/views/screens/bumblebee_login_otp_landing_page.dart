import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_landing_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BumblebeeLoginOTPLandingPage
    extends GetView<BumblebeeLoginOTPLandingController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: Get.context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: DeasySizeConfigUtils.screenWidth,
          height: DeasySizeConfigUtils.screenHeight,
          child: Stack(
            children: [
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight! / 2,
                color: DeasyColor.kpBlue200,
              ),
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
                        ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_PATH),
                  ),
                ),
              ),
              Positioned(
                top: DeasySizeConfigUtils.screenHeight! / 6.5,
                right: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: DeasyColor.neutral000,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 1.0),
                  ),
                  height: DeasySizeConfigUtils.screenHeight! / 1.3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DeasyTextView(
                        text: ContentConstant.otpVerificationTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      DeasyTextView(
                        text: ContentConstant.otpVerificationSubTitle,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontColor: DeasyColor.neutral400,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      Image.asset(ImageConstant.RESOURCES_OTP_CALL),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DeasyTextView(
                          text: ContentConstant.urgent,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      _info(
                        RichText(
                          text: TextSpan(
                            text: 'Kode OTP kamu adalah ',
                            style: TextStyle(
                              color: DeasyColor.neutral800,
                              fontFamily: getFontFamily(FontFamily.light),
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '6 digit terakhir',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text: ' dari nomor yang akan menelponmu'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      _info(
                        DeasyTextView(
                          text: 'Pastikan nomor kamu dapat menerima panggilan',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      _info(
                        DeasyTextView(
                          text: 'Jangan beritahu nomor tersebut pada siapapun',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      _actionButton(
                        bgColor: DeasyColor.kpYellow500,
                        text: ContentConstant.callMe,
                        textColor: DeasyColor.neutral000,
                        onPressed: () => controller.requestCallOtp(),
                      ),
                      SizedBox(
                        height: DeasySizeConfigUtils.screenHeight! * 0.013,
                      ),
                      _actionButton(
                        bgColor: DeasyColor.neutral000,
                        text: ContentConstant.back,
                        textColor: DeasyColor.kpYellow500,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(
      {Color? bgColor,
      String? text,
      required Color textColor,
      required Function onPressed}) {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      child: FadeInAnimation(
        delay: 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            side: BorderSide(width: 1, color: DeasyColor.kpYellow500),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => onPressed(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: DeasyTextView(
              text: '$text',
              fontColor: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(Widget text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          ImageConstant.RESOURCES_IMAGE_CHECK,
          color: DeasyColor.kpYellow500,
          width: 16,
        ),
        SizedBox(width: 8),
        Expanded(
          child: text,
        ),
      ],
    );
  }
}
