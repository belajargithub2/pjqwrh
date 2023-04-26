import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_container_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/fab_bottom_app_bar.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';

class BumblebeeHomeContainerPage
    extends GetView<BumblebeeHomeContainerController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: Scaffold(
        body: Obx(
            () => controller.selectedWidget(controller.selectedIndex.value)),
        bottomNavigationBar: Obx(() => FABBottomAppBar(
              role: controller.role.value,
              centerItemText: controller.isNewWg.isTrue
                  ? ContentConstant.PENGAJUAN
                  : '${controller.isSnb.isTrue ? "Snap n Buy" : ""}',
              color: DeasyColor.neutral400,
              backgroundColor: DeasyColor.neutral000,
              selectedColor: DeasyColor.kpBlue200,
              selectedIndex: controller.selectedIndex.value,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (index) {
                controller.selectedFab(index);
              },
              items: listFABItem(),
            )),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(() => Visibility(
              visible: controller.isSnb.value,
              child: _buildFab(context),
            )),
      ),
    );
  }

  List<FABBottomAppBarItem> listFABItem() {
    if (controller.role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      return [
        FABBottomAppBarItem(
            iconData: "${IconConstant.RESOURCES_ICON_PATH}ic_home_selected.svg",
            text: 'Dashboard'),
        FABBottomAppBarItem(
            key: controller.keyOrder,
            iconData: "${IconConstant.RESOURCES_ICON_PATH}ic_order.svg",
            text: 'Order'),
        FABBottomAppBarItem(
            key: controller.keyDraft,
            iconData: "${IconConstant.RESOURCES_ICON_PATH}ic_draft.svg",
            text: 'Draft'),
      ];
    } else {
      return [
        FABBottomAppBarItem(
            iconData: "${IconConstant.RESOURCES_ICON_PATH}ic_home_selected.svg",
            text: 'Dashboard'),
        FABBottomAppBarItem(
            key: controller.keyTrans,
            iconData: "${IconConstant.RESOURCES_ICON_PATH}ic_transaction.svg",
            text: 'Transaksi'),
      ];
    }
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
        key: controller.keyFAB,
        elevation: 3,
        onPressed: () {
          controller.navigateToSnbOrNewwg();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [DeasyColor.dms005388, DeasyColor.dms2DB0E2]),
          ),
          child: Center(
            child: controller.isNewWg.isTrue
                ? Icon(Icons.add, color: DeasyColor.neutral000, size: 30.0)
                : Image.asset(
                    '${IconConstant.RESOURCES_ICON_PATH}ic_snap_n_buy_new.png'),
          ),
        ));
  }
}
