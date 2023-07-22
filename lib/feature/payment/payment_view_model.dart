import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';

import '../../constant/constants.dart';

class PaymentViewModel extends ChangeNotifier {

  late AnimationController translateUpController;
  late Animation<double> translateUpAnimation;

  late AnimationController translateSidewaysController;

  late AnimationController scaleController;


  disposeResources() {
    translateUpController.dispose();
    translateSidewaysController.dispose();
    scaleController.dispose();
  }



  bool _showSendMoneyView = false;
  bool get showSendMoneyView => _showSendMoneyView;
  goToSendMoneyView(bool value, DashboardViewModel dashboardViewModel) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        dashboardViewModel.changeBottomNavbarHeight(0);
        notifyListeners();
      },);
      animateForward();
    } else {
      dashboardViewModel.changeBottomNavbarHeight(bottomBarHeight);
      animateReverse();
    }
    _showSendMoneyView = value;
    notifyListeners();
  }



  bool _showReceiveMoneyView = false;
  bool get showReceiveMoneyView => _showReceiveMoneyView;
  goToReceiveMoneyView(bool value, DashboardViewModel dashboardViewModel) {
    if(value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        dashboardViewModel.changeBottomNavbarHeight(0);
        notifyListeners();
      },);
      animateForward();
    } else {
      dashboardViewModel.changeBottomNavbarHeight(bottomBarHeight);
      animateReverse();
    }
    _showReceiveMoneyView = value;
    notifyListeners();
  }




  animateForward() {
    translateSidewaysController.forward();
    translateUpController.forward();
  }

  animateReverse() {
    translateSidewaysController.reverse();
    translateUpController.reverse();
  }


}