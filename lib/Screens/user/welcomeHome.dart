import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shoping/companets/herizontal_List.dart';
import 'package:shoping/companets/productList.dart';
import 'package:shoping/models/cover.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/serves/store.dart';

import '../../constant.dart';

class WelcomeHome extends StatelessWidget {
  static String id = "welcome ";
  var _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Shop Now",
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        actions: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * .7,
//                height: MediaQuery.of(context).size.width * .5,
//             ,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.green,
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "What are you looking for?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ))
        ],
//        backgroundColor: Colors.green,
      ),
      body: InfoWidget(
        builder: (context, deviceInfo) => StreamBuilder(
            stream: _store.loadProudect(Kcover),
            builder: (context, snapshots) {
              List<Cover> product = [];
              if (snapshots.hasData) {
                for (var doc in snapshots.data.documents) {
//
                  var data = doc.data;
                  product.add(
                    Cover(CoverLocation: data[KcoverPhoto]),
                  );
                }

                return InfoWidget(
                  builder: (context, deviceInfo) => ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.screenWidth
                                    : deviceInfo.screenHeight * .2,
                            height:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.screenHeight * .2
                                    : deviceInfo.screenWidth * .2,
                            child: Carousel(
                              dotBgColor: Colors.transparent,
                              dotSize: 5,
                              indicatorBgPadding: 6,
                              dotHorizontalPadding: 50,
                              borderRadius: true,
                              autoplay: true,
                              boxFit: BoxFit.cover,
                              images: [
                                NetworkImage(product[1].CoverLocation),
                                NetworkImage(product[3].CoverLocation),
                                NetworkImage(
                                    product[2].CoverLocation.toString())
                              ],
                              dotIncreasedColor: Colors.white54,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text("Category"),
                          ),
                          Container(
                              width:
                                  deviceInfo.orientation == Orientation.portrait
                                      ? deviceInfo.screenWidth
                                      : deviceInfo.screenHeight * .15,
                              height:
                                  deviceInfo.orientation == Orientation.portrait
                                      ? deviceInfo.screenHeight * .15
                                      : deviceInfo.screenWidth * .15,
                              child: HerizontalList()),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text("Recent Product"),
                          ),
                          Container(
                              width:
                                  deviceInfo.orientation == Orientation.portrait
                                      ? deviceInfo.screenWidth
                                      : deviceInfo.screenHeight,
                              height:
                                  deviceInfo.orientation == Orientation.portrait
                                      ? deviceInfo.screenHeight
                                      : deviceInfo.screenWidth * .5,
                              child: ProductList()),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
