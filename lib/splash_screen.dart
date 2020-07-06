import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Screens/login_screen.dart';

class SplashScrren extends StatefulWidget {
  static String id = "splash";
  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      image: Image.asset(
        "assets/images/icon.png",
        fit: BoxFit.cover,
      ),
      photoSize: 100,
      backgroundColor: Colors.purple,
      navigateAfterSeconds: LoginScrren(),
    );
  }
}
