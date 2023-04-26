import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';

class OptimusMenuWidget extends StatelessWidget {
  final _drawerController = Get.find<OptimusDrawerCustomController>();
  final Function downloadTap;

  OptimusMenuWidget({required this.downloadTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuWidgets.twoMenu(
          menuNameOne: MenuConstant.dashboardLabel,
          menuNameTwo: ContentConstant.subsidiDealerLabel,
          onTapMenuOne: () {
            _drawerController.handleIcon();
            Get.back();
            Get.offNamed(Routes.DASHBOARD_WEB);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DeasyTextView(
                  text: ContentConstant.subsidiDealerLabel,
                  fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                  fontFamily: FontFamily.bold),
            ),
            DeasyCustomElevatedButton(
              text: ContentConstant.download,
              primary: DeasyColor.kpYellow500,
              textColor: DeasyColor.neutral000,
              paddingButton: 10,
              borderColor: DeasyColor.kpYellow500,
              onPress: () => downloadTap(),
            ),
          ],
        ),
      ],
    );
  }
}
