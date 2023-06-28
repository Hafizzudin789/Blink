import 'package:flutter/cupertino.dart';

import '../navigation_transitions.dart';
import '../transaction_view.dart';

class DashboardViewModel extends ChangeNotifier {

  late AnimationController translateUpController;
  late Animation<double> animation;

  late AnimationController translateSidewaysController;

  late AnimationController scaleAnimationController;

  late AnimationController translateTimelineController;



  animateForwardTransactionPage() {
    transactionPage = true;
    notifyListeners();
    translateUpController.forward();
    scaleAnimationController.forward();
  }

  animateReverseTransactionPage() {
    transactionPage = false;
    notifyListeners();
    translateUpController.reverse();
    scaleAnimationController.reverse();
  }

  bool transactionPage = false;
  goToTransactionPage(BuildContext context) {
    animateForwardTransactionPage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const TransactionView()));
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



  bool timelinePage = false;
  showTimeline(bool value) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        bottomNavbarHeight = 0;
        notifyListeners();
      },);
      translateTimelineController.forward();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        bottomNavbarHeight = 135;
        notifyListeners();
      },);

      translateTimelineController.reverse();
    }
    timelinePage = value;
    notifyListeners();
  }

  disposeControllers() {
    translateUpController.dispose();
    scaleAnimationController.dispose();

    translateSidewaysController.dispose();
    translateTimelineController.dispose();
  }

}