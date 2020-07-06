import 'package:flutter/cupertino.dart';

class SavedAdd extends ChangeNotifier {
  List<String> SaveEDADD = [];
  addAdd(add) {
    SaveEDADD.add(add);
    notifyListeners();
  }
}
