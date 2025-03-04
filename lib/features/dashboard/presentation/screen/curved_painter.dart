import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  CurvedPainter({
    required this.fillColor,
    // this.borderColor = Colors.black,
    this.borderColor = Colors.orangeAccent,
    this.borderWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    var borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.1, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
