import 'package:blink/views/dashboard/dashboard_view_model.dart';
import 'package:blink/views/dashboard/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import 'dart:math' as math;

import '../settings_view.dart';
import 'widgets/debit_card.dart';
import 'widgets/my_account_card.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with TickerProviderStateMixin{

  int pageViewIndex = 0;
  List cards = [1,2,3]; ///Number of cards to horizontally scroll

  late PageController pageController;



  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.8);

    context.read<DashboardViewModel>().translateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    context.read<DashboardViewModel>().animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: context.read<DashboardViewModel>().translateAnimationController,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
      ),
    );


    context.read<DashboardViewModel>().scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 1,
      upperBound: 2,
    );

  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    context.read<DashboardViewModel>().disposeControllers();
  }



  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: AnimatedBuilder(
    //       animation: context.read<DashboardViewModel>().translateAnimationController,
    //       builder: (context, child) {
    //         return SafeArea(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               _totalBalance(),
    //               _pageViewWidget(),
    //               _pageViewIndicator(),
    //             ],
    //           ),
    //         );
    //       }
    //   ),
    // );
    return Scaffold(
      body: Stack(
        children: [
          const SettingsView(),
          AnimatedBuilder(
            animation: context.read<DashboardViewModel>().translateAnimationController,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _totalBalance(),
                    _pageViewWidget(),
                    _pageViewIndicator(),
                  ],
                ),
              ),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, context.read<DashboardViewModel>().animation.value* (-MediaQuery.of(context).size.height*0.8)),
                child: Transform.scale(
                  scale: context.read<DashboardViewModel>().scaleAnimationController.value,
                  child: child,
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _totalBalance() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        const Text("Total Balance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: blackColor),),
        const SizedBox(height: 4),
        const Text.rich(
          TextSpan(
            style: TextStyle(color: blackColor, fontSize: 24, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: "7,896.00"
              ),
              TextSpan(
                text: " JOD",
                style: TextStyle(color: gray300Color, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ]
          ),
        ),
      ],
    );
  }

  _pageViewWidget() {
    return Expanded(
      child: PageView.builder(
        itemCount: 3,
        controller: pageController,
        ///If settings page is active do not scroll horizontal (swipe)
        physics: context.watch<DashboardViewModel>().settings
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        onPageChanged: (int value) {
          setState(() {
            pageViewIndex = value;
          });
        },
        itemBuilder: (context, index) {
          ///Bit tilted semicircle
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 0;
              ///Checking if pageController is ready to use
              if(pageController.position.hasContentDimensions) {
                ///For current page value = 0, so rotation and translation value is zero
                value = index.toDouble() - (pageController.page??0);
                value = (value * 0.012);
              }
              return Transform.rotate(
                angle: (math.pi * value),
                child: Transform.translate(
                  offset: Offset(0, value.abs() * 500),
                  child: AnimatedOpacity(
                    opacity: index == pageViewIndex
                        ? 1
                        : 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: index == 0
                        ? const MyAccountCard()
                        : index == 1
                            ? const CreditCard()
                            : const DebitCard(),

                    ///Go to Settings page animation
                    ///Go to Transaction page animation
                    // child: Transform.translate(
                    //   offset: Offset(0, index == pageViewIndex
                    //       ? context.read<DashboardViewModel>().translateAnimationController.value* (-MediaQuery.of(context).size.height)
                    //       : 0),
                    //   child: index == 0
                    //       ? const MyAccountCard()
                    //       : index == 1
                    //         ? const CreditCard()
                    //         : const DebitCard(),
                    // ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


  _pageViewIndicator() {
    ///Hide indicator when settings page is active
    return AnimatedCrossFade(
      firstChild: const SizedBox(),
      secondChild: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...cards.map(
                  (e) => Container(
                height: pageViewIndex == cards.indexOf(e)
                    ? 5
                    : 4,
                width: pageViewIndex == cards.indexOf(e)
                    ? 5
                    : 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pageViewIndex == cards.indexOf(e)
                      ? blackColor
                      : gray400Color,
                ),
              ),
            ),
          ],
        ),
      ),
      crossFadeState: context.watch<DashboardViewModel>().settings
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }

}
