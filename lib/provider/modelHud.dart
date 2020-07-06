import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
  bool isLoding = false;
  ChangeIsLoding(bool value) {
    isLoding = value;
    notifyListeners();
  }
}
