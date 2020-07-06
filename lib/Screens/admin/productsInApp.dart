import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/serves/store.dart';

import '../../constant.dart';
import 'editAndDelet.dart';

class EditProductHome extends StatefulWidget {
  static String id = "EditPro";

  @override
  _EditProductHomeState createState() => _EditProductHomeState();
}

class _EditProductHomeState extends State<EditProductHome> {
  var _store = Store();

  @override
  Widget build(BuildContext context) {
    var sca = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProudect(KProudectColletion),
            builder: (context, snapshots) {
              List<Product> product = [];
              if (snapshots.hasData) {
                for (var doc in snapshots.data.documents) {
//
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .9),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: StreamBuilder<Object>(
                          stream: null,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(EditAdmin.id,
                                    arguments: product[index]);
                              },
                              child: Card(
                                elevation: 20,
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
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          "Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          " ${product[index].Pname} ",
                                                          style: TextStyle(),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Text(
                                                      " Price",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: Image.network(
                                        product[index].Ploction,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
