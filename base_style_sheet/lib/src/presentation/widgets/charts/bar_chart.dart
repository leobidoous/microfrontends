// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:flutter/material.dart';

/*
Exemplo de dados de entrada:
data: [
        {
            'id': 'Bar',
            'data': [
                {'domain': '2020', 'measure': 3},
                {'domain': '2021', 'measure': 4},
                {'domain': '2022', 'measure': 6},
                {'domain': '2023', 'measure': 0.3},
            ],
        },
    ],
*/
class BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final BarColor<Color>? barColor;
  final BarValue<String>? barValue;
  final BarValueAnchor? barValueAnchor;
  final BarValuePosition? barValuePosition;
  final int? barValueFontSize;
  final Color? barValueColor;
  final bool? showBarValue;
  final Color? borderColor;
  final double? borderWidth;
  final bool? animate;
  final Duration? animationDuration;
  final bool? verticalDirection;
  final bool? showMeasureLine;
  final bool? showDomainLine;
  final Color? axisLineColor;
  final int? axisLineTick;
  final int? axisLinePointTick;
  final int? axisLinePointWidth;
  final int? domainLabelRotation;
  final int? domainLabelFontSize;
  final Color? domainLabelColor;
  final int? domainLabelPaddingToTick;
  final int? domainLabelPaddingToAxisLine;
  final int? measureLabelRotation;
  final int? measureLabelFontSize;
  final Color? measureLabelColor;
  final int? measureLabelPaddingToTick;
  final int? measureLabelPaddingToAxisLine;
  final int? measureMin;
  final int? measureMax;
  final String? yAxisTitle;
  final Color? measureAxisTitleColor;
  final int? measureAxisTitleFontSize;
  final int? measureAxisTitleInPadding;
  final int? measureAxisTitleOutPadding;
  final TitlePositionY? measureAxisTitlePosition;
  final String? xAxisTitle;
  final Color? domainAxisTitleColor;
  final int? domainAxisTitleFontSize;
  final int? domainAxisTitleInPadding;
  final int? domainAxisTitleOutPadding;
  final TitlePositionX? domainAxisTitlePosition;
  final int? minimumPaddingBetweenLabel;
  String _defaultBarValue(Map<String, dynamic> barData, int? index) => '';

  const BarChart({
    Key? key,
    required this.data,
    this.barColor,
    this.barValue,
    this.barValueAnchor,
    this.barValuePosition,
    this.barValueFontSize,
    this.barValueColor,
    this.showBarValue,
    this.borderColor,
    this.borderWidth,
    this.animate,
    this.animationDuration,
    this.verticalDirection,
    this.showMeasureLine,
    this.showDomainLine,
    this.axisLineColor,
    this.axisLineTick,
    this.axisLinePointTick,
    this.axisLinePointWidth,
    this.domainLabelRotation,
    this.domainLabelFontSize,
    this.domainLabelColor,
    this.domainLabelPaddingToTick,
    this.domainLabelPaddingToAxisLine,
    this.measureLabelRotation,
    this.measureLabelFontSize,
    this.measureLabelColor,
    this.measureLabelPaddingToTick,
    this.measureLabelPaddingToAxisLine,
    this.measureMin,
    this.measureMax,
    this.yAxisTitle,
    this.measureAxisTitleColor,
    this.measureAxisTitleFontSize,
    this.measureAxisTitleInPadding,
    this.measureAxisTitleOutPadding,
    this.measureAxisTitlePosition,
    this.xAxisTitle,
    this.domainAxisTitleColor,
    this.domainAxisTitleFontSize,
    this.domainAxisTitleInPadding,
    this.domainAxisTitleOutPadding,
    this.domainAxisTitlePosition,
    this.minimumPaddingBetweenLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DChartBar(
      data: data,
      domainLabelPaddingToAxisLine: domainLabelPaddingToAxisLine ?? 16,
      axisLineTick: axisLineTick ?? 2,
      axisLinePointTick: axisLinePointTick ?? 2,
      axisLinePointWidth: axisLinePointWidth ?? 10,
      axisLineColor: axisLineColor ?? Colors.blueGrey,
      measureLabelPaddingToAxisLine: measureLabelPaddingToAxisLine ?? 16,
      barColor: barColor ?? (barData, index, id) => Colors.green,
      showBarValue: showBarValue ?? false,
      barValue: barValue ?? _defaultBarValue,
      barValueFontSize: barValueFontSize ?? 14,
      verticalDirection: verticalDirection ?? true,
      domainAxisTitleColor: domainAxisTitleColor ?? Colors.black,
      domainAxisTitleFontSize: domainAxisTitleFontSize ?? 14,
      domainAxisTitleInPadding: domainAxisTitleInPadding ?? 8,
      domainAxisTitleOutPadding: domainAxisTitleOutPadding ?? 0,
      domainAxisTitlePosition: domainAxisTitlePosition ?? TitlePositionX.bottom,
      measureAxisTitleColor: measureAxisTitleColor ?? Colors.black,
      measureAxisTitleFontSize: measureAxisTitleFontSize ?? 14,
      measureAxisTitleInPadding: measureAxisTitleInPadding ?? 8,
      measureAxisTitleOutPadding: measureAxisTitleOutPadding ?? 0,
      measureAxisTitlePosition: measureAxisTitlePosition ?? TitlePositionY.left,
      animate: animate,
      animationDuration: animationDuration,
      barValueAnchor: barValueAnchor,
      barValueColor: barValueColor,
      barValuePosition: barValuePosition,
      borderColor: borderColor,
      borderWidth: borderWidth,
      domainLabelColor: domainLabelColor,
      domainLabelFontSize: domainLabelFontSize,
      domainLabelPaddingToTick: domainLabelPaddingToTick,
      domainLabelRotation: domainLabelRotation,
      measureLabelColor: measureLabelColor,
      measureLabelFontSize: measureLabelFontSize,
      measureLabelPaddingToTick: measureLabelPaddingToTick,
      measureLabelRotation: measureLabelRotation,
      measureMax: measureMax,
      yAxisTitle: yAxisTitle,
      xAxisTitle: xAxisTitle,
      measureMin: measureMin,
      minimumPaddingBetweenLabel: minimumPaddingBetweenLabel,
    );
  }
}
