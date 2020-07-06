import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/badge_cololr.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/responsive/text_size.dart';

import 'homeScreen.dart';

class ProductDetiels extends StatefulWidget {
  static String id = "ProductDetils";

  @override
  _ProductDetielsState createState() => _ProductDetielsState();
}

class _ProductDetielsState extends State<ProductDetiels> {
  var size = ["L", "xL", "m", "size"];
  var qantati = ["1", "2", "3", "4", "0"];
  var selectedQantti = "1";
  var selectedSize = "size";
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    CartItem cartitems = Provider.of<CartItem>(context, listen: false);

    int x = cartitems.products.length;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: InkWell(
            onTap: () {
              Navigator.of(context).pop(HomeScreen.id);
            },
            child: Text(
              product.Pname,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
            )),
        actions: <Widget>[
//
        ],
      ),
      body: InfoWidget(
        builder: (context, deviceInfo) => ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                //=============================== Photo card =======================================
                Container(
                  height: deviceInfo.screenHeight * .5,
                  width: deviceInfo.screenWidth,
                  child: Carousel(
                      animationDuration: Duration(microseconds: 0),
                      dotBgColor: Colors.transparent,
                      dotSize: 5,
                      indicatorBgPadding: 7,
                      dotHorizontalPadding: 100,
                      borderRadius: true,
                      autoplay: false,
                      boxFit: BoxFit.cover,
                      images: [
//                        Image.asset(product.Ploction),

                        Image.network(product.Ploction),
                      ]),
                ),
                //=============================== product Detiles Name , Price =======================================
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 8,
                        bottom: 0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${product.Pname}",
                            style: TextStyle(
                                fontSize: HeadTitel(deviceInfo),
                                fontWeight: FontWeight.w900,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            " Price",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: SubTitel(deviceInfo)),
                          ),
                          Text(
                            " ${product.Pprice} \EGP",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: SubTitel(deviceInfo)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //=============================== product dropdawn =======================================
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: DropdownButton(
                          items: size.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(
                                size,
                                style: TextStyle(color: Colors.black87),
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            setState(() {
                              selectedSize = v;
                            });
                          },
                          value: selectedSize,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: DropdownButton(
                          items: qantati.map((qantati) {
                            return DropdownMenuItem(
                              value: qantati,
                              child: Text(
                                qantati,
                                style: TextStyle(color: Colors.black87),
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            setState(() {
                              selectedQantti = v;
                            });
                          },
                          value: selectedQantti,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: MaterialButton(
                      onPressed: () async {
                        Provider.of<BadgeCololr>(context, listen: false)
                            .changeBadgecolor(false);
                        var providar =
                            Provider.of<CartItem>(context, listen: false);
                        product.qantati = (selectedQantti);
                        providar.counter = int.parse(selectedQantti);
                        product.size = selectedSize;

                        CartItem cartItem =
                            Provider.of<CartItem>(context, listen: false);
                        var poductincart = cartItem.products;
                        bool x = false;
                        for (var curent in poductincart) {
                          if (curent.Pname == product.Pname) {
                            x = true;
                          }
                        }
                        if (x) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => HomeScreen.page(2)),
                              (rout) => false);
                        } else
                          await cartItem.addProduct(product);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (c) => HomeScreen.page(2)),
                            (rout) => false);
//                          Navigator.pop(context, HomeScreen.page(2));
//                          Navigator.pushReplacementNamed(
//                              context, HomeScreen.id);
                      },
                      color: Colors.purple,
                      textColor: Colors.white,
                      elevation: .2,
                      child: Text("Buy Now"),
                    ),
                  ),
                  Expanded(
                      child: Builder(
                    builder: (context) => IconButton(
                      color: Colors.purple,
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        setState(() {
                          cartitems.products.length;
                        });
                        product.qantati = selectedQantti;
                        product.size = selectedSize;
                        CartItem cartItem =
                            Provider.of<CartItem>(context, listen: false);
                        var productinCart = cartItem.products;
                        var y = false;
                        for (var curent in productinCart) {
                          if (curent.Pname == product.Pname) {
                            y = true;
                          }
                        }
                        if (y == true) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            duration: Duration(milliseconds: 500),
                            content: Text(
                              "Item in cart ",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                        if (y == false) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            duration: Duration(seconds: 2),
                            content: Text(
                              "Item Added",
                              textAlign: TextAlign.center,
                            ),
                          ));
                          cartItem.addProduct(product);
                        }
                      },
                    ),
                  )),
                ]),
                //=======================================product info==============================
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Description :",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              product.Pdescriptin,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Product Prand :",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              product.ProPrand,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Product Condation :",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              product.ProPcon,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
//                Padding(
//                  padding: EdgeInsets.all(8),
//                  child: Text(
//                    " Recent Product",
//                    style: TextStyle(
//                      color: Colors.purple,
//                      fontWeight: FontWeight.w900,
//                    ),
//                  ),
//                ),
//                Container(
//                  height: MediaQuery.of(context).size.height * .5,
//                  child: ProductList(),
//                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
