import 'package:blink/feature/layout/layout_view_model.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../constant/app_color.dart';
import '../../constant/constants.dart';


class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {

  int pageViewIndex = 0;
  List menuItems = [
    {
      "title": "Payments",
      "icon": "assets/main_menu/payments.svg",
    },
    {
      "title": "eVouchers",
      "icon": "assets/main_menu/eVouchers.svg",
    },
    {
      "title": "Manage\nContacts",
      "icon": "assets/main_menu/manageContacts.svg",
    },
    {
      "title": "Manage\nCliQ",
      "icon": "assets/main_menu/cliq.svg",
    },
    {
      "title": "Profile\nSettings",
      "icon": "assets/main_menu/profile.svg",
    },
    {
      "title": "Lout Out",
      "icon": "assets/main_menu/logout.svg",
    },
  ];

  late PageController pageController;


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.3);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      margin: EdgeInsets.only(bottom: bottomBarHeight),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: PageView.builder(
            itemCount: menuItems.length,
            controller: pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (int value) {
              setState(() {
                pageViewIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  double value = 0;

                  ///Y coordinate
                  double translateValue = 0;
                  ///Checking if pageController is ready to use
                  if(pageController.position.hasContentDimensions) {
                    ///For current page value = 0, so rotation and translation value is zero
                    double indexFinal = index.toDouble();
                    value = indexFinal - (pageController.page??0);
                    value = (value * 0.01);

                    if(value.abs()>=0.02) {
                      translateValue = value.abs() * 500;
                    } else if(value.abs()>=0.018){
                      translateValue = value.abs() * 460;
                    } else if(value.abs()>=0.016){
                      translateValue = value.abs() * 420;
                    } else if(value.abs()>=0.014){
                      translateValue = value.abs() * 380;
                    } else if(value.abs()>=0.012){
                      translateValue = value.abs() * 340;
                    } else {
                      translateValue = value.abs() * 300;
                    }
                  }

                  return Transform.rotate(
                    angle: (math.pi * value),
                    child: Transform.translate(
                      offset: Offset(0, translateValue),
                      child: _cards(index),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _cards(int index) {
    LayoutViewModel layoutViewModel = context.read<LayoutViewModel>();
    return InkWell(
      splashColor: primaryButtonColor,
      highlightColor: primaryButtonColor,
      onTap: () {
        layoutViewModel.onClickMainMenu(index, context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: gray200Color, width: 1.5),
              ),
              child: SVGImage(
                assetPath: menuItems[index]["icon"],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              menuItems[index]["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


}