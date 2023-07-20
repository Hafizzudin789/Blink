import 'package:flutter/material.dart';

class ReceiveMoneyViewModel extends ChangeNotifier {


  String actualAmount = "0";
  editAmount(String value) {
    if(actualAmount.length>=10) {
      return;
    }
    if(value == "." && actualAmount.contains(".")) {
      return;
    }
    if(actualAmount == "0" && value == ".") {
      actualAmount = actualAmount+value;
      notifyListeners();
      return;
    }

    if(actualAmount == "0") {
      actualAmount = value;
    } else {
      actualAmount = actualAmount+value;
    }
    notifyListeners();
  }

  removeAmount() {
    if (actualAmount == "0") {
      return;
    } else if(actualAmount.length == 1) {
      actualAmount = "0";
      notifyListeners();
    } else if (actualAmount != "0") {
      actualAmount = actualAmount.substring(0, actualAmount.length - 1);
      notifyListeners();
    }
  }
}