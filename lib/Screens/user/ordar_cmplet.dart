import 'package:flutter/material.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';

import 'homeScreen.dart';

class CompletOrdar extends StatelessWidget {
  static String id = "com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoWidget(
        builder: (context, deviceInfo) => Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.done,
                  color: Colors.purple,
                  size: 200,
                ),
                Text(
                  "Ordar done",
                  style: TextStyle(fontSize: 30, fontFamily: "Caveat"),
                ),
                Text(
                  "Thank You  ",
                  style: TextStyle(fontSize: 30, fontFamily: "Caveat"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RaisedButton(
        child: Text(
          "Back to Home",
          style: TextStyle(fontSize: 20, letterSpacing: 1),
        ),
        textColor: Colors.white,
        onPressed: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => HomeScreen.page(1)),
              (rout) => false);
        },
        color: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
