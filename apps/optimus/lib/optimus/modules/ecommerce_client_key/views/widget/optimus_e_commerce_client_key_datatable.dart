import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/controllers/optimus_e_commerce_client_key_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';

import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';

class OptimusECommerceClientKeyDataTable
    extends GetView<OptimusECommerceClientKeyWebController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Obx(() => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _menuWidget(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DeasyTextView(
                          text: MenuConstant.ecommerceClientKey,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                          fontFamily: FontFamily.bold),
                    ),
                    DeasyCustomElevatedButton(
                      text: ContentConstant.addData,
                      primary: DeasyColor.kpYellow500,
                      textColor: DeasyColor.neutral000,
                      paddingButton: 10,
                      borderColor: DeasyColor.kpYellow500,
                      onPress: () {
                        controller.onCreateECK();
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Container(
                                  width: 200,
                                  child: DeasyTextForm.outlinedTextForm(
                                    labelText: null,
                                    hintText: ContentConstant.search,
                                    controller: controller.searchController,
                                    obscure: false,
                                    readOnly: false,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.go,
                                    suffixIcon:
                                        controller.searchQuery.isNotEmpty
                                            ? IconButton(
                                                onPressed: () {
                                                  controller.onClear();
                                                },
                                                icon: SvgPicture.asset(
                                                  "resources/images/icons/ic_clear.svg",
                                                  height: 18.0,
                                                  width: 18.0,
                                                ),
                                              )
                                            : Icon(Icons.search,
                                                color: DeasyColor.neutral400),
                                    onSubmitField: () {
                                      controller.fetchApiAllClientKey(
                                          name:
                                              controller.searchController.text);
                                    },
                                  ),
                                )),
                          ),
                          if (!DeasySizeConfigUtils.isMobile) Spacer(),
                        ],
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
                                showBottomBorder: true,
                                columns: [
                                  DataColumn(
                                    label: DeasyTextView(
                                        text: "No",
                                        fontColor: DeasyColor.dms2DB0E2),
                                  ),
                                  DataColumn(
                                    label: Row(
                                      children: [
                                        DeasyTextView(
                                          text: ContentConstant.merchantName,
                                          fontColor: DeasyColor.dms2DB0E2,
                                        ),
                                        SizedBox(
                                            width: DeasySizeConfigUtils
                                                    .blockHorizontal! *
                                                1),
                                        IconButton(
                                            onPressed: () {
                                              controller.onOrderByName();
                                            },
                                            icon: SvgPicture.asset(IconConstant
                                                .RESOURCES_ICON_ORDER_BY))
                                      ],
                                    ),
                                  ),
                                  DataColumn(
                                    label: Row(
                                      children: [
                                        DeasyTextView(
                                          text: ContentConstant.dateCreated,
                                          fontColor: DeasyColor.dms2DB0E2,
                                        ),
                                        SizedBox(
                                            width: DeasySizeConfigUtils
                                                    .blockHorizontal! *
                                                1),
                                        IconButton(
                                            onPressed: () {
                                              controller.onOrderByCreatedAt();
                                            },
                                            icon: SvgPicture.asset(IconConstant
                                                .RESOURCES_ICON_ORDER_BY)),
                                      ],
                                    ),
                                  ),
                                  DataColumn(
                                    label: Row(
                                      children: [
                                        DeasyTextView(
                                            text: ContentConstant.dateUpdated,
                                            fontColor: DeasyColor.dms2DB0E2),
                                        SizedBox(
                                            width: DeasySizeConfigUtils
                                                    .blockHorizontal! *
                                                1),
                                        IconButton(
                                            onPressed: () {
                                              controller.onOrderByUpdateAt();
                                            },
                                            icon: SvgPicture.asset(IconConstant
                                                .RESOURCES_ICON_ORDER_BY))
                                      ],
                                    ),
                                  ),
                                  DataColumn(
                                    label: DeasyTextView(
                                        text: "",
                                        fontColor: DeasyColor.dms2DB0E2),
                                  ),
                                ],
                                rows: controller.eCommerceClientKeyListResponse
                                        .value.eCommerceClientKeyData!.isEmpty
                                    ? [
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Text(''),
                                            ),
                                            DataCell(
                                              Text(''),
                                            ),
                                            DataCell(
                                              DeasyTextView(
                                                  text: ContentConstant
                                                      .dataNotFound,
                                                  fontSize: DeasySizeConfigUtils
                                                          .blockVertical *
                                                      1.6,
                                                  maxLines: 3,
                                                  fontFamily:
                                                      FontFamily.medium),
                                            ),
                                            DataCell(
                                              Text(''),
                                            ),
                                            DataCell(
                                              Text(''),
                                            ),
                                          ],
                                        ),
                                      ]
                                    : controller.eCommerceClientKeyListResponse
                                        .value.eCommerceClientKeyData!
                                        .asMap()
                                        .entries
                                        .map((data) {
                                        var rowIndex = controller
                                                    .eCommerceClientKeyListResponse
                                                    .value
                                                    .pageInfo!
                                                    .page ==
                                                1
                                            ? data.key + 1
                                            : (data.key + 1) +
                                                (controller
                                                        .eCommerceClientKeyListResponse
                                                        .value
                                                        .pageInfo!
                                                        .prevPage! *
                                                    10);
                                        return DataRow(cells: [
                                          DataCell(
                                              DeasyTextView(text: "$rowIndex")),
                                          DataCell(DeasyTextView(
                                            text: data.value.name,
                                            maxLines: 3,
                                          )),
                                          DataCell(DeasyTextView(
                                              text: data.value.createdAt!
                                                  .toFormattedDate(
                                                      format: "dd MMM yyyy"))),
                                          DataCell(DeasyTextView(
                                              text: data.value.updatedAt!
                                                  .toFormattedDate(
                                                      format: "dd MMM yyyy"))),
                                          DataCell(Row(
                                            children: [
                                              InkWell(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: DeasyColor
                                                          .neutral100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Icon(
                                                        Icons
                                                            .remove_red_eye_outlined,
                                                        size: 18,
                                                        color: DeasyColor
                                                            .neutral900),
                                                  ),
                                                  onTap: () {
                                                    controller
                                                        .onEdit(data.value);
                                                  }),
                                              SizedBox(width: 10),
                                              InkWell(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 14,
                                                              vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: DeasyColor
                                                            .dmsFFF1F1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        IconConstant
                                                            .RESOURCES_ICON_ORDER_CANCEL,
                                                      )),
                                                  onTap: () {
                                                    controller.onDeleteECK(
                                                        data.value.supplierId,
                                                        data.value.name);
                                                  }),
                                            ],
                                          )),
                                        ]);
                                      }).toList(),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: controller.eCommerceClientKeyListResponse.value.eCommerceClientKeyData ==
                                null
                            ? DeasyTextView(
                                text: ContentConstant.showZeroEntry,
                                fontSize: 12)
                            : DataTablePaginator(
                                firstIndex: controller.eCommerceClientKeyListResponse.value.pageInfo!.page == 1
                                    ? 1
                                    : controller.eCommerceClientKeyListResponse.value.pageInfo!.prevPage! *
                                            controller
                                                .eCommerceClientKeyListResponse
                                                .value
                                                .pageInfo!
                                                .limit! +
                                        1,
                                lastIndex: controller.eCommerceClientKeyListResponse.value.pageInfo!.page ==
                                        controller
                                            .eCommerceClientKeyListResponse
                                            .value
                                            .pageInfo!
                                            .totalPage
                                    ? controller.eCommerceClientKeyListResponse
                                        .value.pageInfo!.totalRecord
                                    : controller.eCommerceClientKeyListResponse.value.pageInfo!.page! *
                                        controller.eCommerceClientKeyListResponse.value.pageInfo!.limit!,
                                totalRecord: controller.eCommerceClientKeyListResponse.value.pageInfo!.totalRecord,
                                onBackClick: () {
                                  if (controller.eCommerceClientKeyListResponse
                                          .value.pageInfo!.page !=
                                      controller.eCommerceClientKeyListResponse
                                          .value.pageInfo!.prevPage) {
                                    controller.fetchApiAllClientKey(
                                        page: controller
                                            .eCommerceClientKeyListResponse
                                            .value
                                            .pageInfo!
                                            .prevPage);
                                  }
                                },
                                onForwardClick: () {
                                  if (controller.eCommerceClientKeyListResponse
                                          .value.pageInfo!.page !=
                                      controller.eCommerceClientKeyListResponse
                                          .value.pageInfo!.nextPage) {
                                    controller.fetchApiAllClientKey(
                                        page: controller
                                            .eCommerceClientKeyListResponse
                                            .value
                                            .pageInfo!
                                            .nextPage);
                                  }
                                },
                                onPageClick: (int page) {
                                  controller.fetchApiAllClientKey(page: page);
                                },
                                currentPage: controller.eCommerceClientKeyListResponse.value.pageInfo!.page,
                                lastPage: controller.eCommerceClientKeyListResponse.value.pageInfo!.totalPage),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _menuWidget() {
    return MenuWidgets.twoMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.ecommerceClientKey,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
    );
  }
}
