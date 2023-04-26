import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_filter_date_container_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_filter_status_dropdown_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_summary_subsidi_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_search_filter_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_table_subsidi_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusSubsidiDealerWebView
    extends GetView<OptimusSubsidiDealerTableController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: DeasySizeConfigUtils.screenHeight,
      child: SingleChildScrollView(
        controller: controller.pageScrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OptimusMenuWidget(
              downloadTap: () => controller.download(),
            ),
            SizedBox(height: 40),
            Card(
              color: DeasyColor.neutral000,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //Web Content Here
                  children: [
                    //Search & Filter Section
                    OptimusSearchFilterWidget(),
                    Stack(
                      children: [
                        //Summary Subsidi & Table Section
                        Obx(
                          () => Column(
                            children: [
                              //Summary Subsidi Section
                              OptimusSummarySubsidiWidget(),

                              //Table Subsidi Section
                              controller.subsidiList.isEmpty
                                  ? SizedBox(height: 200)
                                  : Column(
                                      children: [
                                        OptimusTableSubsidiWidget(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          child: controller.subsidies.value!
                                                      .pageInfo ==
                                                  null
                                              ? DeasyTextView(
                                                  text: ContentConstant
                                                      .showZeroEntry,
                                                  fontSize: 12)
                                              : DataTablePaginator(
                                                  firstIndex: controller
                                                      .getFirstIndex(),
                                                  lastIndex: controller
                                                      .getTotalIndex(),
                                                  totalRecord: controller
                                                      .getTotalRecord(),
                                                  onBackClick: () {
                                                    controller.onBackClick();
                                                  },
                                                  onForwardClick: () {
                                                    controller.onForwardClick();
                                                  },
                                                  onPageClick: (int page) {
                                                    controller.fetchAllSubsidi(
                                                        pageNumber: page);
                                                  },
                                                  currentPage: controller
                                                      .subsidies
                                                      .value!
                                                      .pageInfo!
                                                      .page,
                                                  lastPage: controller
                                                      .subsidies
                                                      .value!
                                                      .pageInfo!
                                                      .totalPage),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        //FilterDateDialog
                        Positioned(
                          right: 8,
                          child: OptimusFilterDateContainerWidget(),
                        ),
                        Positioned(
                          right: DeasySizeConfigUtils.screenWidth! * 0.16,
                          child: OptimusFilterStatusDropdownWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
