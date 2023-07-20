import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import 'custom_svg_image.dart';


class CustomIconButton extends StatelessWidget {
  final String svgIconPath;
  final Color buttonColor;
  final Color buttonBorderColor;
  const CustomIconButton({super.key, required this.svgIconPath, required this.buttonColor, required this.buttonBorderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: buttonColor,
        border: Border.all(color: buttonBorderColor),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
        ],
      ),
      child: SVGImage(assetPath: svgIconPath),
    );
  }
}
