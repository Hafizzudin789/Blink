import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';

import '../../../constant/constants.dart';
import '../../../data.dart';
import '../../../utils/navigation_transitions.dart';
import '../postpaid_bill/my_due_bills.dart';
import '../postpaid_bill/my_postpaid_bills.dart';
import '../postpaid_bill/post_paid_bills_history.dart';
import '../prepaid_bill/my_prepaid_bills.dart';
import '../prepaid_bill/pre_paid_bills_history.dart';

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







  //////////////////////////////
  animateForwardUpAndScalePage() {
    // transactionPage = true;
    // notifyListeners();
    translateUpController.forward();
    scaleController.forward();
  }

  animateReverseUpAndScalePage() {
    // transactionPage = false;
    // notifyListeners();
    translateUpController.reverse();
    scaleController.reverse();
  }

  goToPostPaidHistoryPage(BuildContext context) {
    animateForwardUpAndScalePage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const PostPaidBillsHistory()));
  }
  goToPrePaidHistoryPage(BuildContext context) {
    animateForwardUpAndScalePage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const PrePaidBillsHistory()));
  }
  goToPostPaidBillsPage(BuildContext context) {
    animateForwardUpAndScalePage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const MyPostPaidBills()));
  }
  goToPostPaidDueBillsPage(BuildContext context) {
    animateForwardUpAndScalePage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const MyDueBills()));
  }
  goToPrePaidBillsPage(BuildContext context) {
    animateForwardUpAndScalePage();
    Navigator.of(context).push(slideBottomToTop(nextPage: const MyPrePaidBills()));
  }
  ////////////////////////////





  bool _showNewPostPaidBillsView = false;
  bool get showNewPostPaidBillsView => _showNewPostPaidBillsView;
  goToNewPostPaidBillView(bool value, DashboardViewModel dashboardViewModel) {
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
    _showNewPostPaidBillsView = value;
    notifyListeners();
  }


  bool _showNewPrePaidBillsView = false;
  bool get showNewPrePaidBillsView => _showNewPrePaidBillsView;
  goToNewPrePaidBillView(bool value, DashboardViewModel dashboardViewModel) {
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
    _showNewPrePaidBillsView = value;
    notifyListeners();
  }


  bool get showDownArrowButton {
    return showSendMoneyView || showReceiveMoneyView ||showNewPostPaidBillsView ||showNewPrePaidBillsView;
  }

}