import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/automail/widgets/optimus_automail_datatable.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';

class OptimusAutomailWebOrDesktop extends GetView<OptimusAutomailController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      child: Card(
        color: DeasyColor.neutral000,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _searchWidget(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: DeasyCustomElevatedButton(
                        text: ContentConstant.automailAddRecipient,
                        primary: DeasyColor.kpYellow500,
                        textColor: DeasyColor.neutral000,
                        paddingButton: 10,
                        borderColor: DeasyColor.kpYellow500,
                        onPress: () => controller.showDialogAddRecipient(),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => OptimusAutomailDatatable(
                  list: controller.recipients.value?.data ?? [],
                  pageInfo: controller.recipients.value!.pageInfo,
                ),
              ),
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Obx(
                  () => controller.recipients.value!.pageInfo == null
                      ? DeasyTextView(
                          text: ContentConstant.tablePaginationEmpty,
                          fontSize: 12)
                      : DataTablePaginator(
                          firstIndex:
                              controller.recipients.value!.pageInfo!.page == 1
                                  ? 1
                                  : controller.recipients.value!.pageInfo!
                                              .prevPage *
                                          controller.recipients.value!.pageInfo!
                                              .limit +
                                      1,
                          lastIndex: controller
                                      .recipients.value!.pageInfo!.page ==
                                  controller
                                      .recipients.value!.pageInfo!.totalPage
                              ? controller
                                  .recipients.value!.pageInfo!.totalRecord
                              : controller.recipients.value!.pageInfo!.page *
                                  controller.recipients.value!.pageInfo!.limit,
                          totalRecord: controller
                              .recipients.value!.pageInfo!.totalRecord,
                          onBackClick: () {
                            if (controller.recipients.value!.pageInfo!.page !=
                                controller
                                    .recipients.value!.pageInfo!.prevPage) {
                              controller.fetchAllRecipients(
                                  page: controller
                                      .recipients.value!.pageInfo!.prevPage);
                            }
                          },
                          onForwardClick: () {
                            if (controller.recipients.value!.pageInfo!.page !=
                                controller
                                    .recipients.value!.pageInfo!.nextPage) {
                              controller.fetchAllRecipients(
                                  page: controller
                                      .recipients.value!.pageInfo!.nextPage);
                            }
                          },
                          onPageClick: (int page) {
                            controller.fetchAllRecipients(page: page);
                          },
                          currentPage:
                              controller.recipients.value!.pageInfo!.page,
                          lastPage:
                              controller.recipients.value!.pageInfo!.totalPage),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: controller.searchController,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: (value) {
          controller.onSubmitSearch(value);
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: DeasyColor.neutral400,
              size: 20,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DeasyColor.neutral400),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DeasyColor.neutral400),
          ),
          hintText: ContentConstant.search,
          labelStyle: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.7),
        ),
        style: TextStyle(
            color: DeasyColor.neutral800,
            fontSize: DeasySizeConfigUtils.blockVertical * 1.7),
      ),
    );
  }
}
