import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:shoping/models/cover.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/serves/store.dart';

import 'add_product.dart';
import 'productsInApp.dart';

class AdminHomeScreen extends StatefulWidget {
  static String id = "vv1";

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  File _image;
  String _url;
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * .03;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoding,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/loginBG.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .3,
                        vertical: 20),
                    child: Text(
                      "Add Product",
                      style: TextStyle(fontSize: 20, letterSpacing: 1),
                    ),
//                  textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, AddProduct.id);
                    },
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              SizedBox(
                height: hight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .3,
                        vertical: 20),
                    child: Text(
                      "Edit Product",
                      style: TextStyle(fontSize: 20, letterSpacing: 1),
                    ),
//                  textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, EditProductHome.id);
                    },
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              SizedBox(
                height: hight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .3,
                        vertical: 20),
                    child: Text(
                      "View Orders",
                      style: TextStyle(fontSize: 20, letterSpacing: 1),
                    ),
//                /  textColor: Colors.white,
                    onPressed: () async {},
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              SizedBox(
                height: hight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Builder(
                    builder: (context) => RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .3,
                          vertical: 20),
                      child: Text(
                        "Cover photo",
                        style: TextStyle(fontSize: 20, letterSpacing: 1),
                      ),
//                /  textColor: Colors.white,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Uplode Photo"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Builder(
                                  builder: (context) => RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    onPressed: () {
                                      pickImage();
                                    },
                                    color: Colors.purple,
                                    child: Text(
                                      " Add photo",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    color: Colors.purple,
                                    child: Text(
                                      " Confirm",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      final modelhud = Provider.of<ModelHud>(
                                          context,
                                          listen: false);
                                      var _store = Store();
                                      try {
                                        modelhud.ChangeIsLoding(true);

                                        await uplodeImage();
                                        await _store.addCover(Cover(
                                          CoverLocation: _url,
                                        ));
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: Colors.purple,
                                                style: BorderStyle.solid),
                                          ),
                                          backgroundColor: Colors.white54,
                                          duration: Duration(seconds: 5),
                                          content: Text(
                                            "Item Update",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ));
                                        Navigator.of(context).pop();
                                        modelhud.ChangeIsLoding(false);
                                      } catch (e) {
                                        modelhud.ChangeIsLoding(false);
                                        Navigator.of(context).pop();

                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Have a snack!'),
                                        ));
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
                          ),
                        );
                      },
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
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

    print("xxxxxxxxxxxxxxx $_url");
  }
}
