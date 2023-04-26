import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/forgot_password/controllers/bumblebee_forgot_password_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';
import 'package:deasy_animation/deasy_animation.dart';

class BumblebeeForgotPasswordFormWidget
    extends GetWidget<BumblebeeForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: Get.context);
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: DeasySizeConfigUtils.screenHeight! / 7),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: DeasyColor.neutral000,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 8),
                          Text(ContentConstant.forgotPassword,
                              style: TextStyle(
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 2.8,
                                  fontFamily: 'KBFGDisplayBold',
                                  color: DeasyColor.kpBlue500)),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              ContentConstant.inputEmailForChangePassword,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 2,
                                  fontFamily: 'KBFGDisplayLight',
                                  color: DeasyColor.neutral900),
                            ),
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.035,
                          ),
                          FadeInAnimation(
                            delay: 1,
                            child: Form(
                              key: controller.formKey,
                              child: DeasyTextForm.outlinedTextForm(
                                controller: TextEditingController(),
                                labelText: ContentConstant.emailInput,
                                hintText: ContentConstant.email,
                                obscure: false,
                                readOnly: false,
                                textInputType: TextInputType.text,
                                actionKeyboard: TextInputAction.next,
                                customValidation: (String value) {
                                  return controller.validateEmail(value);
                                },
                                prefixIcon: null,
                                onChange: (value) {
                                  controller.setEmailValue(value.trim());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! / 25,
                          ),
                          Container(
                            width: DeasySizeConfigUtils.screenWidth,
                            child: FadeInAnimation(
                              delay: 2,
                              child: Obx(() => BouncingWidget(
                                    duration: Duration(milliseconds: 100),
                                    scaleFactor: 1.5,
                                    onPressed: () {
                                      controller.submit(
                                          context, controller.email.value);
                                    },
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          color: controller.email.isEmpty
                                              ? DeasyColor.neutral400
                                              : DeasyColor.kpYellow500,
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(10.0))),
                                      width:
                                          DeasySizeConfigUtils.screenWidth! / 2,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, bottom: 12.0),
                                        child: Text(
                                          ContentConstant.emailVerification,
                                          style: TextStyle(
                                              color: DeasyColor.neutral000),
                                        ),
                                      )),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.screenHeight! * 0.15,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Positioned(
                        bottom: 0,
                        child: Image.asset(
                          ImageConstant.RESOURCES_IMAGE_WAVE_GREY,
                          fit: BoxFit.fill,
                          width: DeasySizeConfigUtils.screenWidth,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isShowDialogMobile.isTrue) {
            return dialogMobile();
          } else {
            return SizedBox();
          }
        })
      ],
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
                    Get.offAllNamed(BumblebeeRoutes.LOGIN);
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
                        ContentConstant.toLoginMenu,
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
