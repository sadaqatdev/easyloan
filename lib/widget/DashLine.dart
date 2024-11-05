import 'package:flutter/material.dart';

/// 
class DashLine extends StatelessWidget {
  static const int DIRECTION_LINEAR = 0;

  static const int DIRECTION_VERTICAL = 1;

  DashLine({
    required this.size,
    this.direction = DIRECTION_LINEAR,
    this.dashLineSize = 5,
    this.spacingSize = 3,
    this.color = Colors.grey,
    this.radius = Radius.zero,
  });

  final Size size;

  final int direction;

  final double dashLineSize;

  final double spacingSize;

  final Color color;

  final Radius radius;

  @override
  Widget build(BuildContext context) => ClipRect(
      child: CustomPaint(
          size: size,
          painter: _DashLinePainter(
              direction: direction,
              dashLineSize: dashLineSize,
              spacingSize: spacingSize,
              color: color,
              radius: radius)));
}

class _DashLinePainter extends CustomPainter {
  _DashLinePainter({
    this.direction = DashLine.DIRECTION_LINEAR,
    this.dashLineSize = 10,
    this.spacingSize = 3,
    this.color = Colors.grey,
    this.radius = Radius.zero,
  });

  Paint _paint = Paint();

  final int direction;

  final double dashLineSize;

  final double spacingSize;

  final Color color;

  final Radius radius;

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..isAntiAlias = true
      ..color = color;
    int lineCount = 0;
    double blockSize = dashLineSize + spacingSize;
    if (direction == DashLine.DIRECTION_VERTICAL) {
      int intCount = size.height ~/ blockSize;
      lineCount = intCount + (size.height - intCount > 0 ? 1 : 0);
      for (var i = 0; i < lineCount; i++) {
        double top = i * blockSize;
        double bottom = i * blockSize + dashLineSize;
        canvas.drawRRect(
            RRect.fromLTRBR(0, top, size.width, bottom, radius), _paint);
      }
    } else {
      int intCount = size.width ~/ (dashLineSize + spacingSize);
      lineCount = intCount + ((size.width - intCount > 0) ? 1 : 0);
      for (var i = 0; i < lineCount; i++) {
        double left = i * blockSize;
        double right = i * blockSize + dashLineSize;
        canvas.drawRRect(
            RRect.fromLTRBR(left, 0, right, size.height, radius), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    var old = oldDelegate as _DashLinePainter;
    return old.color != color ||
        old.radius != radius ||
        old.direction != direction ||
        old.dashLineSize != dashLineSize ||
        old.spacingSize != spacingSize;
  }
}