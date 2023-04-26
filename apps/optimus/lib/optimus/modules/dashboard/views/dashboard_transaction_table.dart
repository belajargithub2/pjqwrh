import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/model/agent_orders_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/table_item_widget.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';

class DashboardTransactionTable extends GetView<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        width: controller.drawerBodyWidth.value,
        margin: EdgeInsets.only(top: DeasySizeConfigUtils.blockVertical * 5),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DeasySizeConfigUtils.blockVertical * 3,
              vertical: DeasySizeConfigUtils.blockVertical * 4),
          child: controller.isLoading.isTrue
              ? Container(
                  constraints: BoxConstraints(
                    minHeight: DeasySizeConfigUtils.screenHeight! / 1.1,
                  ),
                  child: FullScreenSpinner(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeasyTextView(
                          text: ContentConstant.transaction,
                          fontSize: DeasySizeConfigUtils.isTab ? 20 : 24,
                          fontFamily: FontFamily.bold,
                        ),
                        Spacer(),
                        DeasyPrimaryButton(
                          width: controller.drawerBodyWidth /
                              100 *
                              (DeasySizeConfigUtils.isTab ? 15 : 12),
                          text: ContentConstant.download,
                          textStyle: TextStyle(
                              fontSize: DeasySizeConfigUtils.isTab ? 14 : 18,
                              color: DeasyColor.neutral000,
                              fontWeight: FontWeight.w500),
                          suffixIcon: SvgPicture.asset(
                            IconConstant.RESOURCES_ICON_DOWNLOAD_TRANSACTION,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return downloadDialog();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 2),
                    Row(
                      children: [
                        Expanded(
                          child: DeasyTextForm.outlinedTextForm(
                            controller: controller
                                .textEditingTableSearchTransactionMerchantController,
                            labelText: null,
                            hintText: ContentConstant.search,
                            obscure: false,
                            readOnly: false,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.go,
                            suffixIcon: Icon(Icons.search,
                                color: DeasyColor.neutral400),
                            onChange: (value) {
                              controller.findTransaction(value);
                            },
                            onSubmitField: () {},
                          ),
                        ),
                        SizedBox(width: controller.drawerBodyWidth / 100 * 2),
                        buildStatusFilterButton(),
                        SizedBox(width: controller.drawerBodyWidth / 100 * 2),
                        buildDateFilterButton()
                      ],
                    ),
                    SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
                    Container(
                      width: controller.drawerBodyWidth.value / 2,
                      child: RawScrollbar(
                        thickness: 11,
                        isAlwaysShown: true,
                        thumbColor: DeasyColor.neutral400,
                        controller: controller.tableScrollController,
                        child: SingleChildScrollView(
                          controller: controller.tableScrollController,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dataRowHeight: 70,
                            columnSpacing: 36,
                            columns: <DataColumn>[
                              DataColumn(
                                label: DeasyTextView(
                                    text: "No",
                                    fontColor: DeasyColor.dms2DB0E2),
                              ),
                              DataColumn(
                                label: Row(children: [
                                  DeasyTextView(
                                      text: "Order ID",
                                      fontColor: DeasyColor.dms2DB0E2),
                                  SizedBox(
                                      width: controller.drawerBodyWidth /
                                          100 *
                                          1.2),
                                  IconButton(
                                      onPressed: () {
                                        controller.isProspectIdDesc.toggle();
                                        controller.sortingProspectId();
                                      },
                                      icon: SvgPicture.asset(
                                        "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                      ))
                                ]),
                              ),
                              DataColumn(
                                  label: Row(children: [
                                DeasyTextView(
                                    text: "Nama Konsumen",
                                    fontColor: DeasyColor.dms2DB0E2),
                                SizedBox(
                                    width:
                                        controller.drawerBodyWidth / 100 * 1.2),
                                IconButton(
                                    onPressed: () {
                                      controller.isCustomerNameDesc.toggle();
                                      controller.sortingCustomerName();
                                    },
                                    icon: SvgPicture.asset(
                                      "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                    ))
                              ])),
                              DataColumn(
                                label: controller.hasAdmin.isTrue
                                    ? Row(children: [
                                        DeasyTextView(
                                            text: "Nama Merchant",
                                            fontColor: DeasyColor.dms2DB0E2),
                                        SizedBox(
                                            width: controller.drawerBodyWidth /
                                                100 *
                                                1.2),
                                        IconButton(
                                            onPressed: () {
                                              controller.isMerchantNameDesc
                                                  .toggle();
                                              controller.sortingMerchantName();
                                            },
                                            icon: SvgPicture.asset(
                                              "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                            ))
                                      ])
                                    : SizedBox(),
                              ),
                              DataColumn(
                                  label: Row(children: [
                                DeasyTextView(
                                    text: "Harga OTR Product",
                                    fontColor: DeasyColor.dms2DB0E2),
                                SizedBox(
                                    width:
                                        controller.drawerBodyWidth / 100 * 1.2),
                                IconButton(
                                    onPressed: () {
                                      controller.isOtrDesc.toggle();
                                      controller.sortingOtr();
                                    },
                                    icon: SvgPicture.asset(
                                      "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                    ))
                              ])),
                              DataColumn(
                                  label: Row(children: [
                                DeasyTextView(
                                    text: "Tanggal Transaksi",
                                    fontColor: DeasyColor.dms2DB0E2),
                                SizedBox(
                                    width:
                                        controller.drawerBodyWidth / 100 * 1.2),
                                IconButton(
                                    onPressed: () {
                                      controller.isOrderDateDesc.toggle();
                                      controller.sortingOrderDate();
                                    },
                                    icon: SvgPicture.asset(
                                      "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                    ))
                              ])),
                              DataColumn(
                                  label: Row(children: [
                                DeasyTextView(
                                    text: "Status",
                                    fontColor: DeasyColor.dms2DB0E2),
                                SizedBox(
                                    width:
                                        controller.drawerBodyWidth / 100 * 1.2),
                                IconButton(
                                    onPressed: () {
                                      controller.isOrderStatusDesc.toggle();
                                      controller.sortingOrderStatus();
                                    },
                                    icon: SvgPicture.asset(
                                      "${IconConstant.RESOURCES_ICON_PATH}ic_btn_order_by.svg",
                                    ))
                              ])),
                              if (controller.documentAccessList
                                  .contains(ContentConstant.PO))
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.PO,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                              if (controller.documentAccessList
                                  .contains(ContentConstant.NOMOR_IMEI))
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.NOMOR_IMEI,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                              if (controller.documentAccessList
                                  .contains(ContentConstant.BUKTI_TERIMA))
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.BUKTI_TERIMA,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                              if (controller.documentAccessList
                                  .contains(ContentConstant.INVOICE))
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.INVOICE,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                              if (controller.documentAccessList
                                  .contains(ContentConstant.BAST))
                                DataColumn(
                                  label: DeasyTextView(
                                      text: ContentConstant.BAST,
                                      fontColor: DeasyColor.dms2DB0E2),
                                ),
                              DataColumn(
                                label: DeasyTextView(
                                    text: "Lacak",
                                    fontColor: DeasyColor.dms2DB0E2),
                              ),
                              DataColumn(
                                label: DeasyTextView(
                                    text: "Batal",
                                    fontColor: DeasyColor.dms2DB0E2),
                              ),
                            ],
                            rows: controller.transactionList
                                .asMap()
                                .entries
                                .map((item) {
                              var rowIndex = controller.transactionResponse
                                          .value.pageInfo?.page ==
                                      1
                                  ? item.key + 1
                                  : (item.key + 1) +
                                      (controller.transactionResponse.value
                                              .pageInfo!.prevPage! *
                                          10);
                              return DataRow(
                                cells: [
                                  DataCell(ItemTableWidget(
                                    title: "$rowIndex",
                                  )),
                                  DataCell(
                                    ItemTableWidget(
                                      title: item.value.prospectId,
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 130,
                                      child: ItemTableWidget(
                                        title: item.value.customerName,
                                      ),
                                    ),
                                  ),
                                  DataCell(Visibility(
                                    visible: controller.hasAdmin.isTrue ||
                                        controller
                                            .hasSelectMerchantAccess.isTrue,
                                    child: ItemTableWidget(
                                      title: item.value.supplierName,
                                    ),
                                  )),
                                  DataCell(ItemTableWidget(
                                    title: item.value.otr.toString().toRupiah(),
                                  )),
                                  DataCell(ItemTableWidget(
                                    title: item.value.orderDate
                                        .toString()
                                        .toFormattedDate(
                                            format: DateConstant.dateFormat2,
                                            convertToLocal: false),
                                  )),
                                  DataCell(
                                    ItemTableWidget(
                                      title: item.value.orderStatus.name,
                                      fontColor: formatStringStatus(
                                          item.value.orderStatus.id),
                                    ),
                                  ),
                                  if (controller.documentAccessList
                                      .contains(ContentConstant.PO))
                                    DataCell(ItemTableWidget(
                                      onPressedPreview: () =>
                                          controller.onPreview(
                                              ContentConstant.PO, item.value),
                                      onPressedUpload: () =>
                                          controller.onUpload(
                                              ContentConstant.PO, item.value),
                                      action: controller.action(
                                          ContentConstant.PO, item.value),
                                      isButton: true,
                                    )),
                                  if (controller.documentAccessList
                                      .contains(ContentConstant.NOMOR_IMEI))
                                    DataCell(ItemTableWidget(
                                      onPressedPreview: () =>
                                          controller.onPreview(
                                              ContentConstant.NOMOR_IMEI,
                                              item.value),
                                      onPressedUpload: () =>
                                          controller.onUpload(
                                              ContentConstant.NOMOR_IMEI,
                                              item.value),
                                      action: controller.action(
                                          ContentConstant.NOMOR_IMEI,
                                          item.value),
                                      isButton: true,
                                    )),
                                  if (controller.documentAccessList
                                      .contains(ContentConstant.BUKTI_TERIMA))
                                    DataCell(ItemTableWidget(
                                      isButton: true,
                                      onPressedPreview: () =>
                                          controller.onPreview(
                                              ContentConstant.BUKTI_TERIMA,
                                              item.value),
                                      onPressedUpload: () =>
                                          controller.onUpload(
                                              ContentConstant.BUKTI_TERIMA,
                                              item.value),
                                      action: controller.action(
                                          ContentConstant.BUKTI_TERIMA,
                                          item.value),
                                    )),
                                  if (controller.documentAccessList
                                      .contains(ContentConstant.INVOICE))
                                    DataCell(
                                      ItemTableWidget(
                                        isButton: true,
                                        onPressedPreview: () =>
                                            controller.onPreview(
                                                ContentConstant.INVOICE,
                                                item.value),
                                        onPressedUpload: () =>
                                            controller.onUpload(
                                                ContentConstant.INVOICE,
                                                item.value),
                                        action: controller.action(
                                            ContentConstant.INVOICE,
                                            item.value),
                                      ),
                                    ),
                                  if (controller.documentAccessList
                                      .contains(ContentConstant.BAST))
                                    DataCell(ItemTableWidget(
                                      isButton: true,
                                      title:
                                          item.value.otr.toString().toRupiah(),
                                      onPressedPreview: () =>
                                          controller.onPreview(
                                              ContentConstant.BAST, item.value),
                                      onPressedUpload: () =>
                                          controller.onUpload(
                                              ContentConstant.BAST, item.value),
                                      action: controller.action(
                                          ContentConstant.BAST, item.value),
                                    )),
                                  DataCell(
                                    controller.hasInfoAccess(item.value)
                                        ? Center(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    if (controller
                                                        .hasInfoAccess(
                                                            item.value)) {
                                                      controller
                                                          .onInfo(item.value);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.info_outline_rounded,
                                                    color:
                                                        DeasyColor.neutral900,
                                                  )),
                                            ),
                                          )
                                        : _noActionStripWidget(),
                                  ),
                                  DataCell(
                                    FutureBuilder<bool>(
                                      future: controller
                                          .isHasRequestCancelAccess(item.value),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<bool> snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data!
                                              ? Center(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (await controller
                                                            .isHasRequestCancelAccess(
                                                                item.value)) {
                                                          controller
                                                              .navigateToCancelRequest(
                                                                  item.value
                                                                      .prospectId);
                                                        }
                                                      },
                                                      child: Icon(Icons.close,
                                                          color: DeasyColor
                                                              .dmsF46363,
                                                          size: DeasySizeConfigUtils
                                                                  .blockHorizontal! *
                                                              1.5),
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(Icons.close,
                                                        color: DeasyColor
                                                            .neutral400,
                                                        size: DeasySizeConfigUtils
                                                                .blockHorizontal! *
                                                            1.5),
                                                  ),
                                                );
                                        } else {
                                          return Center(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(Icons.close,
                                                  color: DeasyColor.neutral400,
                                                  size: DeasySizeConfigUtils
                                                          .blockHorizontal! *
                                                      1.5),
                                            ),
                                          );
                                        }
                                      },
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
                      child: controller.transactionResponse.value.data == null
                          ? DeasyTextView(
                              text: ContentConstant.showZeroEntry, fontSize: 12)
                          : DataTablePaginator(
                              firstIndex:
                                  controller.transactionResponse.value.pageInfo?.page == 1
                                      ? 1
                                      : controller.transactionResponse.value
                                                  .pageInfo!.prevPage! *
                                              controller.limit.value +
                                          1,
                              lastIndex: controller.transactionResponse.value
                                          .pageInfo?.page ==
                                      controller.transactionResponse.value
                                          .pageInfo?.totalPage
                                  ? controller.transactionResponse.value
                                      .pageInfo?.totalRecord
                                  : controller.transactionResponse.value
                                          .pageInfo!.page! *
                                      controller.limit.value,
                              totalRecord: controller.transactionResponse.value
                                  .pageInfo?.totalRecord,
                              onBackClick: () {
                                if (controller.transactionResponse.value
                                        .pageInfo!.page !=
                                    controller.transactionResponse.value
                                        .pageInfo!.prevPage) {
                                  controller.fetchApiAllOrdersByPage(
                                      page: controller.transactionResponse.value
                                          .pageInfo!.prevPage);
                                }
                              },
                              onForwardClick: () {
                                if (controller.transactionResponse.value
                                        .pageInfo?.page !=
                                    controller.transactionResponse.value
                                        .pageInfo?.nextPage) {
                                  controller.fetchApiAllOrdersByPage(
                                      page: controller.transactionResponse.value
                                          .pageInfo?.nextPage);
                                }
                              },
                              onPageClick: (int page) {
                                controller.fetchApiAllOrdersByPage(page: page);
                              },
                              currentPage: controller.transactionResponse.value.pageInfo?.page,
                              lastPage: controller.transactionResponse.value.pageInfo?.totalPage),
                    ),
                    if ((controller.isOpenDateFilter.isTrue ||
                            controller.isOpenStatusFilter.isTrue) &&
                        controller.transactionList.length < 4)
                      SizedBox(height: 250)
                  ],
                ),
        ),
      ),
    );
  }

  downloadDialog() {
    double width = 328;

    return Dialog(
      backgroundColor: DeasyColor.neutral000,
      child: Container(
        height: 254,
        width: width,
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DeasyTextView(
                text: ContentConstant.downloadTransaction,
                fontSize: 24,
                textAlign: TextAlign.center,
                fontFamily: FontFamily.bold),
            SizedBox(height: 16),
            DeasyTextView(
              text: ContentConstant.reportMessage,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: width * 0.8,
              child: DeasyCustomButton(
                  text: ContentConstant.download,
                  radius: 8,
                  onPressed: () {
                    controller.generateExcel();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  buildStatusFilterButton() {
    return InkWell(
        onTap: () {
          controller.onClickStatusFilter();
        },
        child: Container(
            width: controller.drawerBodyWidth / 100 * 13,
            height: 52,
            margin: EdgeInsets.only(top: 15),
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
                child: Text(ContentConstant.selectStatus,
                    style: TextStyle(color: DeasyColor.kpYellow500)),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.keyboard_arrow_down_outlined,
                  color: DeasyColor.kpYellow500)
            ])));
  }

  buildDateFilterButton() {
    return InkWell(
        onTap: () {
          controller.onClickDateFilter();
        },
        child: Container(
            width: controller.drawerBodyWidth / 100 * 13,
            height: 52,
            margin: EdgeInsets.only(top: 15),
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
              Icon(Icons.date_range, color: DeasyColor.kpYellow500),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(ContentConstant.date,
                    style: TextStyle(color: DeasyColor.kpYellow500)),
              ),
            ])));
  }

  Color formatStringStatus(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return DeasyColor.dms2ED477;
      case "purchase confirmed":
        return DeasyColor.kpBlue500;
      case "canceled":
        return DeasyColor.neutral400;
      case "rejected":
        return DeasyColor.dmsF46363;
      case "cancel request":
        return DeasyColor.neutral900;
      case "on progress":
        return DeasyColor.kpYellow500;
      case "disbursed":
        return DeasyColor.sally900;
      default:
        return DeasyColor.dmsF46363;
    }
  }

  Widget _noActionStripWidget() {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 15,
          height: 3,
          margin: EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: DeasyColor.neutral400,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
