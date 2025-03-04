import 'dart:math';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:flutter/material.dart';

typedef OnTap = void Function(double position);

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.dotsCount,
    this.position = 0.0,
    this.decorator = const DotsDecorator(),
    this.axis = Axis.horizontal,
    this.reversed = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTap,
  })  : assert(dotsCount > 0, 'Dot count should be greater than 0'),
        assert(position >= 0, 'Position count should be greater than 0'),
        assert(
          position < dotsCount,
          // ignore: prefer_single_quotes
          "Position must be inferior than dotsCount",
        );
  final int dotsCount;
  final double position;
  final DotsDecorator decorator;
  final Axis axis;
  final bool reversed;
  final OnTap? onTap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  Widget _buildDot(int index) {
    final state = min(1, (position - index).abs()).toDouble();

    final size = Size.lerp(decorator.activeSize, decorator.size, state)!;
    final color = Color.lerp(decorator.activeColor, decorator.color, state);

    final dot = AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: position == index ? color : color!.withOpacity(0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return onTap == null
        ? dot
        : InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onTap!(index.toDouble()),
            child: dot,
          );
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);
    final dots = reversed == true ? dotsList.reversed.toList() : dotsList;

    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          )
        : Wrap(
            alignment: WrapAlignment.center,
            children: dots,
          );
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.dashWidth = 9,
    this.dashSpace = 5,
    this.strokeWidth = 1,
    this.axis = Axis.horizontal,
    this.color = Colors.grey,
  });

  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Axis axis;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
        dashSpace: dashSpace,
        dashWidth: dashWidth,
        strokeWidth: strokeWidth,
        axis: axis,
        color: color,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
    required this.axis,
    required this.color,
  });
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Axis axis;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // double dashWidth = 9, dashSpace = 5, startX = 0;
    var start = 0.0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    if (axis == Axis.horizontal) {
      while (start < size.width) {
        canvas.drawLine(Offset(start, 0), Offset(start + dashWidth, 0), paint);
        start += dashWidth + dashSpace;
      }
    } else {
      while (start < size.height) {
        canvas.drawLine(Offset(0, start), Offset(0, start + dashWidth), paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
