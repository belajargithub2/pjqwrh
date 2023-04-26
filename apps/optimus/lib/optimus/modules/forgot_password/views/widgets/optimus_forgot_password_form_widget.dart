import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/controllers/optimus_forgot_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/bounce_widget.dart';
import 'package:deasy_animation/deasy_animation.dart';

class OptimusForgotPasswordFormWidget
    extends GetWidget<OptimusForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: Get.context);
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                DeasySizeConfigUtils.isMobile ? Container() : Spacer(),
                Expanded(
                    child: Image.asset(ImageConstant.RESOURCES_IMAGE_KP_LOGO))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 0),
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
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: false,
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
          if (controller.isShowDialogWebsite.isTrue) {
            return dialogWebsite();
          } else {
            return SizedBox();
          }
        })
      ],
    );
  }

  dialogWebsite() {
    if (controller.isShowDialogWebsite.isTrue) {
      controller.isShowDialogWebsite.toggle();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: Get.context!,
          builder: (_) => AlertDialog(
                backgroundColor: DeasyColor.neutral000,
                title: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: DeasyColor.neutral900,
                      ),
                      onPressed: () {
                        controller.isShowDialogWebsite.value = false;
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                content: Container(
                  width: Get.width / 3,
                  height: Get.height / 2,
                  child: Column(
                    children: [
                      Image.asset(
                        ImageConstant.RESOURCES_IMAGE_COMPUTER,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          ContentConstant.verifChangePasswordMessage,
                          style: TextStyle(
                              fontSize: 15, color: DeasyColor.neutral900),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )).then((value) => controller.isShowDialogWebsite.value = false);
    });
    return Container();
  }
}
