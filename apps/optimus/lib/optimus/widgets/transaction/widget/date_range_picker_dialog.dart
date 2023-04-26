import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePickerDialog extends StatefulWidget {
  final DateTime nextDay;
  final Function onSelectedDateChanged;
  final Function onDateFilterConfirmed;
  final Function onDateFilterCancelled;
  final DateTime activeStartDate;
  final DateTime activeEndDate;

  const DateRangePickerDialog(
      {Key? key,
      required this.nextDay,
      required this.onSelectedDateChanged,
      required this.onDateFilterConfirmed,
      required this.onDateFilterCancelled,
      required this.activeStartDate,
      required this.activeEndDate})
      : super(key: key);

  @override
  _DateRangePickerDialogState createState() => _DateRangePickerDialogState();
}

class _DateRangePickerDialogState extends State<DateRangePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 102,
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
              child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  maxDate: widget.nextDay,
                  onSelectionChanged: widget.onSelectedDateChanged as void Function(DateRangePickerSelectionChangedArgs)?,
                  onSubmit: (Object? value) {
                    if (value is PickerDateRange) {
                      final DateTime? rangeStartDate = value.startDate;
                      final DateTime? rangeEndDate = value.endDate;
                      if (rangeStartDate != null && rangeEndDate != null) {
                        widget.onDateFilterConfirmed(
                            rangeStartDate, rangeEndDate);
                      }
                    }
                  },
                  onCancel: () {
                    widget.onDateFilterCancelled();
                  },
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  initialSelectedRange:
                      widget.activeStartDate == widget.activeEndDate
                          ? null
                          : PickerDateRange(
                              widget.activeStartDate, widget.activeEndDate),
                  cancelText: ButtonConstant.dialogBtnCancel,
                  confirmText: ButtonConstant.dialogBtnApply,
                  showActionButtons: true),
            )),
      ),
    );
  }
}
