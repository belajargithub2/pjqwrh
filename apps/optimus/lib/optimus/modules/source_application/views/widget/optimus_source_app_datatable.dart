import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/controllers/optimus_source_application_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';

class OptimusSourceAppDataTable
    extends GetView<OptimusSourceApplicationController> {
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
                          text: MenuConstant.sourceApplication,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                          fontFamily: FontFamily.bold,
                          maxLines: 2),
                    ),
                    Spacer(),
                    DeasyPrimaryButton(
                      text: ContentConstant.addApplication,
                      onPressed: () {
                        controller.onCreateSourceApplication();
                      },
                      width: 180,
                      padding: EdgeInsets.only(left: 24),
                      leadIcon: Icon(Icons.add,
                          color: DeasyColor.neutral000, size: 20),
                    ),
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
                                      controller.fetchApiAllSourceApplications(
                                          sourceApplication:
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
                              columns: <DataColumn>[
                                DataColumn(
                                  label: DeasyTextView(
                                      text: "No",
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.sourceApplication,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                                DataColumn(
                                  label: Row(children: [
                                    DeasyTextView(
                                        text: ContentConstant.dateCreated,
                                        fontColor: DeasyColor.dms2DB0E2),
                                    SizedBox(
                                        width: DeasySizeConfigUtils
                                                .blockHorizontal! *
                                            1),
                                    IconButton(
                                      onPressed: () {
                                        controller.onOrderByCreatedAt();
                                      },
                                      icon: SvgPicture.asset(
                                          IconConstant.RESOURCES_ICON_ORDER_BY),
                                    )
                                  ]),
                                ),
                                DataColumn(
                                  label: Row(children: [
                                    DeasyTextView(
                                        text: ContentConstant.dateUpdated,
                                        fontColor: DeasyColor.dms2DB0E2),
                                    SizedBox(
                                        width: DeasySizeConfigUtils
                                                .blockHorizontal! *
                                            1),
                                    IconButton(
                                      onPressed: () {
                                        controller.onOrderByUpdatedAt();
                                      },
                                      icon: SvgPicture.asset(
                                          IconConstant.RESOURCES_ICON_ORDER_BY),
                                    )
                                  ]),
                                ),
                                DataColumn(
                                  label: DeasyTextView(text: ""),
                                ),
                              ],
                              rows: controller.sourceApplicationListResponse
                                      .value.listSourceAppData!.isEmpty
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
                                                fontFamily: FontFamily.medium),
                                          ),
                                          DataCell(
                                            Text(''),
                                          ),
                                        ],
                                      ),
                                    ]
                                  : controller.sourceApplicationListResponse
                                      .value.listSourceAppData!
                                      .asMap()
                                      .entries
                                      .map((item) {
                                      var rowIndex = controller
                                                  .sourceApplicationListResponse
                                                  .value
                                                  .pageInfo!
                                                  .page ==
                                              1
                                          ? item.key + 1
                                          : (item.key + 1) +
                                              (controller
                                                      .sourceApplicationListResponse
                                                      .value
                                                      .pageInfo!
                                                      .prevPage! * 10);
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            DeasyTextView(
                                              text: rowIndex.toString(),
                                              maxLines: 2,
                                            ),
                                          ),
                                          DataCell(
                                            DeasyTextView(
                                              text:
                                                  item.value.sourceApplication,
                                              maxLines: 2,
                                            ),
                                          ),
                                          DataCell(
                                            DeasyTextView(
                                              text: item.value.createdAt!
                                                  .toFormattedDate(
                                                      format: "dd MMMM yyyy",
                                                      locale: "id"),
                                              maxLines: 2,
                                            ),
                                          ),
                                          DataCell(
                                            DeasyTextView(
                                              text: item.value.updatedAt!
                                                  .toFormattedDate(
                                                      format: "dd MMMM yyyy",
                                                      locale: "id"),
                                              maxLines: 2,
                                            ),
                                          ),
                                          DataCell(
                                            Row(
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
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                          .onEdit(item.value);
                                                    }),
                                                SizedBox(width: 10),
                                                InkWell(
                                                    child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 14,
                                                                vertical: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: DeasyColor
                                                              .dmsFFF1F1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: SvgPicture.asset(
                                                          IconConstant
                                                              .RESOURCES_ICON_ORDER_CANCEL,
                                                        )),
                                                    onTap: () {
                                                      showDeleteConfirmationDialog(
                                                          context,
                                                          item.value.id,
                                                          item.value
                                                              .sourceApplication);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: controller.sourceApplicationListResponse.value.listSourceAppData ==
                                null
                            ? DeasyTextView(
                                text: ContentConstant.showZeroEntry,
                                fontSize: 12)
                            : DataTablePaginator(
                                firstIndex: controller.sourceApplicationListResponse.value.pageInfo!.page == 1
                                    ? 1
                                    : controller.sourceApplicationListResponse.value.pageInfo!.prevPage! *
                                            controller
                                                .sourceApplicationListResponse
                                                .value
                                                .pageInfo!
                                                .limit! +
                                        1,
                                lastIndex: controller.sourceApplicationListResponse.value.pageInfo!.page ==
                                        controller.sourceApplicationListResponse
                                            .value.pageInfo!.totalPage
                                    ? controller.sourceApplicationListResponse
                                        .value.pageInfo!.totalRecord
                                    : controller.sourceApplicationListResponse.value.pageInfo!.page! *
                                        controller.sourceApplicationListResponse.value.pageInfo!.limit!,
                                totalRecord: controller.sourceApplicationListResponse.value.pageInfo!.totalRecord,
                                onBackClick: () {
                                  if (controller.sourceApplicationListResponse
                                          .value.pageInfo!.page !=
                                      controller.sourceApplicationListResponse
                                          .value.pageInfo!.prevPage) {
                                    controller.fetchApiAllSourceApplications(
                                        page: controller
                                            .sourceApplicationListResponse
                                            .value
                                            .pageInfo!
                                            .prevPage);
                                  }
                                },
                                onForwardClick: () {
                                  if (controller.sourceApplicationListResponse
                                          .value.pageInfo!.page !=
                                      controller.sourceApplicationListResponse
                                          .value.pageInfo!.nextPage) {
                                    controller.fetchApiAllSourceApplications(
                                        page: controller
                                            .sourceApplicationListResponse
                                            .value
                                            .pageInfo!
                                            .nextPage);
                                  }
                                },
                                onPageClick: (int page) {
                                  controller.fetchApiAllSourceApplications(
                                      page: page);
                                },
                                currentPage: controller.sourceApplicationListResponse.value.pageInfo!.page,
                                lastPage: controller.sourceApplicationListResponse.value.pageInfo!.totalPage),
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
      menuNameTwo: MenuConstant.sourceApplication,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
    );
  }

  showDeleteConfirmationDialog(BuildContext context, String? id, String? name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: Colors.white,
              child: Container(
                height: DeasySizeConfigUtils.blockVertical * 45,
                width: DeasySizeConfigUtils.blockVertical * 45,
                margin: EdgeInsets.symmetric(
                    horizontal: DeasySizeConfigUtils.blockHorizontal! * 4,
                    vertical: DeasySizeConfigUtils.blockVertical * 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 2),
                    SvgPicture.asset(
                        'resources/images/icons/ic_dialog_ecommerce.svg'),
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                    DeasyTextView(
                      text: "Hapus Source Application $name",
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
                    DeasyTextView(
                        text: "Dengan ini Source Application ini akan dihapus",
                        fontSize: 16,
                        fontColor: DeasyColor.neutral400,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        maxLines: 5),
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: DeasyCustomButton(
                                text: "Hapus",
                                radius: 8,
                                onPressed: () {
                                  controller.deleteSourceApplicationById(id);
                                  Get.back();
                                })),
                        SizedBox(
                            width: DeasySizeConfigUtils.blockHorizontal! * 1.5),
                        Expanded(
                            child: DeasyPrimaryStrokedButton(
                          text: "Batalkan",
                          radius: 8,
                          onPressed: () {
                            Get.back();
                          },
                        ))
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
