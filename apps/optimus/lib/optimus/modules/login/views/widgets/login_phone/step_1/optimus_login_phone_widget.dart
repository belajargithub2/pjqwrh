import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_phone_step_one_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_1/optimus_choose_otp_type_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_1/optimus_phone_input_widget.dart';

class OptimusLoginPhoneWidget extends StatefulWidget {
  @override
  _OptimusLoginPhoneWidgetState createState() =>
      _OptimusLoginPhoneWidgetState();
}

class _OptimusLoginPhoneWidgetState extends State<OptimusLoginPhoneWidget> {
  final controller = Get.find<OptimusLoginPhoneStepOneController>();

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(
      () => Stack(children: [
        Visibility(
          child: OptimusPhoneInputWidget(),
          visible: !controller.isShowOtpTypeOption.value,
        ),
        Visibility(
          child: OptimusChooseOtpTypeWidget(),
          visible: controller.isShowOtpTypeOption.value,
        ),
      ]),
    );
  }
}
