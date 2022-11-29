import 'package:core/core.dart';
import 'package:flutter/material.dart';

/*
Exemplo de dados de entrada:
data: [
        {'domain': 'Flutter', 'measure': 28},
        {'domain': 'React Native', 'measure': 27},
        {'domain': 'Ionic', 'measure': 20},
        {'domain': 'Cordova', 'measure': 15},
    ],
*/
class PieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final PieColor? fillColor;
  final PieLabel? pieLabel;
  final PieLabelPosition? labelPosition;
  final int? labelFontSize;
  final Color? labelColor;
  final bool? showLabelLine;
  final Color? labelLineColor;
  final double? labelLinelength;
  final double? labelLineThickness;
  final int? labelPadding;

  /// [donutWidth] return width of donut chart. if null will be return Pie Chart
  final int? donutWidth;
  final double? strokeWidth;
  final bool? animate;
  final Duration? animationDuration;

  const PieChart({
    super.key,
    required this.data,
    this.fillColor,
    this.pieLabel,
    this.labelPosition,
    this.labelFontSize,
    this.labelColor,
    this.showLabelLine,
    this.labelLineColor,
    this.labelLinelength,
    this.labelLineThickness,
    this.labelPadding,
    this.donutWidth,
    this.strokeWidth,
    this.animate,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return DChartPie(
      data: data,
      fillColor: fillColor ?? (pieData, index) => Colors.purple,
      pieLabel: pieLabel,
      labelPosition: labelPosition ?? PieLabelPosition.auto,
      labelFontSize: labelFontSize ?? 12,
      labelColor: labelColor ?? Colors.black,
      showLabelLine: showLabelLine ?? true,
      labelLineColor: labelLineColor ?? Colors.black,
      labelLinelength: labelLinelength ?? 16,
      labelLineThickness: labelLineThickness ?? 1,
      labelPadding: labelPadding ?? 5,
      donutWidth: donutWidth,
      strokeWidth: strokeWidth ?? 2,
      animate: animate,
      animationDuration: animationDuration,
    );
  }
}
