import 'package:flutter/material.dart';
import 'dart:math' as math;

class PatternPainter extends CustomPainter {
  final String pattern;
  final Color color;

  PatternPainter({required this.pattern, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    switch (pattern) {
      case 'circuit':
        _paintCircuit(canvas, size);
      case 'dots':
        _paintDots(canvas, size);
      case 'grid':
        _paintGrid(canvas, size);
      case 'none':
        break;
    }
  }

  void _paintCircuit(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final rng = math.Random(42);
    const step = 30.0;

    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        if (rng.nextBool()) {
          final path = Path();
          path.moveTo(x, y);
          final dir = rng.nextInt(4);
          switch (dir) {
            case 0:
              path.lineTo(x + step, y);
              if (rng.nextBool()) path.lineTo(x + step, y + step);
            case 1:
              path.lineTo(x, y + step);
              if (rng.nextBool()) path.lineTo(x + step, y + step);
            case 2:
              path.lineTo(x + step, y);
              path.lineTo(x + step, y + step / 2);
            case 3:
              path.lineTo(x, y + step);
              path.lineTo(x + step / 2, y + step);
          }
          canvas.drawPath(path, paint);
          canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
        }
      }
    }
  }

  void _paintDots(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  void _paintGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 25.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final accentPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double x = 0; x < size.width; x += spacing * 4) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), accentPaint);
    }
    for (double y = 0; y < size.height; y += spacing * 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), accentPaint);
    }
  }

  @override
  bool shouldRepaint(PatternPainter oldDelegate) =>
      oldDelegate.pattern != pattern || oldDelegate.color != color;
}
