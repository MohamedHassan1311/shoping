import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping/Screens/user/poduct_detils.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/serves/store.dart';

import '../constant.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: store.loadProudect(KProudectColletion),
            builder: (context, snapshots) {
              List<Product> product = [];
              if (snapshots.hasData) {
                for (var doc in snapshots.data.documents) {
                  product.add(
                    Product(
                      Pcatogery: doc.data[KProudectCatogery],
                      Pprice: doc.data[KProudectPrice],
                      Pdescriptin: doc.data[KProudectDescription],
                      Pname: doc.data[KProudectName],
                      Ploction: doc.data[KProudectLoction],
                      ProPrand: doc.data[KProudectPrand],
                      ProPcon: doc.data[KProudectCondation],
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .9),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return InfoWidget(
                      builder: (context, deviceInfo) => Container(
                        width: deviceInfo.screenWidth,
                        height: deviceInfo.screenHeight,
                        child: StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ProductDetiels.id,
                                      arguments: product[index]);
                                },
                                child: Container(
                                  width: deviceInfo.screenWidth,
                                  height: deviceInfo.screenHeight,
                                  child: Card(
                                    elevation: 2,
                                    child: Stack(
                                      children: <Widget>[
                                        GridTile(
                                          footer: Container(
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
                                                              color:
                                                                  Colors.red),
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
                                          child: Image.network(
                                            product[index].Ploction,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ),
//                                    IconButton(
//                                        icon: Icon(
//                                          Icons.add_shopping_cart,
//                                          size: 20,
//                                        ),
//                                        onPressed: () {}),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                );
              } else
                return CircularProgressIndicator();
            }
//         ;

            ),
      ),
    );
  }
}

//class _ProductListState extends State<ProductList> {
//  List ProItems <Product>= [
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos///2020/V/0/2/p/1887/340/401/21/w/240/1887340401_1_1_1.jpg?ts=1588162618810",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "Tshirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos///2020/V/M/1/p/0000/006/577/2/w/240/0000006577_2_2_1.jpg?ts=1588257431028",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "shirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos///2020/V/0/2/p/4323/417/250/20/w/605/4323417250_1_1_1.jpg?ts=1588751159289",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "TTshirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos///2020/V/0/2/p/6917/470/712/2/w/224/6917470712_6_1_1.jpg?ts=1583409448060",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "shirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos//mkt/spots/ss20-north-campaign-man/layout-desktop//look3-ss20-north-campaign-man-image04_0.jpg?ts=1587058361070&imwidth=328",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "TTshirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
////    {
////      "ProductPhoto":
////          "https://static.zara.net/photos//mkt/spots/ss20-north-campaign-man/layout-desktop//look2-ss20-north-campaign-man-image03_0.jpg?ts=1587058361070&imwidth=448",
////      "ProductPrice": 100,
////      "ProductOldPrice": 200,
////      "productname": "TTshirt",
////      "priDescription":
////          "White - 4323/417Relaxed fit collared shirt with short sleeves. Featuring side vents at the hem and a button-up front."
////    },
//  ];
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//        itemCount: ProItems.length,
//        gridDelegate:
//            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//        itemBuilder: (BuildContext context, index) {
//          return Singleprod(
//              pro_photo: ProItems[index]["ProductPhoto"],
//              Pro_Price: ProItems[index]["ProductPrice"],
//              pro_name: ProItems[index]["productname"],
//              pro_oldPrice: ProItems[index]["ProductOldPrice"],
//              priDescription: ProItems[index]["priDescription"]);
//        });
//  }
//}
//
//class Singleprod extends StatelessWidget {
//  final pro_photo;
//  final pro_oldPrice;
//  final pro_name;
//  final Pro_Price;
//  final priDescription;
//
//  const Singleprod({
//    this.priDescription,
//    this.Pro_Price,
//    this.pro_photo,
//    this.pro_oldPrice,
//    this.pro_name,
//  });
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Hero(
//        tag: Text("Hero 1"),
//        child: Material(
//          child: InkWell(
//            onTap: () {
////              Navigator.of(context).pushNamed(ProductDetiels.id);
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                    builder: (context) => ProductDetiels(
//                          proPrice: Pro_Price,
//                          proPhoto: pro_photo,
//                          proName: pro_name,
//                          priDescription: priDescription,
//                          proOldPrice: pro_oldPrice,
//                        )),
//              );
//            },
//            child: Container(
//              height: MediaQuery.of(context).size.height,
//              child: GridTile(
//                  footer: Container(
//                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                      color: Colors.white70,
//                      child: ListTile(
//                        leading: Text(
//                          pro_name,
//                          style: TextStyle(fontWeight: FontWeight.w900),
//                        ),
//                        title: Text(
//                          "${Pro_Price}",
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, color: Colors.red),
//                        ),
//                        subtitle: Text(
//                          "${pro_oldPrice}",
//                          style: TextStyle(
//                            decoration: TextDecoration.lineThrough,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      )),
//                  child: Image.network(
//                    pro_photo,
//                    fit: BoxFit.contain,
//                  )),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
