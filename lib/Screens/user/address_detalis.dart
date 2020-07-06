import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';
import 'package:shoping/responsive/text_size.dart';

import '../../constant.dart';

class AdderessDetiels extends StatefulWidget {
  static String id = "Address";
  @override
  _AdderessDetielsState createState() => _AdderessDetielsState();
}

class _AdderessDetielsState extends State<AdderessDetiels> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  var Goveernment = [
    "الإسكندرية",
    "الإسماعيلية",
    "أسوان",
    "أسيوط",
    "الأقصر",
    "البحر الأحمر",
    "البحيرة",
    "بني سويف",
    "	بورسعيد",
    "جنوب سيناء",
    "الجيزة",
    "الدقهلية",
    "دمياط",
    "سوهاج",
    "السويس",
    "الشرقية",
    "شمال سيناء",
    "الغربية",
    "الفيوم",
    "القاهرة",
    "القليوبية",
    "قنا",
    "كفر الشيخ	",
    "مطروح",
    "المنوفية",
    "المنيا",
    "الوادي الجديد",
  ];
  var selectedGoveernment = "الدقهلية";
  SharedPreferences prefs;
  saveData(addres) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList("addres", addres);
  }

  getDate() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      addres = prefs.getStringList("addres");
    });
//    return addres;
  }

  @override
  Widget build(BuildContext context) {
    getDate();
//    print(getDate());
    return Scaffold(
      body: ListView(
        children: <Widget>[
          InfoWidget(
            builder: (context, deviceInfo) => Form(
                key: _globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Text("Add Address",
                            style: TextStyle(fontSize: HeadTitel(deviceInfo)))),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Frist Name",
                                  style:
                                      TextStyle(fontSize: SubTitel(deviceInfo)),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            AdreesForm(
                              hint: "Enter Frist Name",
                              TextValue: (v) {
                                FName = v;
                              },
                            )
                          ],
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.center,
                                child: Text("Last Name",
                                    style: TextStyle(
                                        fontSize: SubTitel(deviceInfo)))),
                            SizedBox(
                              height: 5,
                            ),
                            AdreesForm(
                              hint: "Enter Last Name",
                              TextValue: (v) {
                                LName = v;
                              },
                            )
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Address",
                            style: TextStyle(fontSize: SubTitel(deviceInfo)))),
                    SizedBox(
                      height: 5,
                    ),
                    AdreesForm(
                      hint: "Enter Street Name /Building number ",
                      TextValue: (v) {
                        add = v;
                      },
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("City",
                            style: TextStyle(fontSize: SubTitel(deviceInfo)))),
                    SizedBox(
                      height: 5,
                    ),
                    AdreesForm(
                      hint: "Enter City",
                      TextValue: (v) {
                        city = v;
                      },
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Government",
                            style: TextStyle(fontSize: SubTitel(deviceInfo)))),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        items: Goveernment.map((Goveernment) {
                          return DropdownMenuItem(
                            value: Goveernment,
                            child: Text(
                              Goveernment,
                              style: TextStyle(color: Colors.black87),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            selectedGoveernment = v;
                          });
                        },
                        value: selectedGoveernment,
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Phone Number",
                            style: TextStyle(fontSize: SubTitel(deviceInfo)))),
                    SizedBox(
                      height: 5,
                    ),
                    AdreesForm(
                      hint: "Enter Phone Number",
                      TextValue: (v) {
                        pN = v;
                      },
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          color: Colors.purple,
                          onPressed: () async {
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
//                              setState(() {
                              addres = [
                                FName,
                                LName,
                                add,
                                city,
                                selectedGoveernment,
                                pN
                              ];

                              saveData(addres);

                              Navigator.of(context).pop();

//
////
                            }
                          },
                          child: Text("Save"),
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget AdreesForm({hint, TextValue}) {
    return TextFormField(
      showCursor: true,
      cursorRadius: Radius.circular(20),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white54,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.purple),
        ),
        hintText: hint,
        focusColor: Colors.white54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
      onSaved: TextValue,
      validator: (v) {
        if (v.isEmpty) {
          return (hint);
        } else
          return null;
      },
    );
  }
}
