import 'package:flutter/material.dart';
import '../app_color.dart';
import 'dart:math' as math;

class CustomPatternCircleMyAccount extends CustomPainter {
  const CustomPatternCircleMyAccount({Key? key});

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

class CustomPatternCircleDebitCard extends CustomPainter {
  const CustomPatternCircleDebitCard({Key? key});

  @override
  void paint(Canvas canvas, Size size) {
    Offset startingPoint = Offset(size.width * 0.3, size.height * 0.58);

    ///Big circle
    final paint = Paint()..color = pinkColor;
    canvas.drawCircle(startingPoint, 55, paint);



    ///Curve lines
    List<Offset> points = [
      startingPoint,
      Offset(startingPoint.dx, startingPoint.dy+60),

      Offset(startingPoint.dx + 40, startingPoint.dy+60),
      Offset(startingPoint.dx + 40, startingPoint.dy+20),

      Offset(startingPoint.dx + 80, startingPoint.dy+20),
      Offset(startingPoint.dx + 80, startingPoint.dy +60),

      Offset(startingPoint.dx + 120, startingPoint.dy +60),
      Offset(startingPoint.dx + 120, startingPoint.dy+20),

      Offset(startingPoint.dx + 160, startingPoint.dy+20),
      Offset(startingPoint.dx + 160, startingPoint.dy +60),

      Offset(startingPoint.dx + 200, startingPoint.dy +60),
      Offset(startingPoint.dx + 200, startingPoint.dy+20),

      Offset(startingPoint.dx + 240, startingPoint.dy+20),
      Offset(startingPoint.dx + 240, startingPoint.dy +60),

      Offset(startingPoint.dx + 280, startingPoint.dy +60),
      Offset(startingPoint.dx + 280, startingPoint.dy+20),

      Offset(startingPoint.dx + 320, startingPoint.dy+20),
      Offset(startingPoint.dx + 320, startingPoint.dy +60),

      Offset(startingPoint.dx + 360, startingPoint.dy +60),
      Offset(startingPoint.dx + 360, startingPoint.dy+20),

      Offset(startingPoint.dx + 400, startingPoint.dy+20),
      Offset(startingPoint.dx + 400, startingPoint.dy +60),

      Offset(startingPoint.dx + 440, startingPoint.dy +60),
      Offset(startingPoint.dx + 440, startingPoint.dy+20),

    ];

    final paint1 = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.white;
    
    for(int i = 0; i <points.length -1; i++) {
      Offset current = points[i];
      Offset next = points[i+1];
      if(i.isOdd) {
        ///Manual check can for drawing arcs
        if(i == 1 || i == 5 ||i == 9||i == 13||i == 17) {
          Rect rect = Rect.fromCenter(center: Offset(points[i].dx+20, points[i].dy), width: 40, height: 40);

          canvas.drawArc(
              rect,
              0,
              math.pi,
              false,
              paint1);
        } else {
          Rect rect = Rect.fromCenter(center: Offset(points[i].dx+20, points[i].dy), width: 40, height: 40);

          canvas.drawArc(
              rect,
              math.pi,
              math.pi,
              false,
              paint1);
        }

      } else {
        canvas.drawLine(current, next, paint1);
      }
    }


    

    ///Small circle at the start of line
    final paint3 = Paint()..color = yellowColor;
    canvas.drawCircle(Offset(points[0].dx, points[0].dy), 10, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}