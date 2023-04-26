import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_profile_change_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:kreditplus_deasy_website/core/widgets/password_rules_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusProfileNewPasswordScreen
    extends GetView<OptimusProfileChangePasswordController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FadeInAnimation(
                  delay: 1,
                  child: DeasyTextForm.outlinedTextForm(
                    labelText: 'Masukkan Kata Sandi Sebelumnya',
                    hintText: 'Masukkan Kata Sandi Sebelumnya',
                    controller: controller.currentPasswordController,
                    readOnly: false,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String value) {
                      return controller.validate(value, false);
                    },
                    prefixIcon: null,
                    onChange: (val) {},
                  ),
                ),
                const SizedBox(height: 10),
                FadeInAnimation(
                  delay: 1,
                  child: Obx(() => DeasyTextForm.outlinedTextForm(
                        labelText: 'Masukkan Kata Sandi Baru',
                        hintText: 'Masukkan Kata Sandi Baru',
                        controller: controller.newPasswordController,
                        readOnly: false,
                        obscure: controller.isNewPassObscured.value,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        suffixIcon: GestureDetector(
                          child: Icon(
                              controller.isNewPassObscured.isFalse
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: DeasyColor.neutral900,
                              size: 20.0),
                          onTap: () {
                            controller.isNewPassObscured.toggle();
                          },
                        ),
                        customValidation: (String value) {
                          return controller.validate(value, true);
                        },
                        prefixIcon: null,
                        onChange: (val) {},
                      )),
                ),
                const SizedBox(height: 10),
                FadeInAnimation(
                  delay: 2,
                  child: Obx(() => DeasyTextForm.outlinedTextForm(
                        labelText: 'Konfirmasi Kata Sandi Baru',
                        hintText: 'Konfirmasi Kata Sandi Baru',
                        obscure: controller.isConfirmPassObscured.value,
                        controller: controller.confirmNewPasswordController,
                        readOnly: false,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        suffixIcon: GestureDetector(
                          child: Icon(
                              controller.isConfirmPassObscured.isFalse
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: DeasyColor.neutral900,
                              size: 20.0),
                          onTap: () {
                            controller.isConfirmPassObscured.toggle();
                          },
                        ),
                        customValidation: (String value) {
                          return controller.validate(value, true);
                        },
                        prefixIcon: null,
                        onChange: (val) {},
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    width: 150,
                    child: DeasyCustomButton(
                        text: 'Ganti Password',
                        color: DeasyColor.kpYellow500,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.changePassword();
                          }
                        })),
                const SizedBox(height: 10),
                PasswordRulesWidget(),
              ],
            ),
          ),
        ),
        Obx(() => Container(
            width: DeasySizeConfigUtils.screenWidth,
            child: Visibility(
                visible: controller.isLoading.value,
                child: FullScreenSpinner(showLoadingMessage: false)))),
      ],
    );
  }
}
