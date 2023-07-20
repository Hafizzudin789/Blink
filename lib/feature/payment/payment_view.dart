import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../constant/app_color.dart';
import '../../constant/constants.dart';
import '../../widgets/custom_svg_image.dart';
import '../dashboard/dashboard_view_model.dart';
import '../layout/layout_view_model.dart';
import 'widget/request_money_from_card.dart';
import 'widget/sent_money_to_card.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  int pageViewIndex = 0;
  late PageController pageController;

  final List _paymentCardCount = [1,2]; ///Number of cards to horizontally scroll
  


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: context.read<DashboardViewModel>().translateSettingsUpController,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(bottom: bottomBarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: context.read<DashboardViewModel>().timelinePage ? 0: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      const SVGImage(assetPath: "assets/icons/payment.svg"),
                      const Text("Payments", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
                    ],
                  ),
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
        },
      ),
    );
  }

  _pageViewWidget() {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            itemCount: 2,
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
                    child: _paymentCard(index),
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

          ///Transactions button
          ///For My Account and My credit card
          Positioned(
            bottom: 20,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                // if(myCreditCard) {
                //   if(context.read<DashboardViewModel>().settings) {
                //     context.read<DashboardViewModel>().showSettingPage(false);
                //     return;
                //   }
                //
                //   if(context.read<LayoutViewModel>().showButtonsInCreditCard) {
                //     context.read<DashboardViewModel>().goToTransactionPage(context);
                //   }
                // }
                // if(myAccount) {
                //   ///TODO:
                // }
              },
              child: AnimatedOpacity(
                ///For credit card
                duration: const Duration(milliseconds: 500),
                opacity: !context.watch<LayoutViewModel>().showButtonsInCreditCard //&& myCreditCard
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
                    width: context.watch<DashboardViewModel>().settings
                        ? 48
                        : 150,
                    height: context.watch<DashboardViewModel>().settings
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
                      crossFadeState: context.watch<DashboardViewModel>().settings
                          ? CrossFadeState.showFirst:CrossFadeState.showSecond,
                      firstChild: const SVGImage(assetPath: "assets/icons/down.svg"),
                      secondChild: const Text("New Payment", style: TextStyle(color: primaryButtonColor, fontSize: 12, fontWeight: FontWeight.w600),),
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

  _paymentCard(int index) {
    return index == 0
        ? const SendMoneyToCard()
        : const RequestMoneyFromCard();
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
            ..._paymentCardCount.map(
                  (e) => Container(
                height: pageViewIndex == _paymentCardCount.indexOf(e)
                    ? 5
                    : 4,
                width: pageViewIndex == _paymentCardCount.indexOf(e)
                    ? 5
                    : 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pageViewIndex == _paymentCardCount.indexOf(e)
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
