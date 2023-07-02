import 'package:flutter/cupertino.dart';


class LayoutViewModel extends ChangeNotifier {


  bool _showMainMenu = false;
  bool get showMainMenu => _showMainMenu;
  openMainMenu() {
    _showMainMenu = !_showMainMenu;
    notifyListeners();
  }
}