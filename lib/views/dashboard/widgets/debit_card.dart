import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import '../../../widgets/customPattern.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg_image.dart';
import '../../../widgets/elevated_button.dart';
import 'dart:math' as math;

class DebitCard extends StatefulWidget {
  const DebitCard({super.key});

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  bool _showButtonsInDebitCard = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
              color: yellowColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: AnimatedCrossFade(
              crossFadeState: _showButtonsInDebitCard
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
                                  color: yellowColor,
                                  border: Border.all(color: lightYellowColor),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0.1),
                                  ],
                                ),
                                child: const SVGImage(assetPath: "assets/icons/spin.svg",),
                              ),
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
                            child: Text("Zein Malhas", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
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
                                color: yellowColor,
                                border: Border.all(color: lightYellowColor),
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
                              Flexible(child: Text("8451 1353 1245 3421", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(width: 8),
                              SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                            ],
                          ),
                          Text("CARD NUMBER", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
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
                                Text("08/23", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),),
                                SizedBox(height: 4),
                                Text("EXPIRY DATE", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("688", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),),
                                SizedBox(height: 4),
                                Text("CVV", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Divider(color: gray300Color, thickness: 0.5, height: 64,),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("1405 9131 4151 4142", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),),
                          SizedBox(height: 4),
                          Text("LINKED ACCOUNT NUMBER", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
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
                ..rotateY(_animationController.value * -math.pi),
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
            opacity: _showButtonsInDebitCard
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
            duration: const Duration(milliseconds: 800),
            opacity: _showButtonsInDebitCard
                ? 1
                : 0,
            child: const ElevatedCustomButton(
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

      setState(() {
        _showButtonsInDebitCard = !_showButtonsInDebitCard;
      });
    }
  }
}

