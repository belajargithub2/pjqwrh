import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:kreditplus_deasy_mobile/core/languages/languages.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_dialog/deasy_dialog.dart';

class BumblebeeLoginPhoneWidget extends GetView<BumblebeeLoginPhoneController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Image.asset(
            ImageConstant.RESOURCES_IMAGE_WAVE_GREY,
            width: DeasySizeConfigUtils.screenWidth,
            fit: BoxFit.cover,
          ),
        ),
        Obx(
          () => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.02,
              ),
              DeasyTextView(
                text: ContentConstant.loginPhoneTitle,
                fontSize: DeasySizeConfigUtils.blockHorizontal! * 5.5,
                fontColor: DeasyColor.neutral800,
                fontWeight: FontWeight.bold,
                maxLines: 2,
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.012,
              ),
              DeasyTextView(
                text: ContentConstant.loginPhoneSubtitle,
                fontSize: DeasySizeConfigUtils.blockHorizontal! * 4,
                fontColor: DeasyColor.neutral400,
                maxLines: 3,
              ),
              FadeInAnimation(
                delay: 1,
                child: Form(
                  key: controller.formKeyLoginWithPhoneNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: DeasyTextForm.outlinedTextForm(
                    hintText: ContentConstant.loginPhoneHint,
                    obscure: false,
                    textInputType: TextInputType.number,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (v) =>
                        controller.phoneNumberValidation(v),
                    controller: controller.noController,
                    isNumberOnly: true,
                    onChange: (string) {
                      controller.setPhoneNumber(string);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.025,
              ),
              Visibility(
                visible: controller.isLoading.value,
                child: FullScreenSpinner(),
              ),
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight! * 0.06,
                child: FadeInAnimation(
                  delay: 1,
                  child: BounceAnimation(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      if (controller.formKeyLoginWithPhoneNumber.currentState!
                          .validate()) {
                        _dialogOtpOption();
                      }
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: controller.phoneNumber.isEmpty
                            ? DeasyColor.neutral200
                            : DeasyColor.kpYellow500,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      width: DeasySizeConfigUtils.screenWidth! / 2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: DeasyTextView(
                            text: '${Languages.of(context)!.loginSubmit}',
                            fontColor: DeasyColor.neutral000,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.013,
              ),
              FadeInAnimation(
                delay: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DeasyColor.neutral000,
                    side: BorderSide(width: 1, color: DeasyColor.kpYellow500),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    controller.navigateToRegister();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DeasyTextView(
                      text: ContentConstant.registerButtonText,
                      fontColor: DeasyColor.kpYellow500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _dialogOtpOption() {
    Get.defaultDialog(
      title: "",
      backgroundColor: DeasyColor.neutral000,
      content: Obx(
        () => DeasyWidgetDialog(
          buttonText: ContentConstant.select,
          btnEnable: controller.selectedOtp.isNotEmpty,
          title: ContentConstant.selectOtp,
          body: _otpOption(),
          btnPress: () => controller.handleSelectOtp(),
        ),
      ),
    );
  }

  Widget _otpOption() {
    return Column(
      children: <Widget>[
        RadioListTile(
          title: DeasyTextView(
            text: ContentConstant.otpViaCall,
            fontColor: DeasyColor.neutral400,
          ),
          contentPadding: EdgeInsets.only(left: 5),
          visualDensity: VisualDensity.compact,
          activeColor: DeasyColor.kpYellow500,
          value: controller.otpOptions[0],
          groupValue: controller.selectedOtp.value,
          onChanged: (String? otp) {
            controller.changeOtpOption(otp);
          },
        ),
        RadioListTile(
          title: DeasyTextView(
            text: ContentConstant.otpViaSms,
            fontColor: DeasyColor.neutral400,
          ),
          contentPadding: EdgeInsets.only(left: 5),
          visualDensity: VisualDensity.compact,
          activeColor: DeasyColor.kpYellow500,
          value: controller.otpOptions[1],
          groupValue: controller.selectedOtp.value,
          onChanged: (String? otp) {
            controller.changeOtpOption(otp);
          },
        ),
      ],
    );
  }
}
