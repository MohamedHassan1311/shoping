import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/serves/store.dart';
import 'package:shoping/widgets/custom_textField.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category, _prand, _con;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _store = Store();

  File _image;

  String _url;

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * .01;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoding,
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                height: MediaQuery.of(context).size.height * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/loginBG.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Add Product Name",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            hint: 'Product Name',
                            TextValue: (value) {
                              _name = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product price",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            TextValue: (value) {
                              _price = value;
                            },
                            hint: 'Product Price',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product Description",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            TextValue: (value) {
                              _description = value;
                            },
                            hint: 'Product Description',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product Catogory ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            TextValue: (value) {
                              _category = value;
                            },
                            hint: 'Product Category',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product Prand ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            TextValue: (value) {
                              _prand = value;
                            },
                            hint: 'Product Prand',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product Condation ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CtextField(
                            TextValue: (value) {
                              _con = value;
                            },
                            hint: 'Product condation',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Product Photo ",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white54,
                            backgroundImage:
                                _image == null ? null : FileImage(_image),
                            radius: 80,
                          ),
                          GestureDetector(
                              onTap: pickImage,
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white54,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Builder(
                            builder: (context) => RaisedButton(
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide.none),
                              onPressed: () async {
                                _globalKey.currentState.save();

                                if (_globalKey.currentState.validate()) {
                                  final modelhud = Provider.of<ModelHud>(
                                      context,
                                      listen: false);

                                  try {
                                    modelhud.ChangeIsLoding(true);
                                    await uplodeImage();
                                    await _store.addProudect(Product(
                                        Pname: _name,
                                        Pprice: _price,
                                        Pdescriptin: _description,
                                        Ploction: _url,
                                        Pcatogery: _category,
                                        ProPrand: _prand,
                                        ProPcon: _con));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Colors.purple,
                                            style: BorderStyle.solid),
                                      ),
                                      backgroundColor: Colors.white54,
                                      duration: Duration(seconds: 5),
                                      content: Text(
                                        "Item added",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                                  } catch (e) {
                                    print(e);

                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Colors.purple,
                                            style: BorderStyle.solid),
                                      ),
                                      backgroundColor: Colors.white54,
                                      duration: Duration(seconds: 5),
                                      content: Text(
                                        e,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
//                                    modelhud.ChangeIsLoding(false);
//
//
                                  }
                                  modelhud.ChangeIsLoding(false);
                                } else
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.purple,
                                          style: BorderStyle.solid),
                                    ),
                                    backgroundColor: Colors.white70,
                                    duration: Duration(milliseconds: 500),
                                    content: Text(
                                      "Enter value ",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ));
                                print(
                                    "sssssssssssssssssssssssssssssssssssssssssss");
                              },
                              child: Text('Add Product'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uplodeImage() async {
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
}
