import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/model/side_menu/side_menu_model.dart';
import 'package:deasy_color/deasy_color.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class OptimusDrawerItemMenu extends StatelessWidget {
  RxBool? isOpened = false.obs;
  Function? hiddenAppbar;
  String parentRoute;
  SideMenuModel? item = SideMenuModel();

  OptimusDrawerItemMenu(
      {this.isOpened, this.item, this.hiddenAppbar, this.parentRoute = ""});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return item!.child == null ? listTile(item!) : expandTile(item!);
  }

  Widget expandTile(SideMenuModel item) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: Get.currentRoute.isContainIgnoreCase(item.title!),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SvgPicture.asset(
                item.icon!,
                width: DeasySizeConfigUtils.isTab
                    ? DeasySizeConfigUtils.screenWidth! * 0.02
                    : DeasySizeConfigUtils.screenWidth! * 0.03,
                height: DeasySizeConfigUtils.isTab
                    ? DeasySizeConfigUtils.screenHeight! * 0.02
                    : DeasySizeConfigUtils.screenHeight! * 0.03,
              ),
            ),
            Obx(
              () => Visibility(
                visible: isOpened!.isTrue && !DeasySizeConfigUtils.isMobile
                    ? true
                    : false,
                child: Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: DeasySizeConfigUtils.isTab ? 4.0 : 1.0),
                    child: Text(
                      '${item.title}',
                      style: TextStyle(
                          color: DeasyColor.neutral000,
                          fontSize: DeasySizeConfigUtils.isTab
                              ? DeasySizeConfigUtils.blockVertical * 1.3
                              : DeasySizeConfigUtils.blockVertical * 1.8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        children: item.child!.map((e) => listTile(e)).toList(),
      ),
    );
  }

  Widget listTile(SideMenuModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Get.currentRoute == item.route || item.route == parentRoute
            ? DeasyColor.dms0096D0
            : null,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isOpened!.isTrue ? 2 : 1,
              child: SvgPicture.asset(
                item.icon!,
                width: DeasySizeConfigUtils.screenWidth! * 0.03,
                height: DeasySizeConfigUtils.screenHeight! * 0.03,
              ),
            ),
            SizedBox(width: 10,),
            Obx(
              () => Visibility(
                visible: isOpened!.isTrue && !DeasySizeConfigUtils.isMobile
                    ? true
                    : false,
                child: Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: Text(
                      '${item.title}',
                      style: TextStyle(
                          color: DeasyColor.neutral000,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.7),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (Get.currentRoute != item.route) {
            hiddenAppbar!();
            Get.back();
            Get.offNamed(item.route!);
          }
        },
      ),
    );
  }
}
