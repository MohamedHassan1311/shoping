import 'package:badges/badges.dart';
import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:shoping/Screens/user/cart.dart';
import 'package:shoping/Screens/user/drawar.dart';
import 'package:shoping/Screens/user/welcomeHome.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/badge_cololr.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/provider/network_senstev.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';

class HomeScreen extends StatefulWidget {
  static String id = "vv";
  int _page = 1;
  HomeScreen();
  HomeScreen.page(this._page);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<CartItem>(context).products;

    return Scaffold(
      body: InfoWidget(
        builder: (context, deviceInfo) => Builder(
          builder: (context) {
            return NetworkSensitive(
              child: Stack(
                children: <Widget>[
                  if (widget._page == 0)
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Darwer()),
                  if (widget._page == 1)
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: WelcomeHome()),
                  if (widget._page == 2)
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Cart()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CurvedNavigationBar(
                      index: widget._page,
                      height: 50.0,
                      items: <Widget>[
                        Icon(Icons.person, size: 30),
                        Icon(Icons.home, size: 30),
                        (Provider.of<BadgeCololr>(context).Badgecolor &&
                                product.length > 0)
                            ? Badge(
                                badgeColor: Colors.purple,
                                position:
                                    BadgePosition.topRight(top: 11, right: 40),
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
                            : Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.black,
                              ),

//          Icon(Icons.shopping_cart, size: 30),
                      ],
                      color: Colors.white,
                      buttonBackgroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      animationCurve: Curves.easeInOut,
                      animationDuration: Duration(milliseconds: 600),
                      onTap: (index) {
                        if (index == 2) {
                          Provider.of<BadgeCololr>(context, listen: false)
                              .changeBadgecolor(false);
                        } else {
                          Provider.of<BadgeCololr>(context, listen: false)
                              .changeBadgecolor(true);
                        }
                        setState(() {
                          widget._page = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

//        if (ConnectivityResult.none != null) {

//        }
//        return

//      bottomNavigationBar: CurvedNavigationBar(
//        index: widget._page,
//        height: 50.0,
//        items: <Widget>[
//          Icon(Icons.person, size: 30),
//          Icon(Icons.home, size: 30),
//          (Provider.of<BadgeCololr>(context).Badgecolor && product.length > 0)
//              ? Badge(
//                  badgeColor: Colors.purple,
//                  position: BadgePosition.topRight(top: 11, right: 40),
//                  badgeContent: Text(
//                    "${product.length}",
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  child: Icon(
//                    Icons.shopping_cart,
//                    size: 30,
//                    color: Colors.black,
//                  ),
//                )
//              : Icon(
//                  Icons.shopping_cart,
//                  size: 30,
//                  color: Colors.black,
//                ),
//
////          Icon(Icons.shopping_cart, size: 30),
//        ],
//        color: Colors.white,
//        buttonBackgroundColor: Colors.white,
//        backgroundColor: Colors.purple,
//        animationCurve: Curves.easeInOut,
//        animationDuration: Duration(milliseconds: 600),
//        onTap: (index) {
//          if (index == 2) {
//            Provider.of<BadgeCololr>(context, listen: false)
//                .changeBadgecolor(false);
//          } else {
//            Provider.of<BadgeCololr>(context, listen: false)
//                .changeBadgecolor(true);
//          }
//          setState(() {
//            widget._page = index;
//          });
//        },
//      ),
    );
  }

  _checkconectvi() async {
    var result = await Connectivity().checkConnectivity();
    bool x = true;
    if (result == ConnectivityResult.none) {
      print("none");
      x = false;
    }
//    if (result == ConnectivityResult.mobile) {
//      print("mobile");
//      x = false;
//    }
//    if (result == ConnectivityResult.wifi) {
//      print("wifi");
//      x = false;
//    }
    print(x);
    return x;
  }
}
