import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_switch/deasy_switch.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipients_response.dart';

class OptimusAutomailDatatable extends GetView<OptimusAutomailController> {
  final tableScrollController = ScrollController();
  final List<RecipientData> list;
  final int? limit;
  final PageInfo? pageInfo;

  OptimusAutomailDatatable({
    required this.list,
    this.pageInfo,
    this.limit,
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
                    label: Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: DeasyTextView(
                          text: ContentConstant.automailRecipient,
                          fontColor: DeasyColor.dms2DB0E2),
                    ),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                        text: ContentConstant.automailRecipientType,
                        fontColor: DeasyColor.dms2DB0E2),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.automailReceive,
                      fontColor: DeasyColor.dms2DB0E2,
                    ),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                        text: ContentConstant.automailDetail,
                        fontColor: DeasyColor.dms2DB0E2),
                  ),
                  DataColumn(
                    label: DeasyTextView(
                        text: ContentConstant.automailChange,
                        fontColor: DeasyColor.dms2DB0E2),
                  ),
                ],
                rows: list.isEmpty
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
                    : list.asMap().entries.map((data) {
                        RxBool _isEnable = false.obs;
                        _isEnable.value = data.value.isEnable!;
                        return DataRow(cells: [
                          DataCell(DeasyTextView(
                              text: data.value.name,
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.8,
                              maxLines: 2,
                              fontFamily: FontFamily.light)),
                          DataCell(Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: data.value.recipientType != 'DEALER'
                                    ? DeasyColor.semanticSuccess100
                                    : DeasyColor.kpBlue50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DeasyTextView(
                                text: data.value.recipientType,
                                fontColor: data.value.recipientType != 'DEALER'
                                    ? DeasyColor.semanticSuccess300
                                    : DeasyColor.kpBlue600,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 1.8,
                                fontFamily: FontFamily.light),
                          )),
                          DataCell(Obx(() => DeasySwitch(
                                transitionType: TextTransitionTypes.FADE,
                                rounded: true,
                                isClickable: true,
                                duration: Duration(milliseconds: 500),
                                forceWidth: true,
                                value: _isEnable.value,
                                onChanged: (v) {
                                  controller
                                      .dialogConfirmSwitchRecipientEnabler(v,
                                          id: data.value.id,
                                          isEnable: _isEnable.value);
                                },
                                offBkColor: DeasyColor.neutral400,
                                onBkColor: DeasyColor.dms2ED477,
                                offThumbColor: DeasyColor.neutral000,
                                onThumbColor: DeasyColor.neutral000,
                                thumbSize: 20.0,
                              ))),
                          DataCell(IconButton(
                            onPressed: () => controller.showDetailRecipient(
                                id: data.value.id,
                                supplierName: data.value.name),
                            icon: SvgPicture.asset(
                                IconConstant.RESOURCES_ICON_INFO),
                          )),
                          DataCell(
                            IconButton(
                              onPressed: () =>
                                  controller.showDialogEditRecipient(
                                      id: data.value.id,
                                      supplierName: data.value.name),
                              icon: SvgPicture.asset(
                                IconConstant.RESOURCES_ICON_EDIT,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                        ]);
                      }).toList()),
          ),
        ),
      ),
    );
  }
}
