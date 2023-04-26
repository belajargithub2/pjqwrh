import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/views/widgets/optimus_date_range_picker_dialog.dart';

class OptimusFilterDateContainerWidget
    extends GetWidget<OptimusSubsidiDealerTableController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(
      () => Visibility(
        visible: controller.isOpenDateFilter.isTrue,
        child: OptimusDateRangePickerDialog(
          maxDate: controller.maxDate,
          onSelectedDateChanged: controller.onSelectedDateChanged,
          onDateFilterConfirmed:
              (DateTime rangeStartDate, DateTime rangeEndDate) {
            if (rangeStartDate != null && rangeEndDate != null) {
              controller.onDateFilterConfirmed(rangeStartDate, rangeEndDate);
              controller.isOpenDateFilter.toggle();
            }
          },
          onDateFilterCancelled: () {
            controller.onDateFilterCancel();
          },
          activeStartDate: controller.activeStartDate.value,
          activeEndDate: controller.activeEndDate.value,
        ),
      ),
    );
  }
}
