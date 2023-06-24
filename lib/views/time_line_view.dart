import 'package:blink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({super.key});

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomButton(
              label: "Add money",
              foregroundColor: Colors.white,
              buttonColor: primaryButtonColor,
            ),
            const SizedBox(height: 300),
            Image.asset("assets/image/img.png")
          ],
        ),
      ),
    );
  }
}
