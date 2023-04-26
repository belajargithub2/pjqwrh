import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/views/widgets/bumblebee_login_otp_input_widget.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';

class BumblebeeLoginOTPPage extends GetView<BumblebeeLoginOTPController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              height: DeasySizeConfigUtils.screenHeight,
              child: SingleChildScrollView(
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
                                ImageConstant.RESOURCES_IMAGE_DEASY_LOGO_PATH,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DeasyTextView(
                            text: ContentConstant.otpVerificationTitle,
                            fontSize:
                                DeasySizeConfigUtils.blockHorizontal! * 5.5,
                            fontColor: DeasyColor.neutral800,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.012,
                          ),
                          _info(),
                          Row(
                            children: [
                              DeasyTextView(
                                text: ContentConstant.phoneMistaken,
                                fontColor: DeasyColor.neutral400,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: DeasyTextView(
                                  text: ContentConstant.reLogin,
                                  fontColor: DeasyColor.kpYellow500,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BumblebeeLoginOtpInputWidget(controller.fieldOne,
                                  controller.focusNodeOne, true, 0),
                              BumblebeeLoginOtpInputWidget(controller.fieldTwo,
                                  controller.focusNodeTwo, false, 1),
                              BumblebeeLoginOtpInputWidget(
                                  controller.fieldThree,
                                  controller.focusNodeThree,
                                  false,
                                  2),
                              BumblebeeLoginOtpInputWidget(controller.fieldFour,
                                  controller.focusNodeFour, false, 3),
                              BumblebeeLoginOtpInputWidget(controller.fieldFive,
                                  controller.focusNodeFive, false, 4),
                              BumblebeeLoginOtpInputWidget(controller.fieldSix,
                                  controller.focusNodeSix, false, 5)
                            ],
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.035,
                          ),
                          Obx(
                            () => DeasyTextView(
                              text:
                                  '${((controller.timerMaxSeconds.value - controller.currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}:${((controller.timerMaxSeconds.value - controller.currentSeconds.value) % 60).toString().padLeft(2, '0')}',
                              textAlign: TextAlign.center,
                              fontColor: DeasyColor.neutral400,
                              fontSize:
                                  DeasySizeConfigUtils.blockHorizontal! * 3.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.06,
                          ),
                          DeasyTextView(
                            text: ContentConstant.notReceivingOtp,
                            textAlign: TextAlign.center,
                            fontColor: DeasyColor.neutral400,
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeasySizeConfigUtils.blockHorizontal! * 23),
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.canRequestOTP.isFalse
                                          ? DeasyColor.neutral200
                                          : DeasyColor.kpYellow500,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {
                                  controller.resendOTP(
                                    onFailed: (m) => showDialog(m),
                                  );
                                },
                                child: DeasyTextView(
                                  text: ContentConstant.resendOtp,
                                  fontColor: DeasyColor.neutral000,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.phoneNumberController!.isLoading.value,
                child:
                    DeasyFullScreenLoading(messageLoading: "Mohon menunggu..."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info() {
    if (controller.otpType.value.isEqualIgnoreCase("sms")) {
      return RichText(
        text: TextSpan(
          text:
              "Isi dengan kode OTP yang telah kami kirimkan melalui SMS ke nomor ",
          style: TextStyle(
            color: DeasyColor.neutral400,
            fontFamily: getFontFamily(FontFamily.light),
          ),
          children: [
            TextSpan(
              text: '${controller.dashedPhoneNumber.value}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text: "Silakan lanjutkan dengan mengisi ",
          style: TextStyle(
            color: DeasyColor.neutral400,
            fontFamily: getFontFamily(FontFamily.light),
          ),
          children: [
            TextSpan(
              text: '6 digit terakhir',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: " dari nomor yang menelepon kamu"),
          ],
        ),
      );
    }
  }

  void showDialog(String message) {
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: DeasyColor.neutral000,
      radius: 16.0,
      title: "",
      content: Container(
        width: DeasySizeConfigUtils.screenWidth! / 1.45,
        padding: EdgeInsets.symmetric(
            horizontal: DeasySizeConfigUtils.blockHorizontal! * 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstant.RESOURCES_FAILED_GENERATE,
              width: DeasySizeConfigUtils.blockHorizontal! * 15,
              height: DeasySizeConfigUtils.blockHorizontal! * 15,
            ),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
            DeasyTextView(
              text: ContentConstant.requestOTPLimitTitle,
              textAlign: TextAlign.center,
              maxLines: 3,
              fontSize: DeasySizeConfigUtils.blockHorizontal! * 5.35,
              fontWeight: FontWeight.bold,
              fontColor: DeasyColor.neutral800,
            ),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
            DeasyTextView(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 5,
              fontSize: DeasySizeConfigUtils.blockHorizontal! * 3.9,
              fontColor: DeasyColor.neutral200,
            ),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: DeasyCustomButton(
                  text: ContentConstant.understand,
                  radius: 8,
                  onPressed: () {
                    Get.back();
                    Get.back();
                  }),
            ),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
          ],
        ),
      ),
    );
  }
}
