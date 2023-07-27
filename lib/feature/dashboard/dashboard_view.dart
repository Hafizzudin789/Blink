import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:blink/feature/dashboard/widgets/credit_card.dart';
import 'package:blink/feature/time_line_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import 'dart:math' as math;
import '../../constant/constants.dart';
import '../../widgets/custom_svg_image.dart';
import '../layout/layout_view_model.dart';
import '../pay_back_view.dart';
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

  bool get myAccount {
    return pageViewIndex == 0;
  }

  bool get myCreditCard {
    return pageViewIndex == 1;
  }

  bool get myDebitCard {
    return pageViewIndex == 2;
  }



  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.8);
    context.read<DashboardViewModel>().controller = ScrollController();

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
                ? const SettingsView(key: Key("Setting"))
                : context.read<DashboardViewModel>().timelinePage
                ? const TimelineView(key: Key("Timeline"))
                : context.read<DashboardViewModel>().showPayBackView
                ? const PayBackView()
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
                    margin: EdgeInsets.only(bottom: context.read<DashboardViewModel>().timelinePage?0:bottomBarHeight),
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
                    //offset: Offset(0, context.read<DashboardViewModel>().animation.value* (-MediaQuery.of(context).size.height*0.65)),
                    offset: Offset(0, context.read<DashboardViewModel>().animation.value* (-MediaQuery.of(context).size.height*0.7)),
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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            itemCount: 3,
            controller: pageController,
            ///If settings page or timeline page is active do not scroll horizontal (swipe)
            physics: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().timelinePage
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            onPageChanged: (int value) {

              ///Flip card bug fix
              if(value == 0 && !context.read<LayoutViewModel>().showButtonsInDebitCard) {
                context.read<LayoutViewModel>().showButtonsDebitCard();
              }

              setState(() {
                pageViewIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: context.read<DashboardViewModel>().timelinePage?bottomBarHeight:0),
                child: AnimatedBuilder(
                  animation: context.read<DashboardViewModel>().translateSidewaysController,
                  ///Tilted semicircle
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
                  },
                  child: AnimatedBuilder(
                    animation: pageController,
                    child: _cards(index),
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
                            child: child!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          ///Timeline Button
          ///For My Account and My credit card
          Positioned(
            top: 20,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if(myCreditCard) {
                  if(!context.read<LayoutViewModel>().showButtonsInCreditCard) return;
                  context.read<DashboardViewModel>().showTimeline(!context.read<DashboardViewModel>().timelinePage);
                }
                if(myAccount) {
                  //TODO:
                }
              },
              child: AnimatedOpacity(
                ///For Credit Card
                duration: const Duration(milliseconds: 500),
                opacity: (!context.watch<LayoutViewModel>().showButtonsInCreditCard && myCreditCard)
                    || (!context.watch<LayoutViewModel>().showButtonsInDebitCard && myDebitCard)
                    ? 0
                    : 1,
                child: AnimatedBuilder(
                  animation: pageController,
                  builder: (BuildContext context, Widget? child) {
                    double translateYOffset = 0;
                    double opacity = 0;
                    if(pageController.position.hasContentDimensions) {
                      opacity = pageViewIndex - (pageController.page??0);
                      translateYOffset = pageViewIndex - (pageController.page??0);
                    }
                    return Transform.translate(
                      offset: Offset(0, translateYOffset.abs() * -40),
                      child: Opacity(
                        opacity: (opacity.abs() -1).abs(),
                        child: child!,
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: gray200Color, width: 1)
                    ),
                    //child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
                    ///For Credit Card
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: !context.read<DashboardViewModel>().timelinePage
                          ? const SVGImage(assetPath: "assets/icons/audioWave.svg")
                          : const SVGImage(assetPath: "assets/icons/up.svg"),
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///Transactions button
          ///For My Account and My credit card
          Positioned(
            bottom: 20,
            child: myDebitCard
                ///No transaction button for debit card
                ? const SizedBox()
                : InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if(myCreditCard) {
                        if(context.read<DashboardViewModel>().settings) {
                          context.read<DashboardViewModel>().showSettingPage(false);
                          return;
                        }

                        if(context.read<DashboardViewModel>().showPayBackView) {
                          context.read<DashboardViewModel>().goToPayBackView(false);
                          return;
                        }

                        if(context.read<LayoutViewModel>().showButtonsInCreditCard) {
                          context.read<DashboardViewModel>().goToTransactionPage(context);
                          return;
                        }


                      }
                      if(myAccount) {
                        ///TODO:
                      }
                    },
                    child: AnimatedOpacity(
                        ///For credit card
                        duration: const Duration(milliseconds: 500),
                        opacity: !context.watch<LayoutViewModel>().showButtonsInCreditCard && myCreditCard
                            ? 0
                            : 1,
                        child: AnimatedBuilder(
                          animation: pageController,
                          builder: (BuildContext context, Widget? child) {
                            double translateYOffset = 0;
                            double opacity = 0;
                            if(pageController.position.hasContentDimensions) {
                              opacity = pageViewIndex - (pageController.page??0);
                              translateYOffset = pageViewIndex - (pageController.page??0);
                            }
                            return Transform.translate(
                              offset: Offset(0, translateYOffset.abs() * 40),
                              child: Opacity(
                                opacity: (opacity.abs() -1).abs(),
                                child: child!,
                              ),
                            );
                          },
                          ///For credit card
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().showPayBackView
                                  ? 48
                                  : 150,
                              height: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().showPayBackView
                                  ? 48
                                  : 44,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: gray200Color, width: 1),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(color: gray200Color, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0,4))
                                ],
                              ),
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 500),
                                reverseDuration: const Duration(milliseconds: 500),
                                firstCurve: Curves.easeIn,
                                secondCurve: Curves.easeIn,
                                alignment: Alignment.center,
                                crossFadeState: context.watch<DashboardViewModel>().settings || context.read<DashboardViewModel>().showPayBackView
                                    ? CrossFadeState.showFirst:CrossFadeState.showSecond,
                                firstChild: const SVGImage(assetPath: "assets/icons/down.svg"),
                                secondChild: const Text("Transactions", style: TextStyle(color: primaryButtonColor, fontSize: 12, fontWeight: FontWeight.w600),),
                              ),
                          ),
                        ),
                      ),
                  ),
          ),

        ],
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
    ///Hide indicator when settings, timeline, payback page is active
    return AnimatedCrossFade(
      crossFadeState: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().timelinePage || context.read<DashboardViewModel>().showPayBackView
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
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
