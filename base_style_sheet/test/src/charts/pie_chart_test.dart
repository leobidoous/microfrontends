import 'package:base_style_sheet/src/presentation/widgets/charts/pie_chart.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

void main() {
  testWidgets('Pie chart test', (WidgetTester tester) async {
    List<Map<String, dynamic>> dataTest = const [
      {'domain': 'Flutter', 'measure': 28},
      {'domain': 'React Native', 'measure': 27},
      {'domain': 'Ionic', 'measure': 20},
      {'domain': 'Cordova', 'measure': 15},
    ];

    PieChart pieChart = PieChart(
      data: dataTest,
    );

    await tester.pumpWidget(
      makeTestable(pieChart),
    );

    final Finder chartFinder = find.byType(DChartPie);
    final DChartPie dChartPie = tester.widget(chartFinder);

    expect(
      dChartPie.fillColor,
      isA<Color Function(Map<String, dynamic>, int?)>(),
    );
    expect(
      dChartPie.labelPosition,
      PieLabelPosition.auto,
    );
    expect(
      dChartPie.labelFontSize,
      12,
    );
    expect(
      dChartPie.labelColor,
      Colors.black,
    );
    expect(
      dChartPie.showLabelLine,
      true,
    );
    expect(
      dChartPie.labelLineColor,
      Colors.black,
    );
    expect(
      dChartPie.labelLinelength,
      16,
    );
    expect(dChartPie.labelLineThickness, 1);
    expect(dChartPie.labelPadding, 5);
    expect(dChartPie.strokeWidth, 2);
  });
}
