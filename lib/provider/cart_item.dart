import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/models/product.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];
  SharedPreferences prefs;

  int counter = 0;
  int price = 0;
  var x;
  Qadd() {
    if (counter > 0) counter++;

    notifyListeners();
  }

  Qremove() {
    if (counter > 1) counter--;

    notifyListeners();
  }

  addProduct(Product product) async {
    products.add(product);
//    print(product.ProID);

////      List <String>
//    prefs = await SharedPreferences.getInstance();
//    String tast = Product.convertToJson(products);
////    print(
////        "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111${x}");
//    List<String> aa = [x];
//    print("${aa}");
//
//    prefs.setString("pro", tast);

    notifyListeners();
  }

//  getSavedItem() async {
//    var y;
//    prefs = await SharedPreferences.getInstance();
//    tast = prefs.getString("pro");
//    Product.fromJSon(tast);
//
//    notifyListeners();
////    for (String data in getShared) {
////      y = Product.fromJSon(data);
////    }
//  }
  getTotal(products) {
    var price = 0;
    for (var prodct in products) {
      price += int.parse(prodct.qantati) * int.parse(prodct.Pprice);
    }
    return price;
  }
}
