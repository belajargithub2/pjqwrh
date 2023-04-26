import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/controllers/dealer_management_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';

class DealerDataTable extends GetView<DealerManagementController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  buildChannelFilterButton() {
    return InkWell(
        onTap: () {
          controller.openFilterContainer(FILTER.CHANNEL);
        },
        child: Container(
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: DeasyColor.neutral000,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: DeasyColor.kpYellow500,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Text(ContentConstant.selectChannel,
                    style: TextStyle(color: DeasyColor.kpYellow500)),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.keyboard_arrow_down_outlined,
                  color: DeasyColor.kpYellow500)
            ])));
  }

  buildSourceAppFilterButton() {
    return InkWell(
      onTap: () {
        controller.openFilterContainer(FILTER.SOURCE_APP);
      },
      child: Container(
          width: 205,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: DeasyColor.kpYellow500,
                style: BorderStyle.solid,
                width: 0.80),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Text(ContentConstant.selectSourceApp,
                  style: TextStyle(color: DeasyColor.kpYellow500)),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.keyboard_arrow_down_outlined,
                color: DeasyColor.kpYellow500)
          ])),
    );
  }

  buildConfirmationMethodFilterButton() {
    return InkWell(
      onTap: () {
        controller.openFilterContainer(FILTER.CONFIRMATION_METHOD);
      },
      child: Container(
          width: 205,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: DeasyColor.kpYellow500,
                style: BorderStyle.solid,
                width: 0.80),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Text(ContentConstant.selectMethodConfirm,
                  style: TextStyle(color: DeasyColor.kpYellow500)),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.keyboard_arrow_down_outlined,
                color: DeasyColor.kpYellow500)
          ])),
    );
  }

  Widget menuWidget() {
    return MenuWidgets.twoMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.dealerManagementLabel,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      notActiveColor: DeasyColor.kpYellow500,
      activeColor: DeasyColor.neutral400,
    );
  }

  buildChannelFilterContainer() {
    return Positioned(
      left: !DeasySizeConfigUtils.isMobile
          ? DeasySizeConfigUtils.screenWidth! * 0.017
          : DeasySizeConfigUtils.screenWidth! * 0.22,
      top: DeasySizeConfigUtils.screenHeight! / 4.5,
      child: Obx(() => Visibility(
            visible: controller.isOpenChannelFilter.isTrue &&
                    controller.channelList.length > 0
                ? true
                : false,
            child: Card(
              color: DeasyColor.neutral000,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ContentConstant.selectChannel,
                        style: TextStyle(color: DeasyColor.semanticInfo300)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.channelMap.keys.map((String? key) {
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: DeasyColor.kpYellow500,
                                  value: controller.channelMap[key],
                                  onChanged: (bool? value) {
                                    controller.onChangeChannelFilter(
                                        key, value);
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(key!),
                              ),
                            ],
                          );
                        }).toList()),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.kpYellow500,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.neutral000),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.onApplyFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Apply",
                                  style:
                                      TextStyle(color: DeasyColor.neutral000),
                                ),
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.neutral000,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.clearChannelFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Clear",
                                  style:
                                      TextStyle(color: DeasyColor.kpYellow500),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  buildSourceAppFilterContainer() {
    return Positioned(
      left: DeasySizeConfigUtils.screenWidth! * 0.137,
      top: DeasySizeConfigUtils.screenHeight! / 4.5,
      child: Obx(() => Visibility(
            visible: controller.isOpenSourceAppFilter.isTrue &&
                    controller.sourceAppList.length > 0
                ? true
                : false,
            child: Card(
              color: DeasyColor.neutral000,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ContentConstant.selectSourceApp,
                        style: TextStyle(color: DeasyColor.semanticInfo300)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            controller.sourceAppMap.keys.map((String? key) {
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: DeasyColor.kpYellow500,
                                  value: controller.sourceAppMap[key],
                                  onChanged: (bool? value) {
                                    controller.onChangeSourceAppFilter(
                                        key, value);
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(key!),
                              ),
                            ],
                          );
                        }).toList()),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.kpYellow500,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.neutral000),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.onApplyFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Apply",
                                  style:
                                      TextStyle(color: DeasyColor.neutral000),
                                ),
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.neutral000,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.clearSourceAppFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Clear",
                                  style:
                                      TextStyle(color: DeasyColor.kpYellow500),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  buildConfirmationMethodFilterContainer() {
    return Positioned(
      left: DeasySizeConfigUtils.screenWidth! * 0.292,
      top: DeasySizeConfigUtils.screenHeight! / 4.5,
      child: Obx(() => Visibility(
            visible: controller.isOpenConfirmationMethodFilter.isTrue &&
                    controller.confirmationMethodList.length > 0
                ? true
                : false,
            child: Card(
              color: DeasyColor.neutral000,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ContentConstant.selectMethodConfirm,
                        style: TextStyle(color: DeasyColor.semanticInfo300)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.confirmationMethodMap.keys
                            .map((String? key) {
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: DeasyColor.kpYellow500,
                                  value: controller.confirmationMethodMap[key],
                                  onChanged: (bool? value) {
                                    controller.onChangeConfirmationMethodFilter(
                                        key, value);
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(key!),
                              ),
                            ],
                          );
                        }).toList()),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.kpYellow500,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.neutral000),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.onApplyFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Apply",
                                  style:
                                      TextStyle(color: DeasyColor.neutral000),
                                ),
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.neutral000,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.clearConfirmationMethodFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Clear",
                                  style:
                                      TextStyle(color: DeasyColor.kpYellow500),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Obx(
      () => SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            menuWidget(),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                    child: DeasyTextView(
                        text: "Dealer Management",
                        fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                        fontFamily: FontFamily.bold))
              ],
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(24.0),
                          child: !DeasySizeConfigUtils.isMobile
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: TextField(
                                          controller:
                                              controller.searchController,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          onSubmitted: (searchValue) {
                                            controller.onSearchSubmitted(
                                                controller
                                                    .searchController.text);
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: controller
                                                    .isSearching.isTrue
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .searchController
                                                          .text = "";
                                                      controller.onSearchSubmitted(
                                                          controller
                                                              .searchController
                                                              .text);
                                                    },
                                                    icon: SvgPicture.asset(
                                                      "resources/images/icons/ic_clear.svg",
                                                      height: 18.0,
                                                      width: 18.0,
                                                    ),
                                                  )
                                                : Icon(Icons.search,
                                                    color:
                                                        DeasyColor.neutral400),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                              borderSide:
                                                  BorderSide(width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: DeasyColor.neutral400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: DeasyColor.neutral400),
                                            ),
                                            hintText: "Search",
                                            labelStyle: TextStyle(
                                                color: DeasyColor.neutral400,
                                                fontSize: DeasySizeConfigUtils
                                                        .blockVertical *
                                                    1.7),
                                          ),
                                          style: TextStyle(
                                              color: DeasyColor.neutral800,
                                              fontSize: DeasySizeConfigUtils
                                                      .blockVertical *
                                                  1.7),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    DeasyTextView(
                                      text: "Last Sync: " +
                                          controller.lastSyncDate.value,
                                      fontColor: DeasyColor.neutral400,
                                    ),
                                    SizedBox(width: 20),
                                    DeasyCustomElevatedButton(
                                      text: "Sync",
                                      primary: DeasyColor.kpYellow500,
                                      textColor: DeasyColor.neutral000,
                                      paddingButton: 10,
                                      borderColor: DeasyColor.kpYellow500,
                                      onPress: () {
                                        controller.syncDealers();
                                      },
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextField(
                                        controller: controller.searchController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        onSubmitted: (searchValue) {
                                          controller.onSearchSubmitted(
                                              controller.searchController.text);
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: controller
                                                  .isSearching.isTrue
                                              ? IconButton(
                                                  onPressed: () {
                                                    controller.searchController
                                                        .text = "";
                                                    controller.onSearchSubmitted(
                                                        controller
                                                            .searchController
                                                            .text);
                                                  },
                                                  icon: SvgPicture.asset(
                                                    "resources/images/icons/ic_clear.svg",
                                                    height: 18.0,
                                                    width: 18.0,
                                                  ),
                                                )
                                              : Icon(Icons.search,
                                                  color: DeasyColor.neutral400),
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
                                          hintText: "Search",
                                          labelStyle: TextStyle(
                                              color: DeasyColor.neutral400,
                                              fontSize: DeasySizeConfigUtils
                                                      .blockVertical *
                                                  1.7),
                                        ),
                                        style: TextStyle(
                                            color: DeasyColor.neutral800,
                                            fontSize: DeasySizeConfigUtils
                                                    .blockVertical *
                                                1.7),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    DeasyTextView(
                                      text: "Last Sync : 23/06/2021, 01:00",
                                      fontColor: DeasyColor.neutral400,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DeasyCustomElevatedButton(
                                            text: "Sync",
                                            primary: DeasyColor.kpYellow500,
                                            textColor: DeasyColor.neutral000,
                                            paddingButton: 10,
                                            borderColor: DeasyColor.kpYellow500,
                                            onPress: () {
                                              controller.syncDealers();
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                      !DeasySizeConfigUtils.isMobile
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  buildChannelFilterButton(),
                                  SizedBox(width: 20),
                                  buildSourceAppFilterButton(),
                                  SizedBox(width: 20),
                                  buildConfirmationMethodFilterButton()
                                ],
                              ))
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  buildChannelFilterButton(),
                                  SizedBox(height: 10),
                                  buildSourceAppFilterButton(),
                                  SizedBox(height: 10),
                                  buildConfirmationMethodFilterButton()
                                ],
                              ),
                            ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: RawScrollbar(
                              isAlwaysShown: true,
                              thumbColor: DeasyColor.neutral400,
                              controller: controller.tableScrollController,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: controller.tableScrollController,
                                  physics: ClampingScrollPhysics(),
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "No",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Dealer ID",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          DeasyTextView(
                                              text: "Dealer Group",
                                              fontColor:
                                                  DeasyColor.semanticInfo300),
                                          IconButton(
                                              onPressed: () {
                                                controller.isDescGroup.toggle();
                                                controller.orderGroup();
                                              },
                                              icon: Icon(
                                                  controller.isDescGroup.isTrue
                                                      ? Icons
                                                          .keyboard_arrow_down_outlined
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  color: DeasyColor.neutral600))
                                        ],
                                      )),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Dealer Name",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          DeasyTextView(
                                              text: "Branch",
                                              fontColor:
                                                  DeasyColor.semanticInfo300),
                                          IconButton(
                                              onPressed: () {
                                                controller.isDescBranch
                                                    .toggle();
                                                controller.orderBranch();
                                              },
                                              icon: Icon(
                                                  controller.isDescBranch.isTrue
                                                      ? Icons
                                                          .keyboard_arrow_down_outlined
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  color: DeasyColor.neutral600))
                                        ],
                                      )),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Email",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "No Handphone",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          DeasyTextView(
                                              text: "Channel",
                                              fontColor:
                                                  DeasyColor.semanticInfo300),
                                          IconButton(
                                              onPressed: () {
                                                controller.isDescChannel
                                                    .toggle();
                                                controller.orderChannel();
                                              },
                                              icon: Icon(
                                                  controller
                                                          .isDescChannel.isTrue
                                                      ? Icons
                                                          .keyboard_arrow_down_outlined
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  color: DeasyColor.neutral600))
                                        ],
                                      )),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Source App",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Metode Konfirmasi",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(text: ""),
                                      )
                                    ],
                                    rows: controller
                                        .dealerListResponse.value.merchantData!
                                        .asMap()
                                        .entries
                                        .map((data) {
                                      var rowIndex = controller
                                                  .dealerListResponse
                                                  .value
                                                  .pageInfo!
                                                  .page ==
                                              1
                                          ? data.key + 1
                                          : (data.key + 1) +
                                              (controller
                                                      .dealerListResponse
                                                      .value
                                                      .pageInfo!
                                                      .prevPage! *
                                                  controller.itemCount);
                                      return DataRow(
                                        cells: [
                                          DataCell(DeasyTextView(
                                            text: "$rowIndex",
                                            fontSize: DeasySizeConfigUtils
                                                    .blockVertical *
                                                1.6,
                                            maxLines: 2,
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller.copyText(
                                                  data.value.supplierId);
                                            },
                                            child: showDataCellText(
                                                data.value.supplierId!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller.copyText(
                                                  data.value.groupName);
                                            },
                                            child: showDataCellText(
                                                data.value.groupName!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller
                                                  .copyText(data.value.name);
                                            },
                                            child: showDataCellText(
                                                data.value.name!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller.copyText(
                                                  data.value.branchName);
                                            },
                                            child: showDataCellText(
                                                data.value.branchName!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller
                                                  .copyText(data.value.email);
                                            },
                                            child: showDataCellText(
                                                data.value.email!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller.copyText(
                                                  data.value.phoneNumber);
                                            },
                                            child: showDataCellText(
                                                data.value.phoneNumber!),
                                          )),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              controller
                                                  .copyText(data.value.channel);
                                            },
                                            child: showDataCellText(
                                                data.value.channel!),
                                          )),
                                          DataCell(TextButton(
                                              onPressed: () {
                                                String text = controller
                                                    .concatTextFromList(
                                                        true, data.value);
                                                controller.copyText(text);
                                              },
                                              child: data
                                                      .value
                                                      .sourceApplications!
                                                      .isEmpty
                                                  ? showDataCellText("")
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List<
                                                              Widget>.generate(
                                                          data
                                                              .value
                                                              .sourceApplications!
                                                              .length, (index) {
                                                        return Container(
                                                            child:
                                                                DeasyTextView(
                                                          text: data
                                                              .value
                                                              .sourceApplications![
                                                                  index]
                                                              .sourceApplication,
                                                          fontSize:
                                                              DeasySizeConfigUtils
                                                                      .blockVertical *
                                                                  1.6,
                                                          maxLines: 2,
                                                        ));
                                                      })))),
                                          DataCell(TextButton(
                                              onPressed: () {
                                                String text = controller
                                                    .concatTextFromList(
                                                        false, data.value);
                                                controller.copyText(text);
                                              },
                                              child: data
                                                      .value
                                                      .confirmationMethods!
                                                      .isEmpty
                                                  ? showDataCellText("")
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List<
                                                              Widget>.generate(
                                                          data
                                                              .value
                                                              .confirmationMethods!
                                                              .length, (index) {
                                                        return Container(
                                                            child:
                                                                DeasyTextView(
                                                          text: data
                                                              .value
                                                              .confirmationMethods![
                                                                  index]
                                                              .confirmationMethod,
                                                          fontSize:
                                                              DeasySizeConfigUtils
                                                                      .blockVertical *
                                                                  1.6,
                                                          maxLines: 2,
                                                        ));
                                                      })))),
                                          DataCell(InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: DeasyColor.neutral100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    size: 18,
                                                    color:
                                                        DeasyColor.neutral900),
                                              ),
                                              onTap: () {
                                                controller.navigateToEdit(
                                                    data.value.supplierId);
                                              })),
                                        ],
                                      );
                                    }).toList(),
                                  )))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: controller.dealerListResponse.value.merchantData ==
                                null
                            ? showEmptyPaginator()
                            : DataTablePaginator(
                                firstIndex: controller.dealerListResponse.value.pageInfo!.page == 1
                                    ? 1
                                    : controller.dealerListResponse.value.pageInfo!.prevPage! *
                                            controller.dealerListResponse.value
                                                .pageInfo!.limit! +
                                        1,
                                lastIndex: controller.dealerListResponse.value
                                            .pageInfo!.page ==
                                        controller.dealerListResponse.value
                                            .pageInfo!.totalPage
                                    ? controller.dealerListResponse.value
                                        .pageInfo!.totalRecord
                                    : controller.dealerListResponse.value.pageInfo!.page! *
                                        controller.dealerListResponse.value.pageInfo!.limit!,
                                totalRecord: controller.dealerListResponse.value.pageInfo!.totalRecord,
                                onBackClick: () {
                                  controller.onArrowClick(false);
                                },
                                onForwardClick: () {
                                  controller.onArrowClick(true);
                                },
                                onPageClick: (int page) {
                                  controller.fetchApiAllDealers(page: page);
                                },
                                currentPage: controller.dealerListResponse.value.pageInfo!.page,
                                lastPage: controller.dealerListResponse.value.pageInfo!.totalPage),
                      ),
                      SizedBox(height: controller.expandCardHeight.value),
                    ],
                  ),
                ),
                buildChannelFilterContainer(),
                buildSourceAppFilterContainer(),
                buildConfirmationMethodFilterContainer(),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget showEmptyPaginator() {
    return DeasyTextView(text: "Menampilkan 0 dari 0 entri", fontSize: 12);
  }

  Widget showDataCellText(String text) {
    return DeasyTextView(
      text: text.isNotEmpty ? text : "N/A",
      fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
      maxLines: 2,
    );
  }
}
