import 'dart:math';

import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_email_controller.dart';
import 'package:kreditplus_deasy_mobile/core/languages/languages.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeLoginEmailWidget extends StatefulWidget {
  @override
  _LoginEmailWidgetState createState() => _LoginEmailWidgetState();
}

class _LoginEmailWidgetState extends State<BumblebeeLoginEmailWidget>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<BumblebeeLoginEmailController>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    super.build(context);
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
        Form(
          key: controller.formKey,
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
                    labelText: Languages.of(context)!.loginEmail,
                    hintText: Languages.of(context)!.enterEmail,
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String v) => v.emailValidator(
                      msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                      msgEmailNotValid: ContentConstant.emailNotValid.capitalizeFirst!),
                    controller: controller.emailController,
                    onChange: (value) {
                      controller.handleVerification(value);
                    },
                    suffixIcon: Obx(() => Transform.rotate(
                          angle: 45 * pi / 180,
                          child: controller.isShowingClearButton.value
                              ? IconButton(
                                  icon: Icon(Icons.add_circle,
                                      color: Colors.black, size: 20.0),
                                  onPressed: () {
                                    controller.clearEmailValue();
                                  })
                              : null,
                        ))),
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.03,
              ),
              Obx(() => FadeInAnimation(
                    delay: 1,
                    child: DeasyTextForm.outlinedTextForm(
                      isNoSpaceOnly: true,
                      labelText: Languages.of(context)!.loginPassword,
                      hintText: Languages.of(context)!.enterPassword,
                      obscure: controller.isTextObscured.value,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      customValidation: (v) => controller.passwordValidation(v),
                      controller: controller.passwordController,
                      onSubmitField: () async {
                        controller.submit();
                      },
                      suffixIcon: Obx(() => GestureDetector(
                            child: Icon(
                                controller.isTextObscured.isFalse
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: DeasyColor.neutral600,
                                size: 20.0),
                            onTap: () {
                              controller.isTextObscured.value =
                                  !controller.isTextObscured.value;
                              controller.update();
                            },
                          )),
                    ),
                  )),
              Obx(() => Visibility(
                  visible: controller.isLoading.value,
                  child: FullScreenSpinner())),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: Text(Languages.of(context)!.loginForgotPassword,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14.0, color: DeasyColor.kpYellow500))),
              ),
              Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  height: DeasySizeConfigUtils.screenHeight! * 0.06,
                  child: FadeInAnimation(
                    delay: 1,
                    child: Obx(() => BounceAnimation(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () {
                            if (controller.isShowingClearButton.isTrue)
                              controller.submit();
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                                color: controller.isShowingClearButton.isFalse
                                    ? DeasyColor.neutral200
                                    : DeasyColor.kpYellow500,
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            width: DeasySizeConfigUtils.screenWidth! / 2,
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                '${Languages.of(context)!.loginSubmit}',
                                style: TextStyle(color: DeasyColor.neutral000),
                              ),
                            )),
                          ),
                        )),
                  )),
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
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      controller.navigateToRegister();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        ContentConstant.registerButtonText,
                        style: TextStyle(color: DeasyColor.kpYellow500),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
