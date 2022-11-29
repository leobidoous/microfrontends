import 'package:core/core.dart';
import 'package:flutter/material.dart';

/*
Exemplo de dados de entrada:
data: [
        {
            'id': 'Line',
            'data': [
                {'domain': 0, 'measure': 4.1},
                {'domain': 2, 'measure': 4},
                {'domain': 3, 'measure': 6},
                {'domain': 4, 'measure': 1},
            ],
        },
    ],
*/
class LineChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final LineColor<Color>? lineColor;
  final LineColor<Color>? areaColor;
  final LineColor<Color>? pointColor;
  final bool? includeArea;
  final bool? includePoints;
  final double? lineWidth;
  final bool? animate;
  final Duration? animationDuration;

  const LineChart({
    super.key,
    required this.data,
    this.lineColor,
    this.areaColor,
    this.includeArea,
    this.includePoints,
    this.lineWidth,
    this.pointColor,
    this.animate,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return DChartLine(
      data: data,
      lineColor: lineColor ?? (lineData, index, id) => Colors.amber,
      areaColor: areaColor ?? (lineData, index, id) => Colors.white,
      includeArea: includeArea ?? false,
      includePoints: includePoints ?? false,
      lineWidth: lineWidth ?? 2,
      animate: animate,
      animationDuration: animationDuration,
    );
  }
}
