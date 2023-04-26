import 'dart:math';

import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart' as text;
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_email_controller.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusLoginEmailWidget extends StatefulWidget {
  @override
  _OptimusLoginEmailWidgetState createState() =>
      _OptimusLoginEmailWidgetState();
}

class _OptimusLoginEmailWidgetState extends State<OptimusLoginEmailWidget>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<OptimusLoginEmailController>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    super.build(context);
    return Obx(
      () => Stack(
        children: [
          Form(
            key: controller.formKey,
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
                    isNoSpaceOnly: true,
                    labelText: ContentConstant.emailLabel,
                    labelSize: 18.0,
                    labelFontFamily: FontFamilyTextForm.medium,
                    hintText: ContentConstant.emailLabel,
                    controller: controller.emailController,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String v) => v.emailValidator(
                      msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                      msgEmailNotValid: ValidationConstant.emailNotValid.capitalizeFirst!),
                    prefixIcon: null,
                    onChange: (val) {
                      controller.handleVerification(val);
                    },
                    suffixIcon: Transform.rotate(
                      angle: 45 * pi / 180,
                      child: controller.isShowingClearButton.value
                          ? IconButton(
                              icon: Icon(Icons.add_circle,
                                  color: Colors.black, size: 20.0),
                              onPressed: () {
                                controller.clearEmailValue();
                              })
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.03,
                ),
                FadeInAnimation(
                  delay: 1,
                  child: DeasyTextForm.outlinedTextForm(
                    isNoSpaceOnly: true,
                    labelText: ContentConstant.passwordLabel,
                    labelSize: 18.0,
                    labelFontFamily: FontFamilyTextForm.medium,
                    hintText: ContentConstant.passwordLabel,
                    controller: controller.passwordController,
                    obscure: controller.isTextObscured.value,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.done,
                    onSubmitField: () => controller.submit(),
                    customValidation: (v) => controller.passwordValidation(v),
                    prefixIcon: null,
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isTextObscured.isFalse
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: DeasyColor.neutral400,
                          size: 20.0),
                      onPressed: () {
                        controller.isTextObscured.value =
                            !controller.isTextObscured.value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Visibility(
                    visible: controller.isLoading.value,
                    child: FullScreenSpinner()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(OptimusRoutes.FORGOT_PASSWORD);
                    },
                    child: text.DeasyTextView(
                      text: ContentConstant.forgotPassword,
                      textAlign: TextAlign.right,
                      fontSize: 14.0,
                      fontColor: DeasyColor.kpBlue500,
                    ),
                  ),
                ),
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: FadeInAnimation(
                      delay: 1,
                      child: DeasyCustomElevatedButton(
                        text: ButtonConstant.login,
                        textColor: DeasyColor.neutral000,
                        borderColor: DeasyColor.kpYellow500,
                        primary: DeasyColor.kpYellow500,
                        onPress: () async {
                          controller.submit();
                        },
                      ),
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.02,
                ),
                FadeInAnimation(
                  delay: 1,
                  child: DeasyCustomElevatedButton(
                    text: ContentConstant.registerMerchant,
                    textColor: DeasyColor.kpYellow500,
                    borderColor: DeasyColor.kpYellow500,
                    primary: DeasyColor.neutral000,
                    onPress: () async {
                      controller.navigateToRegister();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
