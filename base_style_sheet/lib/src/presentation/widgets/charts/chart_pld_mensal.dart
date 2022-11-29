import 'package:flutter/material.dart';

import '../cards/default_card.dart';
import 'line_chart.dart';

class ChartPLDMensal extends StatelessWidget {
  const ChartPLDMensal({super.key});

  Widget _buildChartSumario() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'SE/CO',
                    style: TextStyle(
                      color: Color(0xFF475064),
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'S',
                    style: TextStyle(
                      color: Color(0xFF475064),
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //Right

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'NE',
                    style: TextStyle(
                      color: Color(0xFF475064),
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'N',
                    style: TextStyle(
                      color: Color(0xFF475064),
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
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
              case 'Line 2':
                return Colors.green;
              case 'Line 3':
                return Colors.blue;
              case 'Line 4':
                return Colors.pink;
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
            },
            {
              'id': 'Line 2',
              'data': [
                {'domain': 0, 'measure': 6},
                {'domain': 1, 'measure': 5.6},
                {'domain': 2, 'measure': 4.6},
                {'domain': 3, 'measure': 5.4},
                {'domain': 4, 'measure': 2.9},
                {'domain': 5, 'measure': 3.0},
                {'domain': 6, 'measure': 2.8},
                {'domain': 7, 'measure': 4.7},
                {'domain': 8, 'measure': 2.4},
                {'domain': 9, 'measure': 2.6},
                {'domain': 10, 'measure': 2.5},
                {'domain': 11, 'measure': 2.6},
                {'domain': 12, 'measure': 2.5},
              ],
            },
            {
              'id': 'Line 3',
              'data': [
                {'domain': 0, 'measure': 6},
                {'domain': 1, 'measure': 5.6},
                {'domain': 2, 'measure': 6},
                {'domain': 3, 'measure': 5.4},
                {'domain': 4, 'measure': 5.8},
                {'domain': 5, 'measure': 4.0},
                {'domain': 6, 'measure': 3.8},
                {'domain': 7, 'measure': 2.7},
                {'domain': 8, 'measure': 3.4},
                {'domain': 9, 'measure': 2.6},
                {'domain': 10, 'measure': 2.8},
                {'domain': 11, 'measure': 2.6},
                {'domain': 12, 'measure': 2.2},
              ],
            },
            {
              'id': 'Line 4',
              'data': [
                {'domain': 0, 'measure': 6},
                {'domain': 1, 'measure': 5.6},
                {'domain': 2, 'measure': 6},
                {'domain': 3, 'measure': 5.4},
                {'domain': 4, 'measure': 6},
                {'domain': 5, 'measure': 4.0},
                {'domain': 6, 'measure': 3.8},
                {'domain': 7, 'measure': 3.7},
                {'domain': 8, 'measure': 3.4},
                {'domain': 9, 'measure': 1.6},
                {'domain': 10, 'measure': 2.8},
                {'domain': 11, 'measure': 2.9},
                {'domain': 12, 'measure': 3.0},
              ],
            }
          ],
          includePoints: true,
          includeArea: false,
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
            _buildChartBody(),
            _buildChartSumario(),
          ],
        ),
      ),
    );
  }
}
