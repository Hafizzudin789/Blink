import 'package:blink/views/transaction_view.dart';
import 'package:blink/widgets/customPattern.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../widgets/custom_svg_image.dart';
import '../widgets/custom_button.dart';
import '../widgets/elevated_button.dart';
import 'dart:math' as math;

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

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
                        ? _myAccountCard()
                        : index == 1
                          ? _myCreditCard()
                          : _myDebitCard(),
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


  _myAccountCard() {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              //Top right pink circle custom shape
              painter: const CustomPatternCircleMyAccount(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("My Account", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),

                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Zein Malhas", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),

                          SizedBox(height: screenHeight*0.05),

                          const Text.rich(
                            TextSpan(
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                      text: "7,896.00"
                                  ),
                                  TextSpan(
                                    text: " JOD",
                                    style: TextStyle(color: gray300Color, fontSize: 14, fontWeight: FontWeight.w700),

                                  ),
                                ]
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text("AVAILABLE BALANCE", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),

                          SizedBox(height: screenHeight*0.03),

                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("851.91", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                              SizedBox(width: 8),
                              SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                            ],
                          ),
                          const Text("ACCOUNT NUMBER", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),

                          SizedBox(height: screenHeight*0.03),

                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: Text("JOD120315314513451341234567312", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(width: 8),
                              SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                            ],
                          ),
                          const Text("IBAN", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomButton(
                          label: "Add money",
                          buttonColor: primaryButtonColor,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: blackColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: borderColor, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: const BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(100),
                                ),),
                              elevation: MaterialStateProperty.all(10),
                              foregroundColor: MaterialStateProperty.all(primaryButtonColor),
                            ),
                            icon: const Icon(Icons.share_outlined, size: 32,),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: horizontalSpacing+60,
        //   top: 36,
        //   child: const SVGImage(assetPath: 'assets/card1Curve.svg'),
        // ),

        ///Button
        Positioned(
          top: 20,
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: gray200Color, width: 1)
            ),
            child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
          ),
        ),

        ///Transactions button
        const Positioned(
          bottom: 20,
          child: ElevatedCustomButton(
            label: "Transactions",
            buttonColor: Colors.white,
            foregroundColor: primaryButtonColor,
          ),
        ),
      ],
    );
  }

  _myCreditCard() {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
          decoration: BoxDecoration(
            color: pinkColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: const CustomPatternCircleCreditCard(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("My Credit Card", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                              SizedBox(height: 10),
                              Align(alignment: Alignment.centerLeft, child: SVGImage(assetPath: "assets/appName.svg")),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pinkColor,
                            border: Border.all(color: lightPinkColor),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: const SVGImage(assetPath: "assets/icons/spin.svg",),
                        ),
                      ],
                    ),

                    const Expanded(child: SizedBox()),


                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: "148.09"
                                    ),
                                    TextSpan(
                                      text: " JOD",
                                      style: TextStyle(color: gray300Color, fontSize: 14, fontWeight: FontWeight.w700),

                                    ),
                                  ]
                              ),
                            ),
                            SizedBox(height: 4),
                            Text.rich(
                               TextSpan(
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: lightestPinkColor),
                                  children: [
                                    TextSpan(
                                        text: "MIN. DUE BY"
                                    ),
                                    TextSpan(
                                      text: " 27 NOV 2021",
                                      style: TextStyle(color: Colors.white),

                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),

                        CustomButton(
                          label: "Pay back",
                          buttonColor: primaryButtonColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: "851.91"
                                    ),
                                    TextSpan(
                                      text: " JOD",
                                      style: TextStyle(color: gray300Color, fontSize: 14, fontWeight: FontWeight.w700),

                                    ),
                                  ]
                              ),
                            ),
                            SizedBox(height: 4),
                            Text("AVAILABLE AMOUNT", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                          ],
                        ),

                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pinkColor,
                            border: Border.all(color: lightPinkColor),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: const SVGImage(assetPath: "assets/icons/settings.svg"),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),

        ///Button
        Positioned(
          top: 20,
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: gray200Color, width: 1)
            ),
            child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
          ),
        ),

        ///Transactions button
        Positioned(
          bottom: 20,
          child: ElevatedCustomButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionView()));
            },
            label: "Transactions",
            buttonColor: Colors.white,
            foregroundColor: primaryButtonColor,
          ),
        ),
      ],
    );
  }

  _myDebitCard() {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
          decoration: BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: const CustomPatternCircleDebitCard(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("My Debit Card", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                              SizedBox(height: 10),
                              Align(alignment: Alignment.centerLeft, child: SVGImage(assetPath: "assets/appName.svg", color: Colors.black)),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: yellowColor,
                            border: Border.all(color: lightYellowColor),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: const SVGImage(assetPath: "assets/icons/spin.svg",),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Zein Malhas", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),

                    const Expanded(
                      child: SizedBox(),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomButton(
                          label: "Add money",
                          buttonColor: primaryButtonColor,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: yellowColor,
                            border: Border.all(color: lightYellowColor),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                            ],
                          ),
                          child: const SVGImage(assetPath: "assets/icons/settings.svg",),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


        ///Button
        Positioned(
          top: 20,
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: gray200Color, width: 1)
            ),
            child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
          ),
        ),

        ///Transactions button
        const Positioned(
          bottom: 20,
          child: ElevatedCustomButton(
            label: "Transactions",
            buttonColor: Colors.white,
            foregroundColor: primaryButtonColor,
          ),
        ),
      ],
    );
  }
}
