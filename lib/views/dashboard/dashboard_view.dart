import 'package:blink/views/dashboard/dashboard_view_model.dart';
import 'package:blink/views/dashboard/widgets/credit_card.dart';
import 'package:blink/views/time_line_view.dart';
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

    context.read<DashboardViewModel>().translateSettingsUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    context.read<DashboardViewModel>().animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: context.read<DashboardViewModel>().translateSettingsUpController,
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



    context.read<DashboardViewModel>().translateSidewaysController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    context.read<DashboardViewModel>().translateTimelineDownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      reverseDuration: const Duration(milliseconds: 400),
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
    return Scaffold(
      body: Stack(
        children: [
          ///Settings page
          ///Timeline page
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.linearToEaseOut,
            child: context.read<DashboardViewModel>().settings
                ? const SettingsView(key: Key("Setting"),)
                : context.read<DashboardViewModel>().timelinePage
                  ? const TimelineView(key: Key("Timeline"),)
                  : const SizedBox(),
          ),
          AnimatedBuilder(
            animation: context.read<DashboardViewModel>().translateTimelineDownController,
            child: AnimatedBuilder(
              animation: context.read<DashboardViewModel>().translateSettingsUpController,
              child: SafeArea(
                child: Container(
                  color: context.read<DashboardViewModel>().settings
                      ? Colors.white
                      : Colors.transparent,
                  margin: EdgeInsets.only(bottom: context.read<DashboardViewModel>().timelinePage?0:130),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: context.read<DashboardViewModel>().timelinePage ? 0: 1,
                          child: totalBalance(),
                        ),
                        _pageViewWidget(),
                      _pageViewIndicator(),
                    ],
                  ),
                ),
              ),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, context.read<DashboardViewModel>().animation.value* (-MediaQuery.of(context).size.height*0.65)),
                  child: Transform.scale(
                    scale: context.read<DashboardViewModel>().scaleAnimationController.value,
                    child: child,
                  ),
                );
              }
            ),
            builder: (context, child) {
              ///Timeline animation
              return Transform.translate(
                offset: Offset(0, context.read<DashboardViewModel>().translateTimelineDownController.value* (MediaQuery.of(context).size.height*0.65)),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  _pageViewWidget() {
    return Expanded(
      child: PageView.builder(
        itemCount: 3,
        controller: pageController,
        ///If settings page or timeline page is active do not scroll horizontal (swipe)
        physics: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().timelinePage
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        onPageChanged: (int value) {
          setState(() {
            pageViewIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: context.read<DashboardViewModel>().timelinePage?130:0),
            child: AnimatedBuilder(
              animation: context.read<DashboardViewModel>().translateSidewaysController,
              ///Tilted semicircle
              child: AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  double value = 0;
                  ///Checking if pageController is ready to use
                  if(pageController.position.hasContentDimensions) {
                    ///For current page value = 0, so rotation and translation value is zero
                    value = index.toDouble() - (pageController.page??0);
                    value = (value * 0.012);
                  }
                  ///Tilted semicircle
                  return Transform.rotate(
                    angle: (math.pi * value),
                    child: Transform.translate(
                      offset: Offset(0, value.abs() * 500),
                      child: AnimatedOpacity(
                        opacity: index == pageViewIndex
                            ? 1
                            : 0.5,
                        duration: const Duration(milliseconds: 400),
                        child: _cards(index),
                      ),
                    ),
                  );
                },
              ),
              builder: (context, child) {
              ///Side ways translation timeline animation
                return Transform.translate(
                  offset: pageViewIndex == index
                      ? const Offset(0, 0)
                      : pageViewIndex < index
                          ? Offset(context.read<DashboardViewModel>().translateSidewaysController.value*100, 0)
                          : Offset(-context.read<DashboardViewModel>().translateSidewaysController.value*100, 0) ,
                  child: child,
                );
              }
            ),
          );
        },
      ),
    );
  }

  _cards(int index) {
    return index == 0
        ? const MyAccountCard()
        : index == 1
            ? const CreditCard()
            : const DebitCard();
  }

  _pageViewIndicator() {
    ///Hide indicator when settings page is active
    return AnimatedCrossFade(
      firstChild: const SizedBox(),
      secondChild: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 0),
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
      crossFadeState: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().timelinePage
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }
}

Widget totalBalance() {
  return Builder(
    builder: (context) {
      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
              ],
            ),
          ),
        ],
      );
    }
  );
}
