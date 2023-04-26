import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_one_controller.dart';

class OptimusPhoneInputWidget
    extends GetView<OptimusLoginPhoneStepOneController> {
  const OptimusPhoneInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(() => Form(
        key: controller.formKeyLoginWithPhoneNumber,
        autovalidateMode: controller.autoValidate.value,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: DeasySizeConfigUtils.screenHeight! * 0.02,
            ),
            FadeInAnimation(
              delay: 1,
              child: DeasyTextForm.outlinedTextForm(
                labelText: ContentConstant.phoneTextFieldLabel,
                labelSize: 18.0,
                labelFontFamily: FontFamilyTextForm.medium,
                hintText: ContentConstant.phoneTextFieldHint,
                isNumberOnly: true,
                maxInputLength: 14,
                controller: controller.noController,
                textInputType: TextInputType.number,
                actionKeyboard: TextInputAction.done,
                onSubmitField: () => controller.submitPhoneNumber(),
                customValidation: (v) => controller.phoneNumberValidation(v),
              ),
            ),
            SizedBox(
              height: DeasySizeConfigUtils.screenHeight! * 0.05,
            ),
            Container(
              child: FadeInAnimation(
                delay: 1,
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.loggingIn,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  onPress: () async {
                    controller.submitPhoneNumber();
                  },
                ),
              ),
            ),
            SizedBox(
              height: DeasySizeConfigUtils.screenHeight! * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
