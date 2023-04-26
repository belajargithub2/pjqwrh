import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_list_tab_controller.dart';
import 'package:deasy_color/deasy_color.dart';

class ListUploadTabView extends GetView<UploadPhotoListTabController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close, color: DeasyColor.neutral900),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: DeasyColor.neutral000,
          title: Text("List Upload",
              style: TextStyle(
                  color: DeasyColor.neutral900, fontFamily: 'KBFGDisplayBold')),
          bottom: controller.isShowTab.isTrue
              ? TabBar(
                  indicatorColor: DeasyColor.kpBlue600,
                  labelColor: DeasyColor.kpBlue500,
                  unselectedLabelColor: DeasyColor.neutral400,
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 5.0, color: DeasyColor.kpBlue200),
                      insets: EdgeInsets.symmetric(horizontal: 40.0)),
                  controller: controller.tabController,
                  tabs: controller.tabViewLabelList)
              : null,
        ),
        body: controller.isShowTab.isTrue
            ? TabBarView(
                controller: controller.tabController,
                children: controller.tabViewChildList,
              )
            : controller.tabViewChildList.first));
  }
}
