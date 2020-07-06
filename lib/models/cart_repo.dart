//import 'dart:convert';
//
//import 'package:dio/dio.dart';
//import 'package:fishingcorner/models/cart_item_model.dart';
//import 'package:fishingcorner/models/products_model.dart';
//import 'package:fishingcorner/models/responses/sign_up_response.dart';
//import 'package:fishingcorner/rebos/auth_rebo.dart';
//import 'package:fishingcorner/utils/keys.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class CartRepo {
//  Future<List<CartItem>> getCartItems() async {
//    SharedPreferences pres = await SharedPreferences.getInstance();
//    List<String> cartInString = pres.getStringList(cartItemsKey);
//    List<CartItem> items = [];
//    if (cartInString == null) {
//      return [];
//    }
//    cartInString.forEach((item) {
//      items.add(CartItem.fromPrefs(item));
//    });
//    return items;
//  }
//
//  Future addItemToTheCart({int quantity,
//    Product product,
//    Map<String, Map<String, bool>> spc,
//    String price}) async {
//    SharedPreferences pres = await SharedPreferences.getInstance();
//    List<String> cartInString = pres.getStringList(cartItemsKey);
//    try {
//      cartInString.add(CartItem.formProduct(
//          price: price, quantity: quantity, product: product, spc: spc)
//          .toPrefs());
//    } catch (e) {
//      cartInString = [];
//      cartInString.add(CartItem.formProduct(
//          price: price, quantity: quantity, product: product, spc: spc)
//          .toPrefs());
//    }
//    await pres.setStringList(cartItemsKey, cartInString);
//  }
//
//  Future<bool> orderCart(
//      {String lat, String long, String placeDesc, String note}) async {
//    List<CartItem> cartItems = await getCartItems();
//    try {
//      Response response;
//      Dio dio = Dio();
//      Map<String, dynamic> body = {
//        'latitude': lat,
//        'longitude': long,
//        "address": placeDesc,
//        "day": "33",
//        "time": "sss",
//      };
//      if (note != null) {
//        body['note'] = note;
//      }
//      body['products'] = [];
//      double price = 0;
//      cartItems.forEach((item) {
//        print(item.itemQuantity);
//        price += double.parse(item.fixedPrice);
//
//        body['products'].add({
//          'specifications': item.specificationsMaps,
//          'quantity': item.itemQuantity,
//          'product_id': item.id
//        });
//      });
//      body["total_price"] = price.toString();
//      print(jsonEncode(body));
//      UpdateUserResponse userResponse = await AuthRepo().getCurrentUser();
//      response = await dio.post(
//        '$webSiteUrl/ar/api/orders',
//        data: body,
//        options: Options(
//            followRedirects: false,
//            validateStatus: (status) {
//              return status < 500;
//            },
//            headers: {
//              'Accept': 'application/json',
//              'Authorization': 'Bearer ${userResponse.accessToken}'
//            }),
//      );
//      if (response.statusCode == 200) {
//        await clearCart();
//        return true;
//      } else {
//        return Future.error('no_internet');
//      }
//    } catch (e) {
//      return Future.error('no_internet');
//    }
//  }
//
//  Future removeItemFromList(CartItem itemToDelete) async {
//    SharedPreferences pres = await SharedPreferences.getInstance();
//    List<String> cartInString = pres.getStringList(cartItemsKey);
//    List<CartItem> cartItems = [];
//    cartInString.forEach((item) {
//      cartItems.add(CartItem.fromPrefs(item));
//    });
//    List<String> newList = [];
//    cartItems.forEach((item) {
//      print(item.specificationsMaps == itemToDelete.specificationsMaps);
//
//      if (item.id == itemToDelete.id &&
//          item.itemQuantity == itemToDelete.itemQuantity &&
//          item.fixedPrice == itemToDelete.fixedPrice) {} else {
//        newList.add(item.toPrefs());
//      }
//    });
//    await pres.setStringList(cartItemsKey, newList);
//  }
//}
//
//// this method will delete all cart items from the SharedPreferences
//Future<bool> clearCart() async {
//  final SharedPreferences prefs = await SharedPreferences.getInstance();
//  bool status = await prefs.remove(cartItemsKey);
//  return status;
//}
