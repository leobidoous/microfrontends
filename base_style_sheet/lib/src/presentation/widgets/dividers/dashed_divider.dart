// widget de linha pontilhada
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _LineDashedPainter extends CustomPainter {
  _LineDashedPainter(this.strokeWidth, this.lineSize);
  final double lineSize;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColorsBase.grey3
      ..strokeWidth = strokeWidth;
    var dashWidth = 5;
    var dashSpace = 5;
    double max = lineSize - (const Spacing(2).value) - (dashSpace + dashWidth);
    double startX = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      final space = (dashSpace + dashWidth);
      startX += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedDivider extends StatelessWidget {
  final double height;
  const DashedDivider({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineDashedPainter(height, context.width),
    );
  }
}
