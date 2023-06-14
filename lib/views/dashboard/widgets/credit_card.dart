import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../../../widgets/customPattern.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg_image.dart';
import '../../../widgets/elevated_button.dart';
import 'dart:math' as math;
import '../../navigation_transitions.dart';
import '../../transaction_view.dart';
import '../dashboard_view_model.dart';


class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _showButtonsInCreditCard = true;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut, reverseCurve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
            decoration: BoxDecoration(
              color: pinkColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: AnimatedCrossFade(
              crossFadeState: _showButtonsInCreditCard
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(seconds: 1),
              firstCurve: Curves.linearToEaseOut,
              secondCurve: Curves.linearToEaseOut,
              layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      key: bottomChildKey,
                      left: 0.0,
                      top: 0.0,
                      right: 0.0,
                      bottom: 0,
                      child: bottomChild,
                    ),
                    Positioned(
                      key: topChildKey,
                      left: 0.0,
                      top: 0.0,
                      right: 0.0,
                      bottom: 0,
                      child: topChild,
                    ),
                  ],
                );
              },
              firstChild: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(
                  painter: const CustomPatternCircleCreditCard(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            InkWell(
                              onTap: () {
                                _rotate();
                              },
                              child: Container(
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
                            ),
                          ],
                        ),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              secondChild: Transform.flip(
                flipX: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text("Zein Malhas", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                          ),
                          InkWell(
                            onTap: () {
                              _rotate();
                            },
                            child: Container(
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
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(child: Text("8451 1353 1245 3421", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(width: 8),
                              SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                            ],
                          ),
                          Text("CARD NUMBER", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("08/23", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                                SizedBox(height: 4),
                                Text("EXPIRY DATE", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("688", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                                SizedBox(height: 4),
                                Text("CVV", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Divider(color: lightestPinkColor, thickness: 0.5, height: 64,),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text.rich(
                            TextSpan(
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                      text: "232.48"
                                  ),
                                  TextSpan(
                                    text: " JOD",
                                    style: TextStyle(color: gray300Color, fontSize: 10, fontWeight: FontWeight.w700),

                                  ),
                                ]
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("TOTAL USED AMOUNT", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text.rich(
                            TextSpan(
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                      text: "1,000.00"
                                  ),
                                  TextSpan(
                                    text: " JOD",
                                    style: TextStyle(color: gray300Color, fontSize: 10, fontWeight: FontWeight.w700),

                                  ),
                                ]
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("YOUR CARD LIMIT", style: TextStyle(color: lightestPinkColor, fontSize: 10, fontWeight: FontWeight.w600),),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                // ..rotateY(_animationController.value * -math.pi),
                ..rotateY(_animation.value * -math.pi),
              alignment: Alignment.center,
              child: child,
            );
          },
        ),

        ///Button
        Positioned(
          top: 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _showButtonsInCreditCard
                ? 1
                : 0,
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
        ),

        ///Transactions button
        Positioned(
          bottom: 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _showButtonsInCreditCard
                ? 1
                : 0,
            child: ElevatedCustomButton(
              onTap: () {
                if(_showButtonsInCreditCard) {
                  context.read<DashboardViewModel>().animateForward();
                  Navigator.of(context).push(slideBottomToTop(nextPage: const TransactionView()));
                }
              },
              label: "Transactions",
              buttonColor: Colors.white,
              foregroundColor: primaryButtonColor,
            ),
          ),
        ),
      ],
    );
  }

  _rotate() {
    if(!_animationController.isAnimating) {
      _animationController.isDismissed
          ? _animationController.forward()
          : _animationController.reverse();
      // if(_animationController.isCompleted) {
      //   // _animationController.stop();
      //   _animationController.value = 0;
      //   _animationController.forward();
      // }


      setState(() {
        _showButtonsInCreditCard = !_showButtonsInCreditCard;
      });
    }
  }


}

