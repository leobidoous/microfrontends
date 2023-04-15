import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ParkingRegulationPage extends StatefulWidget {
  const ParkingRegulationPage({super.key, required this.rulesUrl});

  final String rulesUrl;

  @override
  State<ParkingRegulationPage> createState() => _ParkingRegulationPageState();
}

class _ParkingRegulationPageState extends State<ParkingRegulationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(title: 'Regulamento'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: GenPdfView(url: widget.rulesUrl)),
            Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: GenButton.text(
                text: 'Voltar',
                onPressed: Nav.to.pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
