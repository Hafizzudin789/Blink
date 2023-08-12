import 'package:flutter/material.dart';
import 'custom_svg_image.dart';


class CustomIconButton extends StatelessWidget {
  final String svgIconPath;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color borderShadowColor;
  final VoidCallback? onTap;
  const CustomIconButton({super.key, required this.svgIconPath,
    required this.buttonColor,
    required this.buttonBorderColor,
    this.borderShadowColor = Colors.black26,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,
          border: Border.all(color: buttonBorderColor),
          boxShadow: [
            BoxShadow(color: borderShadowColor, blurRadius: 10, spreadRadius: 0.1),
          ],
        ),
        child: SVGImage(assetPath: svgIconPath),
      ),
    );
  }
}
