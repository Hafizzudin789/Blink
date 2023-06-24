import 'package:flutter/cupertino.dart';

class DashboardViewModel extends ChangeNotifier {

  late AnimationController translateUpController;
  late Animation<double> animation;

  late AnimationController translateSidewaysController;

  late AnimationController scaleAnimationController;



  animateForwardTransactionPage() {
    translateUpController.forward();
    scaleAnimationController.forward();
  }

  animateReverseTransactionPage() {
    translateUpController.reverse();
    scaleAnimationController.reverse();
  }






  animateForwardSettingsPage() {
    translateSidewaysController.forward();
    translateUpController.forward();
  }

  animateReverseSettingsPage() {
    translateSidewaysController.reverse();
    translateUpController.reverse();
  }



  double bottomNavbarHeight = 135;
  bool settings = false;
  showSettingPage(bool value) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        bottomNavbarHeight = 0;
        notifyListeners();
      },);
      animateForwardSettingsPage();
    } else {
      bottomNavbarHeight = 135;
      animateReverseSettingsPage();
    }

    settings = value;
    notifyListeners();
  }

  disposeControllers() {
    translateUpController.dispose();
    scaleAnimationController.dispose();

    translateSidewaysController.dispose();
  }

}