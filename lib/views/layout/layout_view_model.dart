import 'package:flutter/cupertino.dart';


class LayoutViewModel extends ChangeNotifier {


  bool _showMainMenu = false;
  bool get showMainMenu => _showMainMenu;
  openMainMenu() {
    _showMainMenu = !_showMainMenu;
    notifyListeners();
  }


  ///Debit card logic
  bool showButtonsInDebitCard = true;
  showButtons() {
    showButtonsInDebitCard = !showButtonsInDebitCard;
    notifyListeners();
  }

  ///Credit card logic
  bool showButtonsInCreditCard = true;
  showButtonsCreditCard() {
    showButtonsInCreditCard = !showButtonsInCreditCard;
    notifyListeners();
  }
}