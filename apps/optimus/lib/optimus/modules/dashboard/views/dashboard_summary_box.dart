import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/dashboard_transaction_grid.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/filter_merchant_box_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class DashboardSummaryBox extends GetView<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: controller.hasAdmin.isTrue ||
                    controller.hasSelectMerchantAccess.isTrue,
                child: buildStatusFilterButton(),
              ),
              const SizedBox(height: 32),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: DeasyColor.neutral000,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DeasyTextView(
                            text: ContentConstant.dashboard,
                            fontSize: DeasySizeConfigUtils.isTab ? 20 : 24,
                            fontFamily: FontFamily.bold,
                          ),
                          SizedBox(
                            height: DeasySizeConfigUtils.isTab ? 30 : 40,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => DeasyCustomActionButton(
                                    fontSize:
                                        controller.drawerBodyWidth / 100 + 3,
                                    width: DeasySizeConfigUtils.isTab ? 77 : 97,
                                    borderRadius: 8,
                                    padding: 0,
                                    text: controller.buttonList[index],
                                    bgColor:
                                        controller.selectedIndexButton.value ==
                                                index
                                            ? DeasyColor.kpYellow500
                                            : DeasyColor.neutral000,
                                    textColor:
                                        controller.selectedIndexButton.value ==
                                                index
                                            ? DeasyColor.neutral000
                                            : DeasyColor.kpYellow500,
                                    borderColor: DeasyColor.kpYellow500,
                                    onPressed: () {
                                      controller
                                          .onTapButtonFilterSummary(index);
                                    },
                                  ),
                                );
                              },
                              itemCount: controller.buttonList.length,
                              separatorBuilder: (_, index) => SizedBox(
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        children: [
                          Container(
                            width: controller.drawerBodyWidth / 100 * 30,
                            height: controller.drawerBodyWidth / 100 * 26.5,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: DeasyColor.kpBlue50,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AspectRatio(
                                  child: Image.asset(
                                    ImageConstant.RESOURCES_IMAGE_UI_INTERFACE,
                                  ),
                                  aspectRatio: 4 / 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.totalAplikasi}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  controller.drawerBodyWidth /
                                                          100 +
                                                      6),
                                        ),
                                        Text(
                                          ContentConstant.appsTotal,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize:
                                                controller.drawerBodyWidth /
                                                        100 +
                                                    3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.incomingValue.value
                                              .toString()
                                              .toRupiah(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  controller.drawerBodyWidth /
                                                          100 +
                                                      6),
                                        ),
                                        SizedBox(
                                          width: controller.drawerBodyWidth /
                                              100 *
                                              16,
                                          child: Text(
                                            'Total Pendapatan ${controller.textIncomeByTime.value} ini',
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize:
                                                  controller.drawerBodyWidth /
                                                          100 +
                                                      3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Container(
                              height: controller.drawerBodyWidth / 100 * 26,
                              alignment: Alignment.centerRight,
                              child: DashboardTransactionGrid(
                                height:
                                    (controller.drawerBodyWidth / 100 * 24.3) /
                                        2,
                                width: (controller.drawerBodyWidth /
                                        100 *
                                        (DeasySizeConfigUtils.isTab
                                            ? 45
                                            : 55)) /
                                    3,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          FilterMerchantBoxWidget()
        ],
      ),
    );
  }

  buildStatusFilterButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(
        () => TextButton.icon(
          onPressed: () {
            controller.onTapShowMerchantSearch();
          },
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              color: DeasyColor.kpYellow500),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.all(DeasySizeConfigUtils.isTab ? 15 : 20)),
            side: MaterialStateProperty.all(
                BorderSide(color: DeasyColor.kpYellow500)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          label: DeasyTextView(
            text: controller.selectedMerchantName.isNotEmpty
                ? controller.selectedMerchantName.value
                : ContentConstant.merchantLabel,
            fontSize: DeasySizeConfigUtils.isTab ? 11 : 18,
            fontFamily: FontFamily.medium,
            fontColor: DeasyColor.kpYellow500,
          ),
        ),
      ),
    );
  }
}
