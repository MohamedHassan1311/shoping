import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/Screens/user/poduct_detils.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/responsive/dvise_info.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/serves/store.dart';
import 'package:shoping/widgets/custom_cart.dart';

import 'confirm_Ordar.dart';

class Cart extends StatefulWidget {
  static String id = "cart";

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var store = Store();

  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<CartItem>(context).products;
    int q = 1;
    var providar = Provider.of<CartItem>(
      context,
    );

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 1,
            ),
            backgroundColor: Colors.white,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Badge(
                  badgeColor: Colors.purple,
//              position: BadgePosition.topRight(top: 10, right: 0),
                  badgeContent: Text(
                    "${product.length}",
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            centerTitle: true,
          ),
          body: product.length != 0
              ? SafeArea(
                  child: InfoWidget(
                      builder: (context, deviceInfo) => Container(
                            height: deviceInfo.screenHeight,
                            child: ListView.builder(
                                itemCount: product.length,
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ProductDetiels.id,
                                              arguments: product[index]);
                                    },
                                    child: CustomCArd(
                                      context: context,
                                      deviseinfo: deviceInfo,
                                      product: product,
                                      index: index,
                                      onpress: () {
                                        setState(() {
                                          product.removeAt(index);
                                        });
                                      },
                                    )
//                                  context, product, index, () {

//                                  }, deviceInfo),

                                    )),
                          )),
                )
              : InfoWidget(
                  builder: (context, deviceInfo) => Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_basket,
                            size: 200,
                          ),
                          Text(
                            "No Item added !! ",
                            style:
                                TextStyle(fontSize: 30, fontFamily: "Caveat"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 50),
            child: RaisedButton(
              padding: EdgeInsets.all(16),
              onPressed: () {
                Navigator.pushNamed(context, ConfirmaOrder.id);
              },
              color: Colors.purple,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(
                      "Check out ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Total ${providar.getTotal(product)}",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

//  Padding carditem(BuildContext context, List<Product> product, int index,
//      onpress, DeviceInfo deviseinfo) {
//    return Padding(
//      padding: EdgeInsets.all(10.0),
//      child: Material(
//          shadowColor: Colors.blueGrey,
//          borderRadius: BorderRadius.circular(10.0),
//          elevation: 3.0,
//          child: Column(
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.only(right: 10.0),
//                width: MediaQuery.of(context).size.width - 20.0,
//                height: deviseinfo.screenHeight * .200,
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(10.0)),
//                child: Row(children: <Widget>[
//                  Container(
//                    height: deviseinfo.screenHeight,
//                    width: deviseinfo.screenWidth * .200,
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: NetworkImage(product[index].Ploction),
//                            fit: BoxFit.contain)),
//                  ),
//                  SizedBox(width: deviseinfo.screenHeight * .020),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Text(
//                            "Price",
//                            style: TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontWeight: FontWeight.bold,
//                              fontSize: HeadTitel(deviseinfo),
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: deviseinfo.screenHeight * .01),
//                      Text(
//                        "${product[index].Pprice}" + "\EGP",
//                        style: TextStyle(
//                            fontFamily: 'Montserrat',
//                            fontWeight: FontWeight.bold,
//                            fontSize: SubTitel(deviseinfo),
//                            color: Colors.red),
//                      ),
//                    ],
//                  ),
//                  Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(height: deviseinfo.screenHeight * .030),
//                        Text(
//                          'qantati:',
//                          style: TextStyle(
//                              fontFamily: 'Quicksand',
//                              fontWeight: FontWeight.bold,
//                              fontSize: HeadTitel(deviseinfo),
//                              color: Colors.grey),
//                        ),
//                        Text(
//                          '${product[index].qantati} ',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              fontSize: SubTitel(deviseinfo),
//                              color: Colors.black),
//                        ),
//                        SizedBox(
//                          height: deviseinfo.screenHeight * .010,
//                        ),
//                      ],
//                    ),
//                  ),
//                ]),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 20),
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Expanded(
//                      child: Center(
//                        child: Text(
//                          product[index].Pname,
//                          style: TextStyle(
//                              fontSize: HeadTitel(deviseinfo),
//                              fontWeight: FontWeight.w900),
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      flex: 3,
//                      child: FlatButton.icon(
////                padding: EdgeInsets.all(20.0),
////                            color: Colors.purple,
//                        icon: Icon(
//                          Icons.delete,
//                          size: SubTitel(deviseinfo),
//                        ),
//                        label: Text(
//                          "Remove",
//                          style: TextStyle(
//                            fontSize: SubTitel(deviseinfo),
//                          ),
//                        ),
//                        onPressed: onpress,
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(10)),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Divider(
//                color: Colors.purple,
//                height: 2,
//                endIndent: 25,
//                thickness: 3,
//                indent: 25,
//              )
//            ],
//          )),
//    );
//  }

  double height(DeviceInfo deviceInfo) {
    var hight = deviceInfo.screenHeight;
    if (hight <= 570 && hight <= 660) {
      hight = deviceInfo.screenHeight * .23;
    } else
      hight = deviceInfo.screenHeight * .18;
    if (deviceInfo.orientation == Orientation.landscape)
      hight = deviceInfo.screenWidth * 2;
//    if (hight == 667) {
//      hight = deviceInfo.screenHeight * .21;
//    }
    return hight;
  }

//  getTotal(List<Product> prudcts) {
//    var price = 0;
//    for (var prodct in prudcts) {
//      price += int.parse(prodct.qantati) * int.parse(prodct.Pprice);
//    }
//    return price;
//  }
}
