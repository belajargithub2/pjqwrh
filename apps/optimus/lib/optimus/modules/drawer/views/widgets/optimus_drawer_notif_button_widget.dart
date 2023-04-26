import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';

class OptimusDrawerNotifButtonAppbarWidget
    extends GetView<OptimusDrawerCustomController> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isNotif.value = true;
        controller.onTapMenu(context);
      },
      child: Stack(
        children: [
          Card(
              color: DeasyColor.kpBlue50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications_outlined,
                    color: DeasyColor.semanticInfo300),
              )),
          Obx(() => controller.countNotif.value != 0
              ? Positioned(
                  top: DeasySizeConfigUtils.blockVertical * 1.5,
                  right: DeasySizeConfigUtils.blockVertical * 1.5,
                  child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: DeasyColor.dmsF46363,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        controller.countNotif.value.toString(),
                        style: TextStyle(
                          fontSize: controller.countNotif.value > 999
                            ? 6
                            : 8,
                          color: DeasyColor.neutral000
                        ),
                      ))),
                )
              : SizedBox())
        ],
      ),
    );
  }
}
