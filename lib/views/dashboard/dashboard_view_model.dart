import 'package:flutter/cupertino.dart';

class DashboardViewModel extends ChangeNotifier {

  late AnimationController translateAnimationController;
  late AnimationController scaleAnimationController;

  // late Animation<double> animation;


  animateForward() {
    translateAnimationController.forward();
    scaleAnimationController.forward();
  }

  animateReverse() {
    translateAnimationController.reverse();
    scaleAnimationController.reverse();
  }

  disposeControllers() {
    translateAnimationController.dispose();
    scaleAnimationController.dispose();
  }

}