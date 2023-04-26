import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/core/widgets/date_range_picker_dialog.dart'
    as DatePicker;

class FilterDateContainerWidget extends GetWidget<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
        visible: controller.isOpenDateFilter.isTrue,
        child: DatePicker.DateRangePickerDialogWidget()));
  }
}
