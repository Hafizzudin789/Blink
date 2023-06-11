import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class ElevatedCustomButton extends StatelessWidget {
  final String label;
  final Color buttonColor;
  final Color foregroundColor;
  final double fontSize;
  final VoidCallback? onTap;
  const ElevatedCustomButton({super.key, required this.label, this.buttonColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.fontSize = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),
          side: const BorderSide(color: gray200Color)
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 22, vertical: 10)),
        shadowColor: MaterialStateProperty.all(gray200Color),
        elevation: MaterialStateProperty.all(4)
      ),
      child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),),
    );
  }
}
