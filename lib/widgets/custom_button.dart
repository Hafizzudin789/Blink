import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color buttonColor;
  final Color foregroundColor;
  final double fontSize;
  final VoidCallback? onTap;
  const CustomButton({super.key, required this.label, this.buttonColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.fontSize = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 10))
      ),
      child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),),
    );
  }
}
