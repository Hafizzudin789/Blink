import 'package:flutter/cupertino.dart';
import '../../constant/constants.dart';
import '../navigation_transitions.dart';
import '../transaction_view.dart';

class DashboardViewModel extends ChangeNotifier {

  late AnimationController translateSettingsUpController;
  late Animation<double> animation;

  late AnimationController translateSidewaysController;

  late AnimationController scaleAnimationController;

  late AnimationController translateTimelineDownController;



  animateForwardTransactionPage() {
    transactionPage = true;
    notifyListeners();
    translateSettingsUpController.forward();
    scaleAnimationController.forward();
  }

  animateReverseTransactionPage() {
    transactionPage = false;
    notifyListeners();
    translateSettingsUpController.reverse();
    scaleAnimationController.reverse();
  }

  bool transactionPage = false;
  goToTransactionPage(BuildContext context) {
    animateForwardTransactionPage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const TransactionView()));
  }






  animateForwardSettingsPage() {
    translateSidewaysController.forward();
    translateSettingsUpController.forward();
  }

  animateReverseSettingsPage() {
    translateSidewaysController.reverse();
    translateSettingsUpController.reverse();
  }


  double bottomNavbarHeight = bottomBarHeight;

  bool settings = false;
  showSettingPage(bool value) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        bottomNavbarHeight = 0;
        notifyListeners();
      },);
      animateForwardSettingsPage();
    } else {
      bottomNavbarHeight = bottomBarHeight;
      animateReverseSettingsPage();
    }

    settings = value;
    notifyListeners();
  }




  animateForwardTimelinePage() {
    translateTimelineDownController.forward();
    translateSidewaysController.forward();
  }

  animateReverseTimelinePage() {
    translateTimelineDownController.reverse();
    translateSidewaysController.reverse();
  }


  bool timelinePage = false;
  ScrollController? controller;
  showTimeline(bool value) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        bottomNavbarHeight = 0;
        timelineGlitchAnimation();

        notifyListeners();
      },);
      animateForwardTimelinePage();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        bottomNavbarHeight = bottomBarHeight;
        notifyListeners();
      },);

      animateReverseTimelinePage();
    }
    timelinePage = value;
    notifyListeners();
  }

  timelineGlitchAnimation() {
    controller!.animateTo(30, duration: const Duration(milliseconds: 400), curve: Curves.easeIn).then((value) {
      controller!.animateTo(-30, duration: const Duration(milliseconds: 500), curve: Curves.easeInBack);
    });
  }


  disposeControllers() {
    translateSettingsUpController.dispose();
    scaleAnimationController.dispose();

    translateSidewaysController.dispose();
    translateTimelineDownController.dispose();

    controller?.dispose();
  }

}