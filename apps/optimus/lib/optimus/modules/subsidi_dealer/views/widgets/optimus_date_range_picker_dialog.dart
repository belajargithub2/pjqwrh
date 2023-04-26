import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OptimusDateRangePickerDialog extends StatefulWidget {
  final DateTime maxDate;
  final Function onSelectedDateChanged;
  final Function onDateFilterConfirmed;
  final Function onDateFilterCancelled;
  final DateTime activeStartDate;
  final DateTime activeEndDate;

  const OptimusDateRangePickerDialog(
      {Key? key,
      required this.maxDate,
      required this.onSelectedDateChanged,
      required this.onDateFilterConfirmed,
      required this.onDateFilterCancelled,
      required this.activeStartDate,
      required this.activeEndDate})
      : super(key: key);

  @override
  _OptimusDateRangePickerDialogState createState() => _OptimusDateRangePickerDialogState();
}

class _OptimusDateRangePickerDialogState extends State<OptimusDateRangePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          height: 300,
          width: 300,
          child: Theme(
            data: ThemeData(
                brightness: Brightness.light, fontFamily: "KBFGDisplayLight"),
            child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                maxDate: widget.maxDate,
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
    );
  }
}
