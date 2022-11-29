import 'package:base_style_sheet/src/presentation/widgets/charts/line_chart.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

void main() {
  testWidgets('Line chart test', (WidgetTester tester) async {
    List<Map<String, dynamic>> dataTest = const [
      {
        'id': 'Line',
        'data': [
          {'domain': 0, 'measure': 4.1},
          {'domain': 2, 'measure': 4},
          {'domain': 3, 'measure': 6},
          {'domain': 4, 'measure': 1},
        ],
      },
    ];

    LineChart lineChart = LineChart(
      data: dataTest,
    );

    await tester.pumpWidget(
      makeTestable(lineChart),
    );

    final Finder chartFinder = find.byType(DChartLine);
    final DChartLine dChartLine = tester.widget(chartFinder);

    expect(chartFinder, findsOneWidget);
    expect(
      dChartLine.lineColor,
      isA<Color Function(Map<String, dynamic>, int?, String)>(),
    );
    expect(
      dChartLine.areaColor,
      isA<Color Function(Map<String, dynamic>, int?, String)>(),
    );
    expect(
      dChartLine.includeArea,
      false,
    );
    expect(
      dChartLine.includePoints,
      false,
    );
    expect(
      dChartLine.lineWidth,
      2,
    );
  });
}
