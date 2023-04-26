import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/services.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BumblebeeLoginOtpInputWidget extends GetView<BumblebeeLoginOTPController> {
  final TextEditingController fieldController;
  final FocusNode focusNode;
  final bool autoFocus;
  final int index;
  BumblebeeLoginOtpInputWidget(this.fieldController, this.focusNode, this.autoFocus, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeasySizeConfigUtils.blockVertical * 6,
      height: DeasySizeConfigUtils.blockVertical * 6,
      child: Obx(() => TextField(
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
              bottom: DeasySizeConfigUtils.blockVertical * 3
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: controller.otpArray[index].isEmpty ? DeasyColor.kpBlue50 : DeasyColor.kpBlue600,
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
                baseOffset: 0,
                extentOffset: fieldController.text.length
              );
            }
          },
          style: TextStyle(
            color: DeasyColor.neutral000,
            fontSize: DeasySizeConfigUtils.blockHorizontal! * 5.5,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}