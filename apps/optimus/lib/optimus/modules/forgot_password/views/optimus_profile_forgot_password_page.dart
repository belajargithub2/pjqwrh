import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/core/widgets/decoration.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/controllers/optimus_forgot_password_controller.dart';

class OptimusProfileForgotPasswordPage
    extends GetView<OptimusForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: Material(
        child: Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  backgroundColor: DeasyColor.neutral000,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: DeasyColor.neutral900),
                    onPressed: () => Get.back(),
                  ),
                  title: Text(
                    ContentConstant.forgotPassword,
                    style: TextStyle(
                        color: DeasyColor.neutral900,
                        fontWeight: FontWeight.bold),
                  ),
                  elevation: 2,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text(
                          ContentConstant.insertEmailForgotPassword,
                          style: TextStyle(
                              fontSize: 14, color: DeasyColor.neutral600),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        DeasyTextForm.outlinedTextForm(
                          controller: TextEditingController(),
                          labelText: ContentConstant.email,
                          hintText: ContentConstant.emailInput,
                          textInputType: TextInputType.emailAddress,
                          actionKeyboard: TextInputAction.next,
                          customValidation: (String value) {
                            return controller.validateEmail(value);
                          },
                          prefixIcon: null,
                          onChange: (val) {
                            controller.email.value = val;
                            controller.update();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DeasyCustomButton(
                            text: ContentConstant.emailVerification,
                            color: DeasyColor.kpYellow500,
                            onPressed: () => controller.submit(
                                context, controller.email.value)),
                      ],
                    ),
                  ),
                )),
            SizedBox(),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: DeasyFullScreenLoading(
                    messageLoading: "Mohon menunggu..."))),
          ],
        ),
      ),
    );
  }
}
