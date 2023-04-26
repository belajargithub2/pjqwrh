import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/views/widgets/optimus_role_management_datatable.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_get_all_role_response.dart';

class OptimusAutomailTab extends GetView<OptimusRoleManagementController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      child: Card(
        color: DeasyColor.neutral000,
        elevation: 1,
        child: Container(
          margin: EdgeInsets.all(20),
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
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: DeasyCustomElevatedButton(
                        text: "Tambah Role",
                        primary: DeasyColor.kpYellow500,
                        textColor: DeasyColor.neutral000,
                        paddingButton: 10,
                        borderColor: DeasyColor.kpYellow500,
                        onPress: () {
                          Get.toNamed(
                                  OptimusRoutes.ROLE_MANAGEMENT_ADD_OR_UPDATE)!
                              .then((value) {
                            controller.fetchApiGetAllRoles();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              OptimusRoleManagementDatatable(
                list: controller.responseGetAllRole.value.data,
                onOrderByStatus: () {
                  controller.isStatusDesc.toggle();
                  controller.sortingStatus();
                },
                onOrderByCreatedAt: () {
                  controller.isCreatedAtDesc.toggle();
                  controller.sortingCreatedAt();
                },
                onOrderByUpdateAt: () {
                  controller.isUpdateAtDesc.toggle();
                  controller.sortingUpdateAt();
                },
                pageInfo: controller.responseGetAllRole.value.pageInfo,
                onEdit: (RoleManagementData data) {
                  Get.toNamed(OptimusRoutes.ROLE_MANAGEMENT_ADD_OR_UPDATE,
                          parameters: {
                        "type": "edit",
                        "role_id": data.id!,
                      })!
                      .then((value) {
                    controller.fetchApiGetAllRoles();
                  });
                },
              ),
              Container(
                width: DeasySizeConfigUtils.screenWidth,
                child: Obx(
                  () => controller.responseGetAllRole.value.data == null
                      ? DeasyTextView(
                          text: "Showing 0 to 0 entries", fontSize: 12)
                      : DataTablePaginator(
                          firstIndex: controller
                                      .responseGetAllRole.value.pageInfo!.page ==
                                  1
                              ? 1
                              : controller.responseGetAllRole.value.pageInfo!
                                          .prevPage *
                                      controller.responseGetAllRole.value
                                          .pageInfo!.limit +
                                  1,
                          lastIndex: controller
                                      .responseGetAllRole.value.pageInfo!.page ==
                                  controller.responseGetAllRole.value.pageInfo!
                                      .totalPage
                              ? controller.responseGetAllRole.value.pageInfo!
                                  .totalRecord
                              : controller.responseGetAllRole.value.pageInfo!
                                      .page! *
                                  controller.responseGetAllRole.value.pageInfo!
                                      .limit!,
                          totalRecord: controller
                              .responseGetAllRole.value.pageInfo!.totalRecord,
                          onBackClick: () {
                            if (controller
                                    .responseGetAllRole.value.pageInfo!.page !=
                                controller.responseGetAllRole.value.pageInfo!
                                    .prevPage) {
                              controller.fetchApiGetAllRoles(
                                  page: controller.responseGetAllRole.value
                                      .pageInfo!.prevPage);
                            }
                          },
                          onForwardClick: () {
                            if (controller
                                    .responseGetAllRole.value.pageInfo!.page !=
                                controller.responseGetAllRole.value.pageInfo!
                                    .nextPage) {
                              controller.fetchApiGetAllRoles(
                                  page: controller.responseGetAllRole.value
                                      .pageInfo!.nextPage);
                            }
                          },
                          onPageClick: (int page) {
                            controller.fetchApiGetAllRoles(page: page);
                          },
                          currentPage: controller.responseGetAllRole.value.pageInfo!.page,
                          lastPage: controller.responseGetAllRole.value.pageInfo!.totalPage),
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
          hintText: "Search",
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
