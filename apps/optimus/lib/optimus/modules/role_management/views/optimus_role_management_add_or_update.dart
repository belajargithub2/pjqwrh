import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_circular_checkbox/deasy_circular_checkbox.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_switch/deasy_switch.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_add_or_update_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusRoleManagementAddOrUpdate
    extends GetView<OptimusRoleManagementAddOrUpdateController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      body: OptimusDrawerCustom(
        parentRoute: OptimusRoutes.ROLE_MANAGEMENT,
        body: Obx(() => Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              height: DeasySizeConfigUtils.screenHeight! / 1.1,
              child: ListView(
                primary: true,
                children: [
                  MenuWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: true,
                        child: GestureDetector(
                            child:
                                Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              Get.offNamed(OptimusRoutes.ROLE_MANAGEMENT);
                            }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      DeasyTextView(
                          text: controller.roleName.value,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                          fontFamily: FontFamily.bold),
                      Spacer(),
                      DeasyTextView(
                          text: "Status",
                          fontSize: DeasySizeConfigUtils.blockVertical * 2,
                          fontFamily: FontFamily.bold),
                      SizedBox(
                        width: 8,
                      ),
                      DeasySwitch(
                        transitionType: TextTransitionTypes.FADE,
                        rounded: true,
                        isClickable: controller.isEnable.value,
                        duration: Duration(milliseconds: 150),
                        forceWidth: true,
                        value: controller.isActive.value,
                        onChanged: (v) {
                          controller.changeStatus(v);
                        },
                        onText: "",
                        offText: "",
                        offBkColor: DeasyColor.neutral400,
                        onBkColor: DeasyColor.dms2ED477,
                        offThumbColor: DeasyColor.neutral000,
                        onThumbColor: DeasyColor.neutral000,
                        thumbSize: 20.0,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      DeasyTextView(
                          text: "Aktif",
                          fontSize: DeasySizeConfigUtils.blockVertical * 2,
                          fontFamily: FontFamily.bold),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                    color: DeasyColor.neutral000,
                    elevation: 1,
                    child: Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      padding: EdgeInsets.all(20),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Visibility(
                            visible: !controller.isUpdate.value,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: DeasyTextView(
                                      text: "Nama Role",
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              2,
                                      fontFamily: FontFamily.bold),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: TextField(
                                      controller: controller.nameController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: DeasyColor.neutral400),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: DeasyColor.neutral400),
                                        ),
                                        hintText: "Nama Role",
                                        labelStyle: TextStyle(
                                            color: DeasyColor.neutral400,
                                            fontSize: DeasySizeConfigUtils
                                                    .blockVertical *
                                                2),
                                      ),
                                      style: TextStyle(
                                          color: DeasyColor.neutral800,
                                          fontSize: DeasySizeConfigUtils
                                                  .blockVertical *
                                              2),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: DeasyTextView(
                                text: "Dashboard",
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2.5,
                                fontFamily: FontFamily.bold),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CardDashBoard(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: DeasyTextView(
                                text: "Menu",
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2.5,
                                fontFamily: FontFamily.bold),
                          ),
                          CardMenu(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(),
                          ),
                          DeasyTextView(
                              text: "Keterangan",
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 2.5,
                              fontFamily: FontFamily.bold),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: DeasyColor.dms2ED477,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                DeasyTextView(
                                    text: "Aktif",
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            1.8,
                                    fontFamily: FontFamily.medium),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: DeasyColor.neutral400,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                DeasyTextView(
                                    text: "Non Aktif",
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            1.8,
                                    fontFamily: FontFamily.medium)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(),
                                  flex: 7,
                                ),
                                DeasyCustomElevatedButton(
                                  text: "Submit",
                                  textColor: DeasyColor.neutral000,
                                  borderColor: DeasyColor.neutral000,
                                  primary: DeasyColor.kpYellow500,
                                  onPress: () {
                                    controller.submit();
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            if (controller.isLoading.isTrue) FullScreenSpinner()
          ],
        )),
      ),
    );
  }

  Widget MenuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.roleManagementLabel,
      menuNameThree: '${controller.roleName.value}',
      onTapMenuOne: () {
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      notActiveColor: DeasyColor.neutral800,
      activeColor: DeasyColor.semanticInfo300,
      onTapMenuTwo: () {
        Get.offNamed(OptimusRoutes.ROLE_MANAGEMENT);
      },
    );
  }

  Widget CardDashBoard() {
    return Container(
      height: DeasySizeConfigUtils.screenHeight! / 2.5,
      width: DeasySizeConfigUtils.screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    DeasyTextView(
                        text: "Dashboard",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasyCircularCheckBox(
                      checkedColor: DeasyColor.dms2ED477,
                      animationDuration: Duration(milliseconds: 150),
                      size: 20,
                      isEnable: controller.isEnable.value,
                      isChecked: controller.isOffline.value,
                      onTap: (value) {
                        controller.isOffline.value = value!;
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    DeasyTextView(
                        text: "Offline",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "PO",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isPO.value,
                      onChanged: (v) {
                        controller.isPO.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DeasyTextView(
                        text: "Bukti Terima",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Divider()
                  ],
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "View",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isBuktiTerimaView.value,
                      onChanged: (v) {
                        controller.isBuktiTerimaView.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "Upload",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isBuktiTerimaUpload.value,
                      onChanged: (v) {
                        controller.isBuktiTerimaUpload.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DeasyTextView(
                        text: "IMEI",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Divider()
                  ],
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "View",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isImeiView.value,
                      onChanged: (v) {
                        controller.isImeiView.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "Upload",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isImeiUpload.value,
                      onChanged: (v) {
                        controller.isImeiUpload.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "Request Cancel",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isRequestCancel.value,
                      onChanged: (v) {
                        controller.isRequestCancel.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    DeasyCircularCheckBox(
                      checkedColor: DeasyColor.dms2ED477,
                      animationDuration: Duration(milliseconds: 150),
                      size: 20,
                      isEnable: controller.isEnable.value,
                      isChecked: controller.isSNB.value,
                      onTap: (value) {
                        controller.isSNB.value = value!;
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    DeasyTextView(
                        text: "Snap and Buy",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasyCircularCheckBox(
                      checkedColor: DeasyColor.dms2ED477,
                      animationDuration: Duration(milliseconds: 150),
                      size: 20,
                      isEnable: controller.isEnable.value,
                      isChecked: controller.isOnline.value,
                      onTap: (value) {
                        controller.isOnline.value = value!;
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    DeasyTextView(
                        text: "Online",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "Invoice",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isInvoice.value,
                      onChanged: (v) {
                        controller.isInvoice.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                if (controller.isShowBast.isTrue) bastColumnWidget(),
                SizedBox(
                  height: controller.isShowBast.isTrue
                    ? DeasySizeConfigUtils.blockVertical * 18
                    : DeasySizeConfigUtils.blockVertical * 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CardMenu() {
    return Container(
      height: DeasySizeConfigUtils.screenHeight! / 3,
      width: DeasySizeConfigUtils.screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DeasyTextView(
                          text: "Source Application",
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                          fontFamily: FontFamily.medium),
                    ),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isSourceApp.value,
                      onChanged: (v) {
                        controller.isSourceApp.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: DeasyTextView(
                            text: "E Commerce Client Key",
                            overflow: TextOverflow.clip,
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            fontFamily: FontFamily.medium)),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isEKey.value,
                      onChanged: (v) {
                        controller.isEKey.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DeasyTextView(
                        text: "Callback",
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                        fontFamily: FontFamily.medium),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isCallback.value,
                      onChanged: (v) {
                        controller.isCallback.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: DeasyTextView(
                            text: "Role Management",
                            overflow: TextOverflow.clip,
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            fontFamily: FontFamily.medium)),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isRoleM.value,
                      onChanged: (v) {
                        controller.isRoleM.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: DeasyTextView(
                            text: "Dealer Management",
                            overflow: TextOverflow.clip,
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                            fontFamily: FontFamily.medium)),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isDelaerM.value,
                      onChanged: (v) {
                        controller.isDelaerM.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: DeasyTextView(
                            text: "Merchant User Management",
                            overflow: TextOverflow.clip,
                            fontSize:
                                DeasySizeConfigUtils.blockVertical * 1.8,
                            fontFamily: FontFamily.medium)),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isMerchantUserM.value,
                      onChanged: (v) {
                        controller.isMerchantUserM.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DeasyTextView(
                          text: "User Management",
                          overflow: TextOverflow.clip,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                          fontFamily: FontFamily.medium),
                    ),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isUserM.value,
                      onChanged: (v) {
                        controller.isUserM.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                if (flavorConfiguration!.flavorName == "dev")
                Row(
                  children: [
                    Expanded(
                      child: DeasyTextView(
                          text: "Subsidi Dealer",
                          overflow: TextOverflow.clip,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                          fontFamily: FontFamily.medium),
                    ),
                    Spacer(),
                    DeasySwitch(
                      transitionType: TextTransitionTypes.FADE,
                      rounded: true,
                      isClickable: controller.isEnable.value,
                      duration: Duration(milliseconds: 150),
                      forceWidth: true,
                      value: controller.isSubsidiDealer.value,
                      onChanged: (v) {
                        controller.isSubsidiDealer.value = v;
                      },
                      onText: "",
                      offText: "",
                      offBkColor: DeasyColor.neutral400,
                      onBkColor: DeasyColor.dms2ED477,
                      offThumbColor: DeasyColor.neutral000,
                      onThumbColor: DeasyColor.neutral000,
                      thumbSize: 20.0,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                SizedBox(
                  height: flavorConfiguration!.flavorName == "dev"
                    ? DeasySizeConfigUtils.blockVertical * 9.6
                    : DeasySizeConfigUtils.blockVertical * 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bastColumnWidget() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DeasyTextView(
                text: "BAST",
                fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                fontFamily: FontFamily.medium),
            Divider()
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            DeasyTextView(
                text: "View",
                fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                fontFamily: FontFamily.medium),
            Spacer(),
            DeasySwitch(
              transitionType: TextTransitionTypes.FADE,
              rounded: true,
              isClickable: controller.isEnable.value,
              duration: Duration(milliseconds: 150),
              forceWidth: true,
              value: controller.isBastView.value,
              onChanged: (v) {
                controller.isBastView.value = v;
              },
              onText: "",
              offText: "",
              offBkColor: DeasyColor.neutral400,
              onBkColor: DeasyColor.dms2ED477,
              offThumbColor: DeasyColor.neutral000,
              onThumbColor: DeasyColor.neutral000,
              thumbSize: 20.0,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            DeasyTextView(
                text: "Upload",
                fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
                fontFamily: FontFamily.medium),
            Spacer(),
            DeasySwitch(
              transitionType: TextTransitionTypes.FADE,
              rounded: true,
              isClickable: controller.isEnable.value,
              duration: Duration(milliseconds: 150),
              forceWidth: true,
              value: controller.isBastUpload.value,
              onChanged: (v) {
                controller.isBastUpload.value = v;
              },
              onText: "",
              offText: "",
              offBkColor: DeasyColor.neutral400,
              onBkColor: DeasyColor.dms2ED477,
              offThumbColor: DeasyColor.neutral000,
              onThumbColor: DeasyColor.neutral000,
              thumbSize: 20.0,
            ),
          ],
        ),
      ],
    );
  }
}
