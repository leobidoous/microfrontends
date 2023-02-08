import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        StatefulWidget,
        Key,
        State,
        TextStyle,
        BuildContext,
        SizedBox,
        TextAlign,
        Widget,
        FontWeight;

class DateTimePicker extends StatefulWidget {
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? initialDisplayDate;
  final DateTime? initialSelectedDate;
  final DateRangePickerController controller;
  final DateRangePickerSelectionMode selectionMode;
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;

  const DateTimePicker({
    Key? key,
    this.maxDate,
    this.minDate,
    this.initialSelectedDate,
    this.initialDisplayDate,
    this.onSelectionChanged,
    required this.controller,
    this.selectionMode = DateRangePickerSelectionMode.single,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
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
        rangeTextStyle: context.textTheme.bodyMedium,
        monthCellStyle: DateRangePickerMonthCellStyle(
          weekendTextStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
          disabledDatesTextStyle: _disabledText,
          textStyle: context.textTheme.bodyMedium,
          todayTextStyle: context.textTheme.bodyMedium,
          leadingDatesTextStyle: context.textTheme.bodyMedium,
          trailingDatesTextStyle: context.textTheme.bodyMedium,
        ),
        selectionRadius: 12,
        selectionShape: DateRangePickerSelectionShape.rectangle,
        headerStyle: DateRangePickerHeaderStyle(
          textStyle: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        initialDisplayDate: widget.initialDisplayDate,
        selectionTextStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.background,
          fontWeight: FontWeight.bold,
        ),
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: context.textTheme.bodyMedium,
          disabledDatesTextStyle: _disabledText,
        ),
      ),
    );
  }

  TextStyle? get _disabledText => context.textTheme.bodyMedium?.copyWith(
        color: context.textTheme.bodyMedium?.color?.withOpacity(0.5),
      );
}
