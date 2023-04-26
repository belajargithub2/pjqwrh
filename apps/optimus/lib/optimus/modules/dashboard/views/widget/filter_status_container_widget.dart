import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:deasy_color/deasy_color.dart';

class FilterStatusContainerWidget extends GetWidget<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: !DeasySizeConfigUtils.isMobile
          ? DeasySizeConfigUtils.screenWidth! * 0.11
          : DeasySizeConfigUtils.screenWidth! * 0.27,
      top: 210,
      child: Obx(() => Visibility(
            visible: controller.isOpenStatusFilter.isTrue,
            child: Card(
              color: DeasyColor.neutral000,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih Status',
                        style: TextStyle(color: DeasyColor.semanticInfo300)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.statusMap.keys.map((String key) {
                          return Row(
                            children: [
                              Checkbox(
                                  activeColor: DeasyColor.kpYellow500,
                                  value: controller.statusMap[key],
                                  onChanged: (bool? value) {
                                    controller.statusMap[key] = value;
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.formatStringStatus(key),
                                ),
                              ),
                            ],
                          );
                        }).toList()),
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
                                    width: 1, color: DeasyColor.neutral000),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.onApplyStatusFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Apply",
                                  style:
                                      TextStyle(color: DeasyColor.neutral000),
                                ),
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.neutral000,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                controller.clearStatusFilter();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Clear",
                                  style:
                                      TextStyle(color: DeasyColor.kpYellow500),
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
    );
  }
}
