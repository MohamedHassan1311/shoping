import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:shoping/Screens/user/homeScreen.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/serves/store.dart';
import 'package:shoping/widgets/custom_textField.dart';

import '../../constant.dart';
import 'editProducts.dart';
import 'productsInApp.dart';

class EditAdmin extends StatefulWidget {
  static String id = "EditAdmin";

  @override
  _EditAdmin createState() => _EditAdmin();
}

class _EditAdmin extends State<EditAdmin> {
  var size = ["L", "xL", "m", "size"];
  var qantati = ["1", "2", "3", "4", "0"];
  var selectedQantti = "1";
  var selectedSize = "size";
  File _image;
  GlobalKey<ScaffoldState> scaffoldState;
  String _url;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    CartItem cartitems = Provider.of<CartItem>(context, listen: false);
    var _store = Store();

    String _name, _price, _description;
    final GlobalKey<FormState> _globalKeyName = GlobalKey<FormState>();
    final GlobalKey<FormState> _globalKeyPrice = GlobalKey<FormState>();
    final GlobalKey<FormState> _globalKeyDescription = GlobalKey<FormState>();
    final GlobalKey<FormState> _globalKeyOhoto = GlobalKey<FormState>();
    int x = cartitems.products.length;
    setState(() {
      product.Pname;
    });
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Navigator.of(context).pop(HomeScreen.id);
            },
            child: Text(product.Pname)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 1.5,
            child: Column(
              children: <Widget>[
                //=============================== Photo card =======================================
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
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
                Container(
                  height: MediaQuery.of(context).size.height * .12,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              product.Pname,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              " Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            Text(
                              " ${product.Pprice} \EGP",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //=============================== product dropdawn =======================================
                Container(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
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
                ),

                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(child: _deletButton()),
          Expanded(
              child: Builder(
            builder: (c) => RaisedButton(
              color: Colors.purple,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Center(
                            child: Builder(
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                actions: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: FlatButton(
                                              padding: EdgeInsets.only(
                                                  left: 40, right: 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.purple,
                                              child: Text(
                                                "Edit Name",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialog(
                                                          globalKeyName:
                                                              _globalKeyName,
                                                          titelName:
                                                              "Edit product name",
                                                          hintName:
                                                              "Product name",
                                                          textFieldvalue:
                                                              (value) {
                                                            _name = value;
                                                          },
                                                          showdialgvalue: () {
                                                            _globalKeyName
                                                                .currentState
                                                                .save();
                                                            try {
                                                              _store.editProduct(
                                                                  ({
                                                                    KProudectName:
                                                                        _name
                                                                  }),
                                                                  product
                                                                      .ProID);
                                                            } catch (e) {
                                                              print(e);
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    EditProductHome
                                                                        .id);
                                                          },
                                                        ));
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                              padding: EdgeInsets.only(
                                                  left: 40, right: 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.purple,
                                              child: Text(
                                                " Edit Price",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialog(
                                                          globalKeyName:
                                                              _globalKeyPrice,
                                                          titelName:
                                                              "Edit product price",
                                                          hintName:
                                                              "Product price",
                                                          textFieldvalue:
                                                              (value) {
                                                            _price = value;
                                                          },
                                                          showdialgvalue: () {
                                                            _globalKeyPrice
                                                                .currentState
                                                                .save();
                                                            try {
                                                              _store.editProduct(
                                                                  ({
                                                                    KProudectPrice:
                                                                        _price
                                                                  }),
                                                                  product
                                                                      .ProID);

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } catch (e) {
                                                              print(e);
                                                            }
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    EditProductHome
                                                                        .id);
                                                          },
                                                        ));
                                              },
                                            ),
                                          ),
                                          RaisedButton(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: Colors.purple,
                                            child: Text(
                                              " Edit Description",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDialog(
                                                        globalKeyName:
                                                            _globalKeyDescription,
                                                        titelName:
                                                            "Edit product name",
                                                        hintName:
                                                            "Product name",
                                                        textFieldvalue:
                                                            (value) {
                                                          _description = value;
                                                        },
                                                        showdialgvalue: () {
                                                          _globalKeyDescription
                                                              .currentState
                                                              .save();
                                                          try {
                                                            _store.editProduct(
                                                                ({
                                                                  KProudectDescription:
                                                                      _description
                                                                }),
                                                                product.ProID);

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                          Navigator.of(context)
                                                              .pushReplacementNamed(
                                                                  EditProductHome
                                                                      .id);
                                                        },
                                                      ));
                                            },
                                          ),
                                          RaisedButton(
                                            padding: EdgeInsets.only(
                                                left: 40, right: 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: Colors.purple,
                                            child: Text(
                                              "Edit Photo",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text("Edit Photo"),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        onPressed: () {
                                                          pickImage();
                                                        },
                                                        color: Colors.purple,
                                                        child: Text(
                                                          " Add photo",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                          onTap: pickImage,
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            size: 30,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Builder(
                                                          builder: (context) =>
                                                              RaisedButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color:
                                                                Colors.purple,
                                                            child: Text(
                                                              " Confirm",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await uplodeImage(
                                                                  product
                                                                      .Ploction);
                                                              _store.editProduct(
                                                                  ({
                                                                    KProudectLoction:
                                                                        _url
                                                                  }),
                                                                  product
                                                                      .ProID);
                                                              Scaffold.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .purple,
                                                                      style: BorderStyle
                                                                          .solid),
                                                                ),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white54,
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            5),
                                                                content: Text(
                                                                  "Item Update",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ));

                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacementNamed(
                                                                      EditProductHome
                                                                          .id);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: RaisedButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color:
                                                                Colors.purple,
                                                            child: Text(
                                                              " Cancel ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          RaisedButton(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: Colors.purple,
                                            child: Text(
                                              " Edit product (All)",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(EditProduct.id);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: RaisedButton(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.purple,
                                              child: Text(
                                                " Cancel ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: Text(
                "Edit",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ))
        ],
      ),
    );
  }

  _deletButton() {
    Product product = ModalRoute.of(context).settings.arguments;
    var _store = Store();
    return RaisedButton(
      color: Colors.purple,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Delet this product?"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.purple,
                    child: Text(
                      " Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _store.deletProduct(product.ProID);
                      Navigator.of(context)
                          .pushReplacementNamed(EditProductHome.id);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.purple,
                      child: Text(
                        " Cancel ",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print("${product.ProPrand} ${product.ProPcon}");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      child: Text(
        "Delet",
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  snak(BuildContext x) {
    return Scaffold.of(x).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
      ),
      backgroundColor: Colors.white54,
      duration: Duration(seconds: 5),
      content: Text(
        "Item added",
        style: TextStyle(color: Colors.black),
      ),
    ));
  }

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uplodeImage(prourl) async {
    FirebaseStorage storege =
        FirebaseStorage(storageBucket: 'gs://shoping-47fca.appspot.com');
    StorageReference ref = storege.ref().child(p.basename(_image.path));

    StorageUploadTask storageUploadTask = ref.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    await setState(() {
      _url = url;
    });

    print("$_url");
  }

  CustomDialog(
      {globalKeyName, textFieldvalue, showdialgvalue, titelName, hintName}) {
    return AlertDialog(
      title: Text(titelName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Form(
            key: globalKeyName,
            child: CtextField(hint: hintName, TextValue: textFieldvalue
//              (value) {
//                _name = value;
//              },
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (BuildContext x) => RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.purple,
                  child: Text(
                    " Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: showdialgvalue),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Colors.purple,
                child: Text(
                  " Cancel ",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
