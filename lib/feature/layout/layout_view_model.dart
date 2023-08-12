import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_view_model.dart';
import '../payment/payment/payment_view_model.dart';


enum BottomBarIndex {
  home,
  payment,
}

class LayoutViewModel extends ChangeNotifier {


  BottomBarIndex bottomBarIndex = BottomBarIndex.home;
  changeBottomBarIndex(BottomBarIndex value, BuildContext context) {
    if(value == bottomBarIndex) return;

    bottomBarIndex = value;

    ///Disposing dashboard screen resources
    if(value != BottomBarIndex.home) {
      context.read<DashboardViewModel>().disposeControllers();
    }

    ///Disposing payment screen resources
    if(value != BottomBarIndex.payment) {
      context.read<PaymentViewModel>().disposeResources();
    }
    notifyListeners();
  }


  bool _showMainMenu = false;
  bool get showMainMenu => _showMainMenu;
  openMainMenu() {
    _showMainMenu = !_showMainMenu;
    notifyListeners();
  }

  bool firstTime = true;
  onClickMainMenu(int index, BuildContext context) {
    switch(index) {
      case 0:
        firstTime = false;
        context.read<LayoutViewModel>().zoomController.reverse();
        openMainMenu();
        changeBottomBarIndex(BottomBarIndex.payment, context);
        break;
      case 1:
        // changeBottomBarIndex(BottomBarIndex.payment);
        break;
      case 2:
        // changeBottomBarIndex(BottomBarIndex.payment);
        break;
      case 3:
        // changeBottomBarIndex(BottomBarIndex.payment);
        break;
      case 4:
        // changeBottomBarIndex(BottomBarIndex.payment);
        break;
      case 5:
        // changeBottomBarIndex(BottomBarIndex.payment);
        break;
    }
  }




  ///Debit card logic
  bool showButtonsInDebitCard = true;
  showButtonsDebitCard() {
    showButtonsInDebitCard = !showButtonsInDebitCard;
    notifyListeners();
  }

  ///Credit card logic
  bool showButtonsInCreditCard = true;
  showButtonsCreditCard() {
    showButtonsInCreditCard = !showButtonsInCreditCard;
    notifyListeners();
  }


  late AnimationController zoomController;
  late Animation<double> zoomAnimation;
}