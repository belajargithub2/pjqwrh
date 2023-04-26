import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_profile_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusProfileScreen extends GetView<OptimusProfileController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: ContentConstant.dealerId,
            hintText: ContentConstant.dealerIdHint,
            obscure: false,
            controller: controller.merchantIdController,
            readOnly: true,
            textInputType: TextInputType.text,
            actionKeyboard: TextInputAction.next,
            customValidation: (String value) {},
            prefixIcon: null,
            onChange: (string) {},
          ),
          const SizedBox(
            height: 16,
          ),
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: ContentConstant.merchantName,
            hintText: ContentConstant.merchantNameHint,
            obscure: false,
            controller: controller.merchantNameController,
            readOnly: true,
            textInputType: TextInputType.text,
            actionKeyboard: TextInputAction.next,
            customValidation: (String value) {},
            prefixIcon: null,
            onChange: (string) {},
          ),
          const SizedBox(
            height: 16,
          ),
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: ContentConstant.merchantAddress,
            hintText: ContentConstant.merchantAddressHint,
            obscure: false,
            controller: controller.merchantAddressController,
            readOnly: true,
            textInputType: TextInputType.text,
            actionKeyboard: TextInputAction.next,
            customValidation: (String value) {},
            prefixIcon: null,
            onChange: (string) {},
          ),
          const SizedBox(
            height: 16,
          ),
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: ContentConstant.phoneNumber,
            controller: controller.merchantPhoneController,
            hintText: "",
            obscure: false,
            readOnly: true,
            prefixIcon: null,
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
              width: Get.width,
              decoration: BoxDecoration(
                  border: Border.all(color: DeasyColor.kpBlue500),
                  borderRadius: BorderRadius.circular(6),
                  color: DeasyColor.kpBlue50),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: Image.asset(
                        IconConstant.RESOURCES_ICON_ALERT_PATH,
                        height: 24,
                        width: 24,
                        color: DeasyColor.kpBlue500,
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: 15)),
                    TextSpan(
                        text: ContentConstant.callCenterMessage,
                        style: TextStyle(color: DeasyColor.kpBlue500))
                  ]),
                ),
              ))
        ],
      ),
    );
  }
}
