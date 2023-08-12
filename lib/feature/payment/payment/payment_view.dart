import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:blink/feature/payment/payment/cards/post_paid_card.dart';
import 'package:blink/feature/payment/payment/cards/pre_paid_card.dart';
import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:blink/feature/payment/request_money_from/receive_money_view.dart';
import 'package:blink/feature/payment/send_money_to/send_money_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../constant/app_color.dart';
import '../../../constant/constants.dart';
import '../../../widgets/custom_svg_image.dart';
import 'cards/request_money_from_card.dart';
import 'cards/sent_money_to_card.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> with TickerProviderStateMixin{

  int pageViewIndex = 0;
  late PageController pageController;

  final List _paymentCardCount = [1,2]; ///Number of cards to horizontally scroll


  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.8);


    context.read<PaymentViewModel>().translateUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    context.read<PaymentViewModel>().translateUpAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: context.read<PaymentViewModel>().translateUpController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );


    context.read<PaymentViewModel>().scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 1,
      upperBound: 2,
    );



    context.read<PaymentViewModel>().translateSidewaysController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );


    _zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _zoomAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_zoomController);
    _zoomController.forward();
  }

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PaymentViewModel readPaymentViewModel = context.read<PaymentViewModel>();
    PaymentViewModel watchPaymentViewModel = context.watch<PaymentViewModel>();
    return Scaffold(
      body: FadeTransition(
        opacity: _zoomAnimation,
        child: AnimatedBuilder(
          animation: _zoomController,
          builder: (context, child) {
            return Transform.scale(
              scale: _zoomAnimation.value,
              child: child!,
            );
          },
          child: Stack(
            children: [
              ///SendMoneyView page
              ///ReceiveMoneyView page
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.linearToEaseOut,
                child: watchPaymentViewModel.showSendMoneyView
                    ? const SendMoneyView()
                    : watchPaymentViewModel.showReceiveMoneyView
                    ? const ReceiveMoneyView()
                    : const SizedBox(),
              ),
              AnimatedBuilder(
                animation: readPaymentViewModel.translateUpController,
                child: SafeArea(
                  child: Container(
                    color: readPaymentViewModel.showSendMoneyView || readPaymentViewModel.showReceiveMoneyView
                        ? Colors.white
                        : Colors.transparent,
                    margin: EdgeInsets.only(bottom: bottomBarHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView ? 0: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                              const SVGImage(assetPath: "assets/icons/payment.svg"),
                              const Text("Payments", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                        _pageViewWidget(watchPaymentViewModel, readPaymentViewModel),
                        _pageViewIndicator(watchPaymentViewModel),
                      ],
                    ),
                  ),
                ),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, readPaymentViewModel.translateUpAnimation.value * (-MediaQuery.of(context).size.height*0.7)),
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pageViewWidget(PaymentViewModel watchPaymentViewModel, PaymentViewModel readPaymentViewModel) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            itemCount: 4,
            controller: pageController,
            ///If SendMoneyView page or ReceiveMoneyView page is active do not scroll horizontal (swipe)
            physics: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            onPageChanged: (int value) {
              setState(() {
                pageViewIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: readPaymentViewModel.translateSidewaysController,
                ///Tilted semicircle
                builder: (context, child) {
                  ///Side ways translation timeline animation
                  return Transform.translate(
                    offset: pageViewIndex == index
                        ? const Offset(0, 0)
                        : pageViewIndex < index
                        ? Offset(readPaymentViewModel.translateSidewaysController.value*100, 0)
                        : Offset(-readPaymentViewModel.translateSidewaysController.value*100, 0) ,
                    child: child,
                  );
                },
                child: AnimatedBuilder(
                  animation: pageController,
                  child: _paymentCard(index, readPaymentViewModel),
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
              );
            },
          ),

          ///New payment button
          Positioned(
            bottom: 20,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                _onClick(readPaymentViewModel);
              },
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView
                      ? 48
                      : 150,
                  height: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView
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
                    crossFadeState: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView
                        ? CrossFadeState.showFirst:CrossFadeState.showSecond,
                    firstChild: const SVGImage(assetPath: "assets/icons/down.svg"),
                    secondChild: Text(pageViewIndex == 2
                        ? "New Postpaid Bill"
                        : pageViewIndex == 3
                            ? "New Prepaid Bill"
                            : "New Payment", style: const TextStyle(color: primaryButtonColor, fontSize: 12, fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _paymentCard(int index, PaymentViewModel readPaymentViewModel) {
    return index == 0
        ? SendMoneyToCard(readPaymentViewModel: readPaymentViewModel)
        : index == 1
          ? RequestMoneyFromCard(readPaymentViewModel: readPaymentViewModel)
          : index == 2
              ? PostPaidCard(readPaymentViewModel: readPaymentViewModel)
              : PrePaidCard(readPaymentViewModel: readPaymentViewModel);
  }

  _pageViewIndicator(PaymentViewModel watchPaymentViewModel) {
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
      crossFadeState: watchPaymentViewModel.showSendMoneyView || watchPaymentViewModel.showReceiveMoneyView
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }


  _onClick(PaymentViewModel readPaymentViewModel) {
    if(pageViewIndex == 0) {
      readPaymentViewModel.goToSendMoneyView(!readPaymentViewModel.showSendMoneyView, context.read<DashboardViewModel>());
    } else if(pageViewIndex == 1) {
      readPaymentViewModel.goToReceiveMoneyView(!readPaymentViewModel.showReceiveMoneyView, context.read<DashboardViewModel>());
    } else if (pageViewIndex == 2) {

    } else if(pageViewIndex == 3) {

    }
  }
}
