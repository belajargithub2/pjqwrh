import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/controllers/optimus_user_management_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/data_table_paginator.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/core/widgets/dialog.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_models/deasy_models.dart';


class OptimusUserManagementWebView
    extends GetView<OptimusUserManagementController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(() => Container(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: DeasySizeConfigUtils.screenHeight,
              child: SingleChildScrollView(
                controller: controller.scrollController,
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
                              text: "User Management",
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 2.5,
                              fontFamily: FontFamily.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: DeasyColor.neutral000,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Container(
                                        height: 40,
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
                                            suffixIcon: controller.icon,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide:
                                                  BorderSide(width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide: BorderSide(
                                                  color: DeasyColor.neutral400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
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
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: DeasyCustomElevatedButton(
                                      text: "Tambah",
                                      primary: DeasyColor.kpYellow500,
                                      textColor: DeasyColor.neutral000,
                                      paddingButton: 10,
                                      borderColor: DeasyColor.kpYellow500,
                                      onPress: () {
                                        Get.toNamed(OptimusPaths
                                                .CREATE_USER_MANAGEMENT)!
                                            .then((value) {
                                          controller.fetchApiAllUsers();

                                          ///TODO: separate fetchApiAllUsers() to different controller & put it in onInit()
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 40,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: DeasyColor.neutral000,
                                          side: BorderSide(
                                              width: 1,
                                              color: DeasyColor.kpYellow500),
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        onPressed: () {
                                          controller.dialogFilter();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              ContentConstant.selectRole,
                                              style: TextStyle(
                                                  color: DeasyColor.kpYellow500,
                                                  fontSize: DeasySizeConfigUtils
                                                          .blockVertical *
                                                      1.8),
                                            ),
                                            Spacer(),
                                            controller.isOpenFilter.isFalse
                                                ? Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    color:
                                                        DeasyColor.kpYellow500,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .keyboard_arrow_up_outlined,
                                                    color:
                                                        DeasyColor.kpYellow500,
                                                  )
                                          ],
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: SizedBox(),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: DeasySizeConfigUtils.screenWidth,
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
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "  No",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Supplier ID",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: Row(
                                          children: [
                                            DeasyTextView(
                                                text: "Supplier Name",
                                                fontColor:
                                                    DeasyColor.semanticInfo300),
                                            IconButton(
                                                onPressed: () {
                                                  controller
                                                      .orderBySupplierName();
                                                },
                                                icon: Icon(
                                                    !controller
                                                            .isAscDelear.value
                                                        ? Icons
                                                            .keyboard_arrow_down_outlined
                                                        : Icons
                                                            .keyboard_arrow_up_outlined,
                                                    color:
                                                        DeasyColor.neutral900))
                                          ],
                                        ),
                                      ),
                                      DataColumn(
                                        label: Row(
                                          children: [
                                            DeasyTextView(
                                                text: "User Name",
                                                fontColor:
                                                    DeasyColor.semanticInfo300),
                                            IconButton(
                                                onPressed: () {
                                                  controller.orderByUserName();
                                                },
                                                icon: Icon(
                                                    !controller.isAscUsername.value
                                                        ? Icons
                                                            .keyboard_arrow_down_outlined
                                                        : Icons
                                                            .keyboard_arrow_up_outlined,
                                                    color:
                                                        DeasyColor.neutral900))
                                          ],
                                        ),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Email",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Role",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "Created",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                      DataColumn(
                                        label: DeasyTextView(
                                            text: "",
                                            fontColor:
                                                DeasyColor.semanticInfo300),
                                      ),
                                    ],
                                    rows: controller.userResponse.value.data!
                                        .asMap()
                                        .entries
                                        .map((user) {
                                      var rowIndex = controller.userResponse
                                                  .value.pageInfo!.page ==
                                              1
                                          ? user.key + 1
                                          : (user.key + 1) +
                                              (controller.userResponse.value
                                                      .pageInfo!.prevPage! *
                                                  controller.itemCount);
                                      return DataRow(
                                        cells: controller.userResponse.value
                                                .data!.isEmpty
                                            ? _emptyDataRows()
                                            : _dataRows(
                                                context, rowIndex, user),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            if (controller.notFound.isNotEmpty)
                              Center(
                                  child: DeasyTextView(
                                      text: "${controller.notFound.value}")),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              child: controller.userResponse.value.data!.isEmpty
                                  ? DeasyTextView(
                                      text: "Menampilkan 0 dari 0 entri",
                                      fontSize: 12)
                                  : DataTablePaginator(
                                      firstIndex:
                                          controller.userResponse.value.pageInfo!.page == 1
                                              ? 1
                                              : controller.userResponse.value
                                                          .pageInfo!.prevPage! *
                                                      controller.limit.value +
                                                  1,
                                      lastIndex: controller.userResponse.value
                                                  .pageInfo!.page ==
                                              controller.userResponse.value
                                                  .pageInfo!.totalPage
                                          ? controller.userResponse.value
                                              .pageInfo!.totalRecord
                                          : controller.userResponse.value
                                                  .pageInfo!.page! *
                                              controller.limit.value,
                                      totalRecord: controller.userResponse.value
                                          .pageInfo!.totalRecord,
                                      onBackClick: () {
                                        if (controller.userResponse.value
                                                .pageInfo!.page !=
                                            controller.userResponse.value
                                                .pageInfo!.prevPage) {
                                          controller.fetchApiAllUsers(
                                              page: controller.userResponse
                                                  .value.pageInfo!.prevPage);
                                        }
                                      },
                                      onForwardClick: () {
                                        if (controller.userResponse.value
                                                .pageInfo!.page !=
                                            controller.userResponse.value
                                                .pageInfo!.nextPage) {
                                          controller.fetchApiAllUsers(
                                              page: controller.userResponse
                                                  .value.pageInfo!.nextPage);
                                        }
                                      },
                                      onPageClick: (int page) {
                                        controller.fetchApiAllUsers(page: page);
                                      },
                                      currentPage: controller.userResponse.value.pageInfo!.page,
                                      lastPage: controller.userResponse.value.pageInfo!.totalPage),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
                left: DeasySizeConfigUtils.screenWidth! * 0.03,
                top: 23.h - controller.scrollPixel.value,
                child: Visibility(
                  visible: controller.isOpenFilter.isTrue &&
                          controller.listRole.length > 0
                      ? true
                      : false,
                  child: Card(
                    color: DeasyColor.neutral000,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 4, top: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pilih Role',
                              style:
                                  TextStyle(color: DeasyColor.semanticInfo300)),
                          Container(
                            height: DeasySizeConfigUtils.screenHeight! / 3,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.listRole.map((element) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                          value: element.isChecked,
                                          onChanged: (bool? value) {
                                            controller.submitFilter(
                                                element, value!);
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${element.name}'),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
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
                                          width: 1,
                                          color: DeasyColor.neutral000),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {
                                      controller.applyFilter();
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "Apply",
                                        style: TextStyle(
                                            color: DeasyColor.neutral000),
                                      ),
                                    )),
                                SizedBox(
                                  height: 4,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: DeasyColor.neutral000,
                                      side: BorderSide(
                                          width: 1,
                                          color: DeasyColor.kpYellow500),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {
                                      controller.clearFilter();
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                            color: DeasyColor.kpYellow500),
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
          ],
        )));
  }

  Widget _menuWidget() {
    return MenuWidgets.twoMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.userManagementLabel,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
    );
  }

  List<DataCell> _dataRows(BuildContext context, int rowIndex,
      MapEntry<int, UserItemResponse> user) {
    return [
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: rowIndex.toString()));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: rowIndex.toString(),
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: user.value.supplier!.supplierId.toNnA()));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: user.value.supplier!.supplierId!.toNnA(),
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: user.value.supplier!.name));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: user.value.supplier!.name!.toNnA(),
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          maxLines: 2,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: user.value.name));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: user.value.name!.toNnA(),
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          maxLines: 2,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: user.value.email));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: user.value.email,
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          maxLines: 2,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: user.value.role!.name));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text: user.value.role!.name!.isEmpty ? "N/A" : user.value.role!.name,
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          maxLines: 2,
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(
              text:
                  "${user.value.createdAt.toString().toFormattedDate(format: "dd MMM yyyy")}"));
          DeasySnackBarUtil.showSnackBar(context, "Text berhasil di copy");
        },
        child: DeasyTextView(
          text:
              "${user.value.createdAt.toString().toFormattedDate(format: "dd MMM yyyy")}",
          fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          maxLines: 2,
        ),
      )),
      DataCell(
        Row(
          children: [
            Card(
              color: DeasyColor.kpBlue50,
              margin: EdgeInsets.all(4),
              child: IconButton(
                  icon: SvgPicture.asset(
                      "${IconConstant.RESOURCES_ICON_PATH}ic_client_key_edit.svg"),
                  onPressed: () {
                    Get.toNamed(OptimusPaths.EDIT_USER_MANAGEMENT, parameters: {
                      "user_id": user.value.id!,
                      "is_edit": "true"
                    })!
                        .then((value) {
                      controller.fetchApiAllUsers();
                    });
                  }),
            ),
            Card(
              child: IconButton(
                  icon: SvgPicture.asset(
                      "${IconConstant.RESOURCES_ICON_PATH}ic_order_cancel.svg"),
                  onPressed: () {
                    showDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return DialogUtil.deleteUserManagementDialog(
                              context: context,
                              name: user.value.name,
                              id: user.value.id,
                              onCancelPress: () => Get.back(),
                              onConfirmPress: () =>
                                  controller.delete(user.value.id));
                        });
                  }),
              color: DeasyColor.dmsFFF1F1,
              margin: EdgeInsets.all(4),
            ),
          ],
        ),
      ),
    ];
  }

  List<DataCell> _emptyDataRows() {
    return [
      DataCell(
        SizedBox(),
      ),
      DataCell(
        SizedBox(),
      ),
      DataCell(
        SizedBox(),
      ),
      DataCell(
        DeasyTextView(text: "Data Kosong"),
      ),
      DataCell(
        SizedBox(),
      ),
      DataCell(
        SizedBox(),
      ),
      DataCell(
        SizedBox(),
      ),
      DataCell(
        SizedBox(),
      ),
    ];
  }
}
