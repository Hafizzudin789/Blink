import 'package:blink/widgets/custom_svg_image.dart';
import 'package:blink/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const DashboardView(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          backgroundColor: Colors.white,
          onTap: (value) {},
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: SVGImage(assetPath: "assets/icons/home.svg"),
              ),
            ),
            BottomNavigationBarItem(
              label: "Main",
              icon: SVGImage(assetPath: "assets/icons/mainButton.svg"),
            ),
            BottomNavigationBarItem(
              label: "Support",
              icon: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: SVGImage(assetPath: "assets/icons/headPhone.svg"),
              ),
            )

          ],
        ),
      ),
    );
  }
}
