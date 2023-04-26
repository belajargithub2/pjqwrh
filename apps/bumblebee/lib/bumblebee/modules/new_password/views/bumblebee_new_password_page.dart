import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_password/controllers/bumblebee_new_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';


class BumbleBeeNewPasswordPage extends GetView<BumblebeeNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    controller.retrieveDeepLink();
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
                          '${ImageConstant.RESOURCES_IMAGES_PATH}wave_splash_bottom_one.svg',
                          width: DeasySizeConfigUtils.screenWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          'resources/images/wave_splash_bottom_two.svg',
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
                                    'resources/images/deasy_logo.svg'))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: controller.autoValidate.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          Text("Atur Kata Sandi Baru",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 3,
                                  fontFamily: 'KBFGDisplayBold',
                                  color: DeasyColor.neutral900)),
                          SizedBox(height: 20),
                          FadeInAnimation(
                            delay: 1,
                            child: Obx(() => DeasyTextForm.outlinedTextForm(
                                  labelText: "Kata Sandi Baru",
                                  hintText: "Kata Sandi Baru",
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: DeasyColor.kpBlue600,
                                    ),
                                    onPressed: () =>
                                        controller.showChangePasswordRules,
                                  ),
                                  controller: controller.passwordController,
                                  readOnly: false,
                                  obscure: controller
                                      .isTextObscuredNewPassword.value,
                                  textInputType: TextInputType.text,
                                  actionKeyboard: TextInputAction.next,
                                  suffixIcon: Obx(() => GestureDetector(
                                        child: Icon(
                                            controller.isTextObscuredNewPassword
                                                    .isFalse
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: DeasyColor.neutral600,
                                            size: 20.0),
                                        onTap: () {
                                          controller.toggleNewPasswordObscure();
                                        },
                                      )),
                                  customValidation: (String value) {
                                    return controller.validate(value, false);
                                  },
                                  prefixIcon: null,
                                  onChange: (val) {
                                    controller.checkerPassword(val);
                                  },
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Obx(() => Visibility(
                                visible: controller.passwordChecker.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Password Strength : ${controller.passwordChecker.value}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: controller
                                                  .passwordChecker.value
                                                  .isContainIgnoreCase("Lemah")
                                              ? DeasyColor.kpYellow500
                                              : DeasyColor.dms2ED477),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ))),
                          ),
                          SizedBox(height: 10),
                          FadeInAnimation(
                            delay: 1,
                            child: Obx(() => DeasyTextForm.outlinedTextForm(
                                  labelText: "Konfirmasi Kata Sandi Baru",
                                  hintText: "Masukkan Ulang Kata Sandi Baru",
                                  obscure: controller
                                      .isTextObscuredConfirmPassword.value,
                                  controller: controller.newPasswordController,
                                  readOnly: false,
                                  textInputType: TextInputType.text,
                                  actionKeyboard: TextInputAction.next,
                                  suffixIcon: Obx(() => GestureDetector(
                                        child: Icon(
                                            controller
                                                    .isTextObscuredConfirmPassword
                                                    .isFalse
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: DeasyColor.neutral600,
                                            size: 20.0),
                                        onTap: () {
                                          controller
                                              .toggleConfirmPasswordObscure();
                                        },
                                      )),
                                  customValidation: (String value) {
                                    return controller.validate(value, true);
                                  },
                                  prefixIcon: null,
                                  onChange: (val) {},
                                )),
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! / 18,
                          ),
                          Container(
                            width: DeasySizeConfigUtils.screenWidth,
                            child: FadeInAnimation(
                              delay: 1,
                              child: DeasyCustomButton(
                                  text: "Atur Kata Sandi",
                                  color: DeasyColor.kpYellow500,
                                  onPressed: () {
                                    controller.submit();
                                  }),
                            ),
                          ),
                          SizedBox(
                              height: DeasySizeConfigUtils.blockVertical * 10),
                          Obx(() => Text(
                                'V ${controller.appVersion.value}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'KBFGDisplayLight',
                                    color: DeasyColor.neutral400),
                              )),
                        ],
                      ),
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
}
