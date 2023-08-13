import 'package:blink/constant/app_color.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String svgImage;
  const IconWidget({super.key, required this.svgImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: gray300Color, width: 1)
      ),
      child: SVGImage(assetPath: svgImage),
    );
  }
}
