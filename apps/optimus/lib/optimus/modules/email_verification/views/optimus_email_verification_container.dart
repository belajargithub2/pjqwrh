import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/controllers/optimus_email_verification_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/email_verification/views/widgets/optimus_email_verification_web.dart';
import 'package:kreditplus_deasy_website/core/widgets/base_widget.dart';

class OptimusEmailVerificationContainer
    extends GetView<OptimusEmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BaseWidget(
          child: DeasyResponsive(
            builder: (context, orientation, screenType) {
              return OptimusEmailVerificationWeb();
            },
          ),
        ),
      ),
    );
  }
}
