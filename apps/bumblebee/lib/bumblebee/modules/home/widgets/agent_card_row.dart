import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/dashboard_card_widget.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgentCardRow extends GetView<BumblebeeHomePageController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      key: controller.keyInfo3,
      children: [
        Expanded(
          child: DashboardCardWidget(
            prefixIcon: SvgPicture.asset(
              "${IconConstant.RESOURCES_ICON_PATH}ic_submit_order.svg",
              fit: BoxFit.scaleDown,
              height: 35,
              width: 35,
            ),
            rightPosition: 4,
            circleWidth: DeasySizeConfigUtils.screenWidth! / 5,
            isBlue: true,
            text: ContentConstant.submitAgent,
            isSubmit: true,
            showButton: true,
          )
        ),
        Expanded(
          child: DashboardCardWidget(
            prefixIcon: SvgPicture.asset(
              "${IconConstant.RESOURCES_ICON_PATH}ic_agent_fee.svg",
              fit: BoxFit.scaleDown,
              height: 35,
              width: 35,
            ),
            rightPosition: 4,
            circleWidth: DeasySizeConfigUtils.screenWidth! / 5,
            isBlue: true,
            text: ContentConstant.agentFee,
            isSubmit: false,
            showButton: true,
          ),
        ),
      ],
    );
  }
}
