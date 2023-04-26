import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/statistic_controller.dart';

class BarChart extends GetView<StatisticController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
       return Text('chart');
      },
      onLoading: Center(
          child: SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator())),
      onEmpty: SizedBox(),
      onError: (e) => SizedBox(),
    );
  }
}
