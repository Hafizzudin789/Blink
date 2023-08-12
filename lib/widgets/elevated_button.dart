import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class ElevatedCustomButton extends StatelessWidget {
  final String label;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color foregroundColor;
  final double fontSize;
  final VoidCallback? onTap;
  final double buttonWidth;
  const ElevatedCustomButton({super.key, required this.label, this.buttonColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.buttonBorderColor = lightPinkColor,
    this.fontSize = 12,
    this.buttonWidth = 150,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: buttonWidth,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: buttonBorderColor, width: 1),
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0,3))
          ],
        ),
        child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: foregroundColor),),
      ),
    );
  }
}
