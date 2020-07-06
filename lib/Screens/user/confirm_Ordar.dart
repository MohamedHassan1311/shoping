import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/responsive/dvise_info.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/responsive/text_size.dart';
import 'package:shoping/serves/store.dart';

import '../../constant.dart';
import 'address_detalis.dart';
import 'ordar_cmplet.dart';

class ConfirmaOrder extends StatefulWidget {
  static String id = "ConfirmaOrde";
  @override
  _ConfirmaOrderState createState() => _ConfirmaOrderState();
}

class _ConfirmaOrderState extends State<ConfirmaOrder> {
//  getDate() async {
//    SharedPreferences prefs;
//    prefs = await SharedPreferences.getInstance();
//    setState(() {
//      addres = prefs.getStringList("addres");
//    });
//
////    return addres;
//  }
  SharedPreferences prefs;
  getDate() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      addres = prefs.getStringList("addres") ??
          Container(
            color: Colors.purple,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    var providar = Provider.of<CartItem>(
      context,
    );
    getDate();
    List<Product> product = Provider.of<CartItem>(context).products;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Checkout "),
          actions: <Widget>[],
        ),
        body: InfoWidget(
          builder: (context, deviceInfo) => ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _addresCard(deviceInfo),
                  Align(
                    heightFactor: 2,
                    alignment: Alignment.center,
                    child: Text(
                      "order summery",
                      style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                    ),
                  ),
                  _total(deviceInfo, product),
                  Align(
                      heightFactor: 2,
                      alignment: Alignment.center,
                      child: Text(
                        "products",
                        style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                      )),
                  Container(
                    height: deviceInfo.screenHeight * .5,
                    child: ListView.builder(
                        itemCount: product.length,
                        itemBuilder: (context, index) {
                          return _itemCard(
                              product: product,
                              index: index,
                              deviceInfo: deviceInfo);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
//          padding: EdgeInsets.only(bottom: 75),
          child: RaisedButton(
            padding: EdgeInsets.all(16),
            onPressed: () {
              try {
                _onpress(data: {
                  kAddress: addres,
                  kTotallPrice: providar.getTotal(product),
                }, products: product);
              } catch (e) {
                print(e);
              }
              product.removeRange(0, product.length);
              Navigator.of(context).pushReplacementNamed(CompletOrdar.id);
            },
            color: Colors.purple,
            child: Text(
              "Check out ",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
  }

  _itemCard({List<Product> product, index, DeviceInfo deviceInfo}) {
    return Container(
      height: deviceInfo.screenHeight * .15,
      child: Card(
        elevation: 3,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  product[index].Pname,
                  style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                ),
                subtitle: Text(
                  product[index].Pprice,
                  style: TextStyle(
                      fontSize: SubTitel(deviceInfo), color: Colors.redAccent),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topRight,
              child: Image(
                fit: BoxFit.contain,
                image: NetworkImage(product[index].Ploction),
              ),
            ))
          ],
        ),
      ),
    );
  }

  _paymethodCard({String titel, icon}) {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Checkbox(
                value: true,
                onChanged: null,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(titel),
              ),
            ),
            Expanded(
              child: Align(alignment: Alignment.centerRight, child: Icon(icon)),
            )
          ],
        ),
      ),
    );
  }

  _total(DeviceInfo deviceInfo, product) {
//    print(deviceInfo.screenHeight);
    var providar = Provider.of<CartItem>(context, listen: false);
    return Container(
      height: deviceInfo.screenHeight * .13,
      width: deviceInfo.screenWidth,
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Subtotal ",
                    style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${providar.getTotal(product)} ",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Total ",
                    style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${providar.getTotal(product)} ",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Total ",
                    style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${providar.getTotal(product)} ",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: HeadTitel(deviceInfo)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addresCard(deviceInfo) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        " Address Detiles",
                        style: TextStyle(fontSize: SubTitel(deviceInfo)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AdderessDetiels.id);
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(fontSize: SubTitel(deviceInfo)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            addres != null
                ? Container(
                    width: deviceInfo.screenWidth,
                    height: deviceInfo.screenHeight * .2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  addres[0],
                                  style: TextStyle(
                                      fontSize: HeadTitel(deviceInfo)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  addres[1],
                                  style:
                                      TextStyle(fontSize: SubTitel(deviceInfo)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  addres[2],
                                  style:
                                      TextStyle(fontSize: SubTitel(deviceInfo)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  addres[3],
                                  style:
                                      TextStyle(fontSize: SubTitel(deviceInfo)),
                                ),
                              ),
                            ],
                          )),
                    ))
                : RaisedButton(
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.pushNamed(context, AdderessDetiels.id);
                    },
                    child: Text(
                      "Add addres",
                      style: TextStyle(fontSize: HeadTitel(deviceInfo)),
                    ),
                  ),
            Container(
              child: Card(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ),
          ],
        ),
        Align(
            heightFactor: 2,
            alignment: Alignment.center,
            child: Text("Choose your payment method")),
        _paymethodCard(titel: "Pay with Cash", icon: Icons.cached),
        _paymethodCard(titel: "Pay With Card", icon: Icons.credit_card),
      ],
    );
  }

  _onpress({products, data}) {
    var _store = Store();
    return _store.storeOrders(data, products);
  }
}
