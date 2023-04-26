import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/widgets/wave_sidebar.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/controllers/optimus_email_verification_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/views/widgets/optimus_email_verification_card.dart';

class OptimusEmailVerificationWeb extends GetView<OptimusEmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: WaveSidebar()),
        Expanded(flex: 7, child: OptimusEmailVerificationCard()),
      ],
    );
  }
}
