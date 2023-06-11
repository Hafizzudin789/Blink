import 'package:blink/views/dashboard/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
import 'dart:math' as math;

import 'widgets/debit_card.dart';
import 'widgets/my_account_card.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin{

  int pageViewIndex = 0;
  List cards = [1,2,3]; ///Number of cards to horizontally scroll

  late PageController pageController;


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageViewIndex, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _totalBalance(),
            _pageViewWidget(),
            _pageViewIndicator(),
          ],
        ),
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
    return Padding(
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
    );
  }

}
