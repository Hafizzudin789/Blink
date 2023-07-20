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

class _MainMenuViewState extends State<MainMenuView> with SingleTickerProviderStateMixin{

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
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.3);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    pageController.dispose();
    super.dispose();
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


  int tappedMainMenuIndex = 0;
  Color tappedMainMenuColor = Colors.white;
  Color tappedMainMenuContentColor = Colors.black;
  _cards(int index) {
    LayoutViewModel layoutViewModel = context.read<LayoutViewModel>();
    return GestureDetector(
      onTap: () {
        layoutViewModel.onClickMainMenu(index, context);
      },
      onPanDown: (_) {
        setState(() {
          tappedMainMenuIndex = index;
          tappedMainMenuColor = primaryButtonColor;
          tappedMainMenuContentColor = Colors.white;
        });
        _animationController.forward();
      },
      onPanCancel: () {
        setState(() {
          tappedMainMenuColor = Colors.white;
          tappedMainMenuContentColor = Colors.black;
        });
        _animationController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(
            begin: 1.0,
            end: index == tappedMainMenuIndex
                ? 0.95
                : 1
        ).animate(_animationController),
        child: Container(
          decoration: BoxDecoration(
            color: index == tappedMainMenuIndex
                ? tappedMainMenuColor
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
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
                  color: index == tappedMainMenuIndex
                      ? tappedMainMenuContentColor
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                menuItems[index]["title"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: index == tappedMainMenuIndex
                        ? tappedMainMenuContentColor
                        : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }


}