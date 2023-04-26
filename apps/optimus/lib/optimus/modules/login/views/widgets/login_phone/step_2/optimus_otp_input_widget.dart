import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_two_controller.dart';

class OptimusOtpInputWidget
    extends GetView<OptimusLoginPhoneStepTwoController> {
  final TextEditingController fieldController;
  final FocusNode focusNode;
  final bool autoFocus;
  final int index;
  OptimusOtpInputWidget(
      this.fieldController, this.focusNode, this.autoFocus, this.index);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: DeasySizeConfigUtils.blockVertical * 6,
        height: DeasySizeConfigUtils.blockVertical * 6,
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: fieldController,
          focusNode: focusNode,
          maxLength: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
                left: DeasySizeConfigUtils.blockVertical / 2,
                bottom: DeasySizeConfigUtils.blockVertical * 3),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: controller.otpArray[index].isEmpty
                ? DeasyColor.kpBlue200
                : DeasyColor.kpBlue600,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            counterText: '',
          ),
          onChanged: (value) {
            controller.setOTPText(value, index, context);
          },
          onTap: () {
            if (fieldController.text.isNotEmpty) {
              fieldController.selection = TextSelection(
                  baseOffset: 0, extentOffset: fieldController.text.length);
            }
          },
          style: TextStyle(
            color: DeasyColor.neutral000,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
