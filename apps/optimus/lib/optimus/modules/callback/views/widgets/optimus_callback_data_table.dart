import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/controllers/optimus_callback_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';

class OptimusCallbackDataTable extends GetView<OptimusCallbackController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

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
            _menuWidget(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DeasyTextView(
                      text: MenuConstant.callbacks,
                      fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                      fontFamily: FontFamily.bold),
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
                  Row(children: [
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
                              suffixIcon: controller.searchQuery.isNotEmpty
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
                                controller.onSearch(
                                    controller.searchController.value.text);
                              },
                            ),
                          )),
                    ),
                    if (!DeasySizeConfigUtils.isMobile) Spacer(),
                  ]),
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
                                      fontColor: DeasyColor.kpBlue400),
                                ),
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.status,
                                      fontColor: DeasyColor.kpBlue400),
                                ),
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.dateCreated,
                                      fontColor: DeasyColor.kpBlue400),
                                ),
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.prospectId,
                                      fontColor: DeasyColor.kpBlue400),
                                ),
                                if (flavorConfiguration!.flavorName !=
                                    "sandbox")
                                  DataColumn(
                                    label: DeasyTextView(
                                        text: ContentConstant.sourceApplication,
                                        fontColor: DeasyColor.kpBlue400),
                                  ),
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.orderStatus,
                                      fontColor: DeasyColor.kpBlue400),
                                ),
                                DataColumn(
                                  label: DeasyTextView(text: ""),
                                ),
                              ],
                              rows: controller.callbackList.isEmpty
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
                                            Text(ContentConstant.dataNotFound),
                                          ),
                                          DataCell(
                                            Text(''),
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
                                  : controller.callbackList
                                      .asMap()
                                      .entries
                                      .map((data) {
                                      var rowIndex =
                                          controller.pageInfo.value!.page == 1
                                              ? data.key + 1
                                              : (data.key + 1) +
                                                  (controller.pageInfo.value!
                                                          .prevPage! *
                                                      10);
                                      return DataRow(
                                        cells: [
                                          DataCell(DeasyTextView(
                                            text: "$rowIndex",
                                            maxLines: 2,
                                          )),
                                          DataCell(data.value
                                                          .merchantStatusCode ==
                                                      null ||
                                                  data.value
                                                          .merchantStatusCode ==
                                                      0
                                              ? DeasyTextView(
                                                  text: "-",
                                                  maxLines: 2,
                                                )
                                              : DeasyTextView(
                                                  text: data
                                                      .value.merchantStatusCode
                                                      .toString(),
                                                  maxLines: 2,
                                                )),
                                          DataCell(
                                            DeasyTextView(
                                              text: data.value.createdAt!
                                                  .toFormattedDate(
                                                      format: DateConstant
                                                          .dateFormat6),
                                              maxLines: 2,
                                            ),
                                          ),
                                          DataCell(
                                            DeasyTextView(
                                              text: data.value.prospectId,
                                              maxLines: 2,
                                            ),
                                          ),
                                          if (flavorConfiguration!.flavorName !=
                                              "sandbox")
                                            DataCell(
                                              data.value.sourceApplication ==
                                                      null
                                                  ? DeasyTextView(
                                                      text: "-",
                                                      maxLines: 2,
                                                    )
                                                  : DeasyTextView(
                                                      text: data.value
                                                          .sourceApplication,
                                                      maxLines: 2,
                                                    ),
                                            ),
                                          DataCell(formatStringStatus(
                                              data.value.orderStatus)),
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
                                                    Get.toNamed(
                                                        OptimusRoutes
                                                            .CALLBACK_DETAIL,
                                                        parameters: {
                                                          "prospect_id":
                                                              "${data.value.prospectId}",
                                                        });
                                                  }),
                                              SizedBox(width: 10),
                                              if (data.value
                                                          .merchantStatusCode !=
                                                      200 &&
                                                  data.value
                                                          .merchantStatusCode !=
                                                      404)
                                                InkWell(
                                                  child: SvgPicture.asset(
                                                    IconConstant
                                                        .RESOURCES_ICON_RESEND_CALLBACK,
                                                    height: 35.0,
                                                  ),
                                                  onTap: () {
                                                    if (data.value
                                                                .merchantStatusCode !=
                                                            200 &&
                                                        data.value
                                                                .merchantStatusCode !=
                                                            404) {
                                                      controller.resendCallback(
                                                          data.value
                                                              .prospectId);
                                                    }
                                                  },
                                                )
                                            ],
                                          ))
                                        ],
                                      );
                                    }).toList(),
                            ),
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: controller.callbackList.isEmpty
                        ? DeasyTextView(
                            text: ContentConstant.showZeroEntry, fontSize: 12)
                        : DataTablePaginator(
                            firstIndex: controller.pageInfo.value!.page == 1
                                ? 1
                                : controller.pageInfo.value!.prevPage! *
                                        controller.pageInfo.value!.limit! +
                                    1,
                            lastIndex: controller.pageInfo.value!.page ==
                                    controller.pageInfo.value!.totalPage
                                ? controller.pageInfo.value!.totalRecord
                                : controller.pageInfo.value!.page! *
                                    controller.pageInfo.value!.limit!,
                            totalRecord: controller.pageInfo.value!.totalRecord,
                            onBackClick: () {
                              controller.onBack();
                            },
                            onForwardClick: () {
                              controller.onForward();
                            },
                            onPageClick: (int page) {
                              controller.fetchApiAllCallbacks(page: page);
                            },
                            currentPage: controller.pageInfo.value!.page,
                            lastPage: controller.pageInfo.value!.totalPage),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Dialog resendCallbackDialog(bool isSuccess) {
    return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 220,
            width: 328,
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSuccess
                    ? SvgPicture.asset(
                        IconConstant.RESOURCES_ICON_CHECK,
                        width: 40,
                        height: 40,
                      )
                    : SvgPicture.asset(
                        IconConstant.RESOURCES_ICON_NONACTIVE,
                        width: 40,
                        height: 40,
                      ),
                SizedBox(height: 29),
                isSuccess
                    ? DeasyTextView(
                        text: ContentConstant.success,
                        fontSize: 24,
                        fontFamily: FontFamily.bold)
                    : DeasyTextView(
                        text: ContentConstant.failed,
                        fontSize: 24,
                        fontFamily: FontFamily.bold),
                SizedBox(height: 25.0),
                isSuccess
                    ? DeasyTextView(
                        text: ContentConstant.successMessage,
                        fontColor: DeasyColor.neutral400)
                    : DeasyTextView(
                        text: ContentConstant.failedMessage,
                        fontColor: DeasyColor.neutral400),
                SizedBox(height: 23.0),
                DeasyPrimaryButton(
                    text: ContentConstant.close,
                    width: double.infinity,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        }));
  }

  Widget _menuWidget() {
    return MenuWidgets.twoMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.callbacks,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
    );
  }

  Widget formatStringStatus(String? status) {
    switch (status) {
      case ContentConstant.STATUS_APPROVED:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.dms2ED477,
        );
      case ContentConstant.STATUS_PURCHASE_CONFIRMED:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.kpBlue500,
        );
      case ContentConstant.STATUS_CANCELED:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.dmsF46363,
        );
      case ContentConstant.STATUS_REJECT:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.dmsF46363,
        );
      case ContentConstant.STATUS_CANCEL_REQUEST:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.neutral400,
        );
      case ContentConstant.STATUS_ON_PROGRESS:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.kpYellow500,
        );
      case ContentConstant.STATUS_DISBURSED:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.sally900,
        );
      default:
        return DeasyTextView(
          text: status,
          maxLines: 2,
          fontColor: DeasyColor.dmsF46363,
        );
    }
  }
}
