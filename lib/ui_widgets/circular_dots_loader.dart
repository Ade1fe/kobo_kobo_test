
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/constants/constants.dart';

class CircularDotsLoader extends StatefulWidget {
  final Color color;
  final double size;

  const CircularDotsLoader({
    super.key,
    this.color = AppColors.appPrimaryButton,
    this.size = 50.0,
  });

  @override
  _CircularDotsLoaderState createState() => _CircularDotsLoaderState();
}

class _CircularDotsLoaderState extends State<CircularDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _CircularDotsPainter(
          color: widget.color,
          animation: _controller,
          size: widget.size,
        ),
      ),
    );
  }
}

class _CircularDotsPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double size;

  _CircularDotsPainter({
    required this.color,
    required this.animation,
    required this.size,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const totalDots = 8;

    for (int i = 0; i < totalDots; i++) {
      final angle = 2 * 3.14159 * i / totalDots - 3.14159 / 2;
      final x = center.dx + radius * 0.7 * cos(angle);
      final y = center.dy + radius * 0.7 * sin(angle);

      // Increase dot size
      final progress = (animation.value + i / totalDots) % 1.0;
      final dotRadius = radius * 0.2 * (0.5 + 0.5 * progress);

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
