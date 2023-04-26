import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/controllers/bumblebee_register_agent_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/widgets/register_text_field_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';

class RegisterAgentPage extends GetView<BumblebeeRegisterAgentController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(() => SafeArea(
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: DeasyColor.neutral000,
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: DeasyColor.neutral900,
                      )),
                  title: Text(
                    ContentConstant.registerAgent,
                    style: TextStyle(
                        color: DeasyColor.neutral900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  height: DeasySizeConfigUtils.screenHeight,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Form(
                      key: controller.formKey,
                      autovalidateMode: controller.autoValidate.value,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              RegisterTextFieldWidget(
                                textFieldKey: Key('agentName'),
                                title: ContentConstant.name,
                                hintText: ContentConstant.agentName,
                                bottomNote: '',
                                customValidatorMethod: (val) =>
                                    val.userNameValidator(
                                      msgUserNameCantBeEmpty:
                                        ContentConstant.userNameCantBeNull,
                                      msgUserNameCantContainSpecialChar:
                                        ContentConstant.userNameCantContainSpecialChar),
                                bottomNoteVisibility: false,
                                borderRadius: 8,
                                isRequired: true,
                                isNumberOnly: false,
                                controller: controller.agentNameController,
                              ),
                              RegisterTextFieldWidget(
                                textFieldKey: Key('agentKTP'),
                                title: ContentConstant.noKtp,
                                hintText: ContentConstant.inputNoKtp,
                                bottomNote: '',
                                bottomNoteVisibility: false,
                                borderRadius: 8,
                                isRequired: true,
                                isNumberOnly: true,
                                maxInputLength: 16,
                                controller: controller.agentKTPController,
                                customValidator:
                                    controller.agentKTPController.text.length <
                                        16,
                                customValidatorMessage:
                                    ContentConstant.noKtpLength,
                              ),
                              RegisterTextFieldWidget(
                                textFieldKey: Key('agentEmail'),
                                title: ContentConstant.email,
                                hintText: ContentConstant.emailFinansiaHint,
                                bottomNote: '',
                                customValidatorMethod: (v) =>
                                    v.emailValidator(
                                      msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                                      msgEmailNotValid: ContentConstant.emailNotValid.capitalizeFirst!),
                                bottomNoteVisibility: false,
                                borderRadius: 8,
                                isRequired: true,
                                isNumberOnly: false,
                                maxInputLength: 100,
                                controller: controller.agentEmailController,
                              ),
                              RegisterTextFieldWidget(
                                textFieldKey: Key('agentPhone'),
                                title: ContentConstant.registerAgentPhoneNumber,
                                hintText: ContentConstant.phoneNumberHint,
                                bottomNote: '',
                                bottomNoteVisibility: false,
                                borderRadius: 8,
                                isRequired: true,
                                isNumberOnly: true,
                                maxInputLength: 14,
                                controller: controller.agentPhoneController,
                                customValidator: !controller.agentPhoneController.text.isIdPhoneNumber(),
                                customValidatorMessage:
                                    ContentConstant.phoneNumberNotValid,
                              ),
                              RegisterTextFieldWidget(
                                textFieldKey: Key('agentType'),
                                title: ContentConstant.agentType,
                                hintText: ContentConstant.carAgent,
                                bottomNote: '',
                                bottomNoteVisibility: false,
                                borderRadius: 8,
                                isReadOnly: true,
                                onFieldTap: () {},
                                isRequired: false,
                                controller: controller.agentTypeController,
                                widgetSuffix: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 20.0),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(24),
                  child: FadeInAnimation(
                      delay: 1,
                      child: DeasyCustomElevatedButton(
                        text: ContentConstant.registerButtonText,
                        primary: DeasyColor.kpYellow500,
                        textColor: DeasyColor.neutral000,
                        paddingButton: 10,
                        borderColor: DeasyColor.kpYellow500,
                        onPress: () {
                          controller.register();
                        },
                      )),
                ),
              ),
              Visibility(
                  visible: controller.isLoading.value,
                  child: FullScreenSpinner())
            ],
          ),
        ));
  }
}
