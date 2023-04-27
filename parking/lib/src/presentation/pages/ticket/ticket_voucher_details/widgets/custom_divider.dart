part of '../ticket_voucher_details_page.dart';

class DashedDividerStriped extends StatelessWidget {
  const DashedDividerStriped({
    super.key,
    this.height = 16.0,
    this.thickness = 1.0,
    this.color = Colors.grey,
  });

  final double height;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedDividerPainter(
        height: height,
        thickness: thickness,
        color: color,
      ),
    );
  }
}

class _DashedDividerPainter extends CustomPainter {
  _DashedDividerPainter({
    required this.height,
    required this.thickness,
    required this.color,
  });

  final double height;
  final double thickness;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    const dashWidth = 10.0;
    const dashSpace = 5.0;

    double startY = size.height / 2;
    double endY = startY;
    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(currentX + dashWidth, endY),
        paint,
      );

      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedDividerPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_DashedDividerPainter oldDelegate) => false;
}
