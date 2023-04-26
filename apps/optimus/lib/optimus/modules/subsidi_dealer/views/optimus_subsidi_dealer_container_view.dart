import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/optimus_subsidi_dealer_web_view.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusSubsidiDealerContainerView extends GetView<OptimusSubsidiDealerController> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return SelectionArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          DeasySizeConfigUtils.setScreenSize(constraints);
          return OptimusDrawerCustom(
            scaffoldKey: scaffoldKey,
            body: Obx(
              () => controller.isLoading.isTrue
                  ? AbsorbPointer(
                      absorbing: true,
                      child: Stack(
                        children: [Container(), FullScreenSpinner()],
                      ),
                    )
                  : OptimusSubsidiDealerWebView(),
            ),
          );
        },
      ),
    );
  }
}
