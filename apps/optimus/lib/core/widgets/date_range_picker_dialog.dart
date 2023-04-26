import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePickerDialogWidget extends GetWidget<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 210,
      right: 0,
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          height: 360,
          width: 350,
          child: Theme(
              data: ThemeData(
                  brightness: Brightness.light, fontFamily: "KBFGDisplayLight"),
              child: Obx(() => SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  maxDate: controller.maxDate.value,
                  minDate: controller.minDate.value == null ? null : controller.minDate.value,
                  onSelectionChanged: controller.onSelectedDateChanged,
                  onSubmit: (Object? value) {
                    if (value is PickerDateRange) {
                      final DateTime? rangeStartDate = value.startDate;
                      final DateTime? rangeEndDate = value.endDate;
                      if (rangeStartDate != null && rangeEndDate != null) {
                        controller.onDateFilterConfirmed(
                            rangeStartDate, rangeEndDate);

                      }
                    }
                  },
                  onCancel: () {
                    controller.onDateFilterCancel();
                  },
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  initialSelectedRange:
                      controller.activeStartDate == controller.activeEndDate
                          ? null
                          : PickerDateRange(controller.activeStartDate.value,
                              controller.activeEndDate.value),
                  cancelText: "Batal",
                  confirmText: "Terapkan",
                  showActionButtons: true))),
        ),
      ),
    );
  }
}
