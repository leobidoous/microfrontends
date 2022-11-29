import 'package:flutter/material.dart';

import '../cards/default_card.dart';
import 'line_chart.dart';

class ChartPLDSemanal extends StatelessWidget {
  const ChartPLDSemanal({super.key});

  Widget _buildChartTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '117,80',
                        style: TextStyle(
                          color: Color(0xFF78B82A),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Média do periudo',
                        style: TextStyle(
                          color: Color(0xFF475064),
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '59,93',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'ref semana 52',
                        style: TextStyle(
                          color: Color(0xFF475064),
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBody() {
    return Expanded(
      child: SizedBox(
        height: 280,
        child: LineChart(
          lineColor: (lineData, index, id) {
            switch (id) {
              case 'Line 1':
                return Colors.orange;
            }
            return Colors.transparent;
          },
          data: const [
            {
              'id': 'Line 1',
              'data': [
                {'domain': 0, 'measure': 6},
                {'domain': 1, 'measure': 5.6},
                {'domain': 2, 'measure': 5.6},
                {'domain': 3, 'measure': 5.4},
                {'domain': 4, 'measure': 4.9},
                {'domain': 5, 'measure': 3.0},
                {'domain': 6, 'measure': 2.8},
                {'domain': 7, 'measure': 2.7},
                {'domain': 8, 'measure': 2.4},
                {'domain': 9, 'measure': 2.6},
                {'domain': 10, 'measure': 2.5},
                {'domain': 11, 'measure': 2.6},
                {'domain': 12, 'measure': 2.5},
              ],
            }
          ],
          includePoints: true,
          includeArea: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 320),
      child: DefaultCard(
        child: Column(
          children: [
            _buildChartTitle(),
            _buildChartBody(),
          ],
        ),
      ),
    );
  }
}
