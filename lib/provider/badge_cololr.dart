import 'package:flutter/cupertino.dart';

class BadgeCololr extends ChangeNotifier {
  bool Badgecolor = true;
  changeBadgecolor(bool value) {
    Badgecolor = value;
    notifyListeners();
  }
}
