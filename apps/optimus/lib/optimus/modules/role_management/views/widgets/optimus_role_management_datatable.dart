import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/controllers/optimus_role_management_controller.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_get_all_role_response.dart';
import 'package:deasy_color/deasy_color.dart';

class OptimusRoleManagementDatatable
    extends GetView<OptimusRoleManagementController> {
  final tableScrollController = ScrollController();
  final List<RoleManagementData>? list;
  final int? limit;
  final PageInfo? pageInfo;
  final Function? onOrderByCreatedAt;
  final Function? onOrderByUpdateAt;
  final Function? onOrderByStatus;
  final Function? onCreateEcommerceClientKey;
  final Function? onEdit;

  OptimusRoleManagementDatatable({
    this.list,
    this.pageInfo,
    this.limit,
    this.onCreateEcommerceClientKey,
    this.onEdit,
    this.onOrderByCreatedAt,
    this.onOrderByUpdateAt,
    this.onOrderByStatus,
  });

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Card(
      color: DeasyColor.neutral000,
      child: Container(
        constraints: BoxConstraints(minWidth: 100.w),
        padding: EdgeInsets.all(8.0),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: DeasyColor.neutral400,
          controller: tableScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: tableScrollController,
            physics: ClampingScrollPhysics(),
            child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: DeasyTextView(
                        text: "No", fontColor: DeasyColor.semanticInfo300),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                        text: ContentConstant.role,
                        fontColor: DeasyColor.dms2DB0E2),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        DeasyTextView(
                            text: ContentConstant.dateCreated,
                            fontColor: DeasyColor.dms2DB0E2),
                        SizedBox(
                            width: DeasySizeConfigUtils.blockHorizontal! * 1),
                        IconButton(
                          onPressed: () {
                            onOrderByCreatedAt!();
                          },
                          icon: SvgPicture.asset(
                              IconConstant.RESOURCES_ICON_ORDER_BY),
                        )
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        DeasyTextView(
                          text: ContentConstant.dateUpdated,
                          fontColor: DeasyColor.dms2DB0E2,
                        ),
                        SizedBox(
                            width: DeasySizeConfigUtils.blockHorizontal! * 1),
                        IconButton(
                          onPressed: () {
                            onOrderByUpdateAt!();
                          },
                          icon: SvgPicture.asset(
                              IconConstant.RESOURCES_ICON_ORDER_BY),
                        )
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        DeasyTextView(
                            text: ContentConstant.status,
                            fontColor: DeasyColor.dms2DB0E2),
                        SizedBox(
                            width: DeasySizeConfigUtils.blockHorizontal! * 1),
                        IconButton(
                          onPressed: () {
                            onOrderByStatus!();
                          },
                          icon: SvgPicture.asset(
                              IconConstant.RESOURCES_ICON_ORDER_BY),
                        )
                      ],
                    ),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                        text: ContentConstant.action,
                        fontColor: DeasyColor.dms2DB0E2),
                  ),
                ],
                rows: list!.isEmpty
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
                          ],
                        ),
                      ]
                    : list!.asMap().entries.map((data) {
                        var rowIndex = pageInfo!.page == 1
                            ? data.key + 1
                            : (data.key + 1) + (pageInfo!.prevPage * 10);
                        return DataRow(cells: [
                          DataCell(DeasyTextView(
                              text: "$rowIndex",
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.8,
                              fontFamily: FontFamily.light)),
                          DataCell(DeasyTextView(
                              text: data.value.name,
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.8,
                              maxLines: 2,
                              fontFamily: FontFamily.light)),
                          DataCell(DeasyTextView(
                              text: data.value.createdAt
                                  .toString()
                                  .toFormattedDate(format: "dd MMM yyyy"),
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.8,
                              fontFamily: FontFamily.light)),
                          DataCell(DeasyTextView(
                              text: data.value.updatedAt
                                  .toString()
                                  .toFormattedDate(format: "dd MMM yyyy"),
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.8,
                              fontFamily: FontFamily.light)),
                          DataCell(Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: data.value.status!
                                    ? DeasyColor.dmsE5F9EC
                                    : DeasyColor.dmsFFEDF0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DeasyTextView(
                                text: data.value.status!
                                    ? ContentConstant.active
                                    : ContentConstant.nonActive,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 1.8,
                                fontColor: data.value.status!
                                    ? DeasyColor.dms1BC5BD
                                    : DeasyColor.dmsF64E60,
                                fontFamily: FontFamily.light),
                          )),
                          DataCell(InkWell(
                            onTap: () {
                              onEdit!(data.value);
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Container(
                                color: DeasyColor.kpBlue50,
                                padding: EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                    IconConstant.RESOURCES_ICON_EDIT),
                              ),
                            ),
                          )),
                        ]);
                      }).toList()),
          ),
        ),
      ),
    );
  }
}
