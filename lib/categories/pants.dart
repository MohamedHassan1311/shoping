import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/Screens/user/cart.dart';
import 'package:shoping/Screens/user/poduct_detils.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/serves/store.dart';

import '../constant.dart';

class pants extends StatefulWidget {
  static String id = "pants";
  @override
  _pantesState createState() => _pantesState();
}

class _pantesState extends State<pants> {
  var store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    CartItem cartitems = Provider.of<CartItem>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pants"),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15, left: 15, top: 8),
                child: Badge(
                  badgeContent: Text("${cartitems.products.length}"),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Cart.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: InfoWidget(
        builder: (context, deviceInfo) => Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: store.loadProudect(KProudectColletion),
              builder: (context, snapshots) {
                List<Product> product = [];
                if (snapshots.hasData) {
                  try {
                    for (var doc in snapshots.data.documents) {
                      var data = doc.data;
                      product.add(
                        Product(
                          Pname: data[KProudectName],
                          Pprice: data[KProudectPrice],
                          Pdescriptin: data[KProudectDescription],
                          Pcatogery: data[KProudectCatogery],
                          Ploction: data[KProudectLoction],
                          ProID: doc.documentID,
                          ProPrand: data[KProudectPrand],
                          ProPcon: data[KProudectCondation],
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .9),
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: deviceInfo.screenHeight,
                        width: deviceInfo.screenWidth,
                        child: StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ProductDetiels.id,
                                      arguments: product[index]);
                                },
                                child: Card(
                                  elevation: 10,
                                  child: Stack(
                                    children: <Widget>[
                                      GridTile(
                                        footer: Container(
                                          height: deviceInfo.screenHeight,
                                          width: deviceInfo.screenWidth,
                                          color: Colors.white70,
                                          child: ListTile(
                                            title: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Text(
                                                        " Price",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        " ${product[index].Pprice} \EGP",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          " Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          " ${product[index].Pname} ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              product[index].Ploction),
                                        ),
                                      ),
//                                    IconButton(
//                                        icon: Icon(
//                                          Icons.add_shopping_cart,
//                                          size: 20,
//                                        ),
//                                        onPressed: () {
//                                          CartItem cartitem =
//                                              Provider.of<CartItem>(context,
//                                                  listen: false);
////                                          cartitem.addProduct(product);
//                                        }),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  );
                } else
                  return CircularProgressIndicator();
              }
//         ;

              ),
        ),
      ),
    );
  }
}
