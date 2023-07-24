import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';

import '../../constant/constants.dart';
import '../../data.dart';

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
  User? sendTo;
  ///When New payment user param is null
  goToSendMoneyView(bool value, DashboardViewModel dashboardViewModel, {User? user}) {
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
    sendTo = user;
    _showSendMoneyView = value;
    notifyListeners();
  }



  bool _showReceiveMoneyView = false;
  bool get showReceiveMoneyView => _showReceiveMoneyView;
  User? receiveFrom;
  ///When New payment user param is null
  goToReceiveMoneyView(bool value, DashboardViewModel dashboardViewModel, {User? user}) {
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
    receiveFrom = user;
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