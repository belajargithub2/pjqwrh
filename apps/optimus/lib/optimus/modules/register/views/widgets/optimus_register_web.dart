import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/controllers/optimus_register_merchant_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_card.dart';
import 'package:kreditplus_deasy_website/core/widgets/wave_sidebar.dart';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

class OptimusRegisterWeb extends GetView<OptimusRegisterMerchantController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: WaveSidebar()),
        Expanded(flex: 7, child: OptimusRegisterCard()),
      ],
    );
  }
}
