import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/controllers/dealer_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/views/widgets/dealer_data_table.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class DealerManagementWeb extends GetView<DealerManagementController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return OptimusDrawerCustom(
      body: Obx(() => controller.isLoading.isTrue
          ? AbsorbPointer(
              absorbing: true,
              child: Stack(
                children: [Container(), FullScreenSpinner()],
              ),
            )
          : Container(color: DeasyColor.neutral50, child: DealerDataTable())),
    );
  }
}
