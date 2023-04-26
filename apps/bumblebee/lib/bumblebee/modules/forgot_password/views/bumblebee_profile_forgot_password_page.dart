import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/controllers/bumblebee_forgot_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class BumblebeeProfileForgotPasswordPage
    extends GetView<BumblebeeForgotPasswordController> {
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
            Obx(() {
              if (controller.isShowDialogMobile.isTrue) {
                return dialogMobile();
              } else {
                return SizedBox();
              }
            }),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: DeasyFullScreenLoading(
                    messageLoading: "Mohon menunggu..."))),
          ],
        ),
      ),
    );
  }

  dialogMobile() {
    if (controller.isShowDialogMobile.isTrue) {
      controller.isShowDialogMobile.toggle();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
          title: "",
          barrierDismissible: true,
          backgroundColor: DeasyColor.neutral000,
          content: Container(
            width: DeasySizeConfigUtils.screenWidth! / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconConstant.RESOURCES_ICON_CHECKLIST,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ContentConstant.successSent,
                  style: TextStyle(
                      color: DeasyColor.neutral900,
                      fontSize: DeasySizeConfigUtils.blockVertical * 2),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(ContentConstant.messageEmailVerify,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: DeasyColor.neutral400,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.7)),
                SizedBox(
                  height: 15,
                ),
                BouncingWidget(
                  duration: Duration(milliseconds: 100),
                  scaleFactor: 1.5,
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: DeasyColor.kpYellow500,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0))),
                    width: DeasySizeConfigUtils.screenWidth! / 2,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        ContentConstant.understand,
                        style: TextStyle(color: DeasyColor.neutral000),
                      ),
                    )),
                  ),
                )
              ],
            ),
          )).then((value) => controller.isShowDialogMobile.value = false);
    });

    return Container();
  }
}
