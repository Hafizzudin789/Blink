import 'package:blink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import 'dashboard/dashboard_view.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({super.key});

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width*0.15;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            totalBalance(),
            const SizedBox(height: 16),
            CustomButton(
              label: "Add money",
              foregroundColor: Colors.white,
              buttonColor: primaryButtonColor,
              onTap: () {},
            ),
            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28.0),
                    child: Image.asset("assets/image/elementSwirl.png", height: 200, scale: 2,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Image.asset("assets/image/img.png"),
            )
          ],
        ),
      ),
    );
  }
}
