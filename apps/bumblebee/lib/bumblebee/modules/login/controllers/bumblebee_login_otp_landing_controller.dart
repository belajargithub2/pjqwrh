import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/content_constant.dart';

class BumblebeeLoginOTPLandingController extends GetxController {
  final _loginPhoneController = Get.find<BumblebeeLoginPhoneController>();

  @override
  void onInit() {
    super.onInit();
    DeasySizeConfigUtils().init(context: Get.context);
  }

  Future<void> requestCallOtp() async {
    AnalyticConfig().sendEventStart("otp_call");
    _loginPhoneController.preRequestOTP(onFailed: () => _dialogLimitedOtp());
  }

  void _dialogLimitedOtp() {
    Get.bottomSheet(
      Container(
        width: DeasySizeConfigUtils.screenWidth,
        height: DeasySizeConfigUtils.screenHeight! / 3,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: DeasyTextView(
                      text: ContentConstant.requestOTPLimitTitle,
                      fontSize: DeasySizeConfigUtils.blockVertical * 3,
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.05,
              ),
              DeasyTextView(
                text: ContentConstant.requestOTPLimit,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.05,
              ),
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: DeasyCustomButton(
                    radius: 3,
                    text: ContentConstant.back,
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
  }
}
