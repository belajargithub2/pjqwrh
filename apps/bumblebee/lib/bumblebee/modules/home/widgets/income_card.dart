import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class IncomeCard extends GetView<BumblebeeHomePageController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: DeasySizeConfigUtils.screenHeight! * 0.02,
      ),
      child: Card(
        key: controller.keyInfo4,
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: DeasyColor.neutral000,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [DeasyColor.dms005388, DeasyColor.dms2DB0E2]),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "${ImageConstant.RESOURCES_IMAGES_PATH}default_avatar.png",
                      height: DeasySizeConfigUtils.blockVertical * 3.5,
                      width: DeasySizeConfigUtils.blockVertical * 3.5,
                    ),
                  ),
                  SizedBox(width: 20),
                  Obx(() => Text("Hi, ${controller.name}",
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.35,
                          fontFamily: 'KBFGDisplayBold',
                          color: Colors.white))),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(controller.stringAplikanInfo.value,
                            style: TextStyle(
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 1.8,
                                fontFamily: 'KBFGDisplayLight',
                                color: DeasyColor.neutral000)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Text(
                          controller.countTransaction.value.toString(),
                          style: TextStyle(
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 2.5,
                              fontFamily: 'KBFGDisplayBold',
                              color: DeasyColor.neutral000))),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => Text(controller.stringIncomeInfo.value,
                            style: TextStyle(
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 1.8,
                                fontFamily: 'KBFGDisplayLight',
                                color: DeasyColor.neutral000)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Text(
                          "${controller.totalOrder.value.toString().toRupiah()}",
                          style: TextStyle(
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 2.5,
                              fontFamily: 'KBFGDisplayBold',
                              color: DeasyColor.neutral000))),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
