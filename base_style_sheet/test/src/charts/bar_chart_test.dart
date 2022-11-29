import 'package:base_style_sheet/src/presentation/widgets/charts/bar_chart.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

void main() {
  testWidgets('Bar chart test', (WidgetTester tester) async {
    List<Map<String, dynamic>> dataTest = const [
      {
        'id': 'Bar',
        'data': [
          {'domain': '2020', 'measure': 3},
          {'domain': '2021', 'measure': 4},
          {'domain': '2022', 'measure': 6},
          {'domain': '2023', 'measure': 0.3},
        ],
      },
    ];

    BarChart barChart = BarChart(
      data: dataTest,
    );

    await tester.pumpWidget(
      makeTestable(barChart),
    );

    final Finder chartFinder = find.byType(DChartBar);
    final DChartBar dChartBar = tester.widget(chartFinder);

    expect(chartFinder, findsOneWidget);
    expect(dChartBar.domainLabelPaddingToAxisLine, 16);
    expect(dChartBar.axisLineTick, 2);
    expect(dChartBar.axisLinePointTick, 2);
    expect(dChartBar.axisLinePointWidth, 10);
    expect(dChartBar.axisLineColor, Colors.blueGrey);
    expect(dChartBar.measureLabelPaddingToAxisLine, 16);
    expect(
      dChartBar.barColor,
      isA<Color Function(Map<String, dynamic>, int?, String)>(),
    );
    expect(dChartBar.showBarValue, false);
    expect(dChartBar.barValueFontSize, 14);
    expect(dChartBar.verticalDirection, true);
    expect(dChartBar.domainAxisTitleColor, Colors.black);
    expect(dChartBar.domainAxisTitleFontSize, 14);
    expect(dChartBar.domainAxisTitleInPadding, 8);
    expect(dChartBar.domainAxisTitleOutPadding, 0);
    expect(dChartBar.domainAxisTitlePosition, TitlePositionX.bottom);
    expect(dChartBar.measureAxisTitleColor, Colors.black);
    expect(dChartBar.measureAxisTitleColor, Colors.black);
    expect(dChartBar.measureAxisTitleFontSize, 14);
    expect(dChartBar.measureAxisTitleInPadding, 8);
    expect(dChartBar.measureAxisTitleOutPadding, 0);
    expect(dChartBar.measureAxisTitlePosition, TitlePositionY.left);
  });
}
