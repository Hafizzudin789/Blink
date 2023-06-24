import 'package:blink/views/dashboard/dashboard_view_model.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:blink/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const DashboardView(),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: context.watch<DashboardViewModel>().settings
                ? 0
                : 1,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
              ),
              child: SizedBox(
                height: context.watch<DashboardViewModel>().bottomNavbarHeight,
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
            ),
          ),
        ],
      ),
    );
  }
}
