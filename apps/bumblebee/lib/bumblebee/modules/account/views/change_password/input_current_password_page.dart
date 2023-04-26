import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/input_current_password_controller.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class InputCurrentPasswordPage extends GetView<InputCurrentPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DeasyColor.neutral000,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Ganti Kata Sandi',
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    ContentConstant.verifyChangePassword,
                    style:
                        TextStyle(fontSize: 14, color: DeasyColor.neutral600),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(() => DeasyTextForm.outlinedTextForm(
                        labelText: "Kata Sandi",
                        hintText: "Masukkan Kata Sandi",
                        obscure:
                            controller.isTextObscuredCurrentPassword.value,
                        readOnly: false,
                        controller: controller.currentPasswordController,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        customValidation: (String value) {
                          return controller.validatePassword(value);
                        },
                        suffixIcon: Obx(() => GestureDetector(
                              child: Icon(
                                  controller
                                          .isTextObscuredCurrentPassword.isFalse
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: DeasyColor.neutral600,
                                  size: 20.0),
                              onTap: () => controller
                                  .isTextObscuredCurrentPassword
                                  .toggle(),
                            )),
                        prefixIcon: null,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  DeasyCustomButton(
                      text: "Verifikasi",
                      color: DeasyColor.kpYellow500,
                      onPressed: () => controller.verifyPassword()),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                      child: TextButton(
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(color: DeasyColor.kpYellow500),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.PROFILE_FORGOT_PASSWORD);
                    },
                  )),
                ],
              ),
            ),
          ),
          Obx(() => Visibility(
              visible: controller.isLoading.value, child: FullScreenSpinner())),
        ],
      ),
    );
  }
}
