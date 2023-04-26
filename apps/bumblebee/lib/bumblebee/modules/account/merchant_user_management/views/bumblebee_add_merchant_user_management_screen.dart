import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart' as textForm;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_add_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/widgets/bumblebee_merchant_user_management_dialog.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeAddMerchantUserManagementScreen extends GetView<BumblebeeAddMerchantUserManagementController> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        return Obx(() => Stack(
            children: [
              Scaffold(
                backgroundColor: DeasyColor.neutral50,
                appBar: _appBar(),
                body: _body(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2.35.h),
                  decoration: BoxDecoration(
                    color: DeasyColor.neutral000,
                    border: Border(
                      top: BorderSide(
                        color: DeasyColor.neutral200
                      )
                    )
                  ),
                  child: DeasyCustomElevatedButton(
                    text: ContentConstant.addUserLabel,
                    textColor: DeasyColor.neutral000,
                    borderColor: DeasyColor.neutral200,
                    primary: controller.isFormNotEmpty.isTrue
                      ? DeasyColor.kpYellow500
                      : DeasyColor.neutral200,
                    onPress: () async {
                      controller.submit().then((value) {
                        if (controller.isShowSuccessDialog) {
                          successAddUserDialog(
                            controller.emailController.text,
                            () {
                              controller.isShowSuccessDialog = false;
                            }
                          );
                        }
                      });
                    },
                  ),
                )
              ),
              if (controller.isLoading.isTrue) loadingSpinner()
            ],
          ),
        );
      }
    );
  }

  Widget loadingSpinner() {
    return AbsorbPointer(
      absorbing: true,
      child: FullScreenSpinner(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: DeasyColor.neutral000,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
        onPressed: () => Get.back(),
      ),
      title: DeasyTextView(
        text: ContentConstant.addMerchantEmployee,
        fontColor: DeasyColor.neutral900,
        fontFamily: FontFamily.bold,
        fontSize: 16.5.sp,
      ),
      elevation: 2,
    );
  }

  Widget _body() {
    return Form(
      key: controller.formKey,
      autovalidateMode: controller.autoValidate.value,
      child: Container(
        color: DeasyColor.neutral000,
        padding: EdgeInsets.all(2.35.h),
        child: ListView(
          shrinkWrap: true,
          children: [
            textForm.DeasyTextForm.outlinedTextForm(
              hintText: ContentConstant.merchantUserNameHint,
              labelText: ContentConstant.name,
              labelSize: 2.05.h,
              labelFontFamily: textForm.FontFamilyTextForm.medium,
              controller: controller.nameController,
              textInputType: TextInputType.text,
              customValidation: (String val) =>
                val.nameValidator(
                  msgNameCantBeEmpty:
                    ContentConstant.nameCantBeNull,
                  msgNameMaxLength: ContentConstant.msgNameMaxLength,
                  msgNameCantContainSpecialChar:
                    ContentConstant.userNameCantContainSpecialChar),
            ),
            SizedBox(height: 2.5.h),
            textForm.DeasyTextForm.outlinedTextForm(
              hintText: ContentConstant.phoneNumberHint,
              maxInputLength: 14,
              customLabelWidget: Row(
                children: [
                  DeasyTextView(
                    text: ContentConstant.phoneNumber,
                    fontFamily: FontFamily.medium,
                    fontSize: 14.0,
                  ),
                  SizedBox(width: 6.0),
                  DeasyTextView(
                    text: ContentConstant.optional,
                    fontColor: DeasyColor.neutral400,
                    fontFamily: FontFamily.medium,
                    fontSize: 14.0,
                  ),
                ],
              ),
              labelSize: 2.05.h,
              labelFontFamily: textForm.FontFamilyTextForm.medium,
              controller: controller.phoneController,
              textInputType: TextInputType.number,
              isNumberOnly: true,
              customValidation: (String val) =>
                val.phoneValidator(
                  msgPhoneNotValid: ContentConstant.phoneNumberNotValid),
            ),
            SizedBox(height: 2.5.h),
            textForm.DeasyTextForm.outlinedTextForm(
              hintText: ContentConstant.emailFinansiaHint,
              labelText: ContentConstant.email,
              labelSize: 2.05.h,
              labelFontFamily: textForm.FontFamilyTextForm.medium,
              controller: controller.emailController,
              textInputType: TextInputType.text,
              customValidation: (String val) =>
                val.emailValidator(
                  msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                  msgEmailNotValid: ContentConstant.emailNotValid.capitalizeFirst!),
            ),
          ]
        ),
      ),
    );
  }
}