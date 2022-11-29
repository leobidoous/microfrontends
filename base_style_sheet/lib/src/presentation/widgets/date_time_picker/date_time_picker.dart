import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? initialSelectedDate;
  final DateRangePickerController controller;
  final DateRangePickerSelectionMode selectionMode;
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;

  const DateTimePicker({
    Key? key,
    this.maxDate,
    this.minDate,
    this.initialSelectedDate,
    this.onSelectionChanged,
    required this.controller,
    this.selectionMode = DateRangePickerSelectionMode.single,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  TextStyle? get _disabledText =>
      Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(
                  0.5,
                ),
          );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: SfDateRangePicker(
        maxDate: widget.maxDate,
        minDate: widget.minDate,
        controller: widget.controller,
        selectionMode: widget.selectionMode,
        monthViewSettings: const DateRangePickerMonthViewSettings(
          showTrailingAndLeadingDates: true,
        ),
        onSelectionChanged: widget.onSelectionChanged,
        initialSelectedDate: widget.initialSelectedDate,
        rangeTextStyle: Theme.of(context).textTheme.bodyText1,
        monthCellStyle: DateRangePickerMonthCellStyle(
          weekendTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
          disabledDatesTextStyle: _disabledText,
          textStyle: Theme.of(context).textTheme.bodyText1,
          todayTextStyle: Theme.of(context).textTheme.bodyText1,
          leadingDatesTextStyle: Theme.of(context).textTheme.bodyText1,
          trailingDatesTextStyle: Theme.of(context).textTheme.bodyText1,
        ),
        selectionRadius: 12,
        selectionShape: DateRangePickerSelectionShape.rectangle,
        headerStyle: DateRangePickerHeaderStyle(
          textStyle: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        selectionTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.bold,
            ),
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: Theme.of(context).textTheme.bodyText1,
          disabledDatesTextStyle: _disabledText,
        ),
      ),
    );
  }
}
