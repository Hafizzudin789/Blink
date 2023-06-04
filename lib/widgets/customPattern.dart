import 'package:flutter/material.dart';
import '../app_color.dart';

class CustomPatternCircle extends CustomPainter {
  const CustomPatternCircle({Key? key});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = pinkColor;
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 150, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}