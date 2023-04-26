import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/controllers/optimus_new_password_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/views/widgets/optimus_new_password_card.dart';
import 'package:kreditplus_deasy_website/core/widgets/wave_sidebar.dart';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

class OptimusNewPasswordWeb extends GetView<OptimusNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: WaveSidebar()),
        Expanded(flex: 7, child: OptimusNewPasswordCard()),
      ],
    );
  }
}
