import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shoping/Screens/signup_screen.dart';
import 'package:shoping/Screens/user/homeScreen.dart';
import 'package:shoping/provider/admiMode.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/serves/auth.dart';
import 'package:shoping/widgets/custom_textField.dart';

import 'admin/adminHome.dart';

class LoginScrren extends StatelessWidget {
  final loginKey = GlobalKey<FormState>();
  static String id = "/login";
  String _email, _password;
  final auth = Auth();
  bool isAdmin = !true;
  final AdminPassworde = "123456";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loginBG.jpg"),
              fit: BoxFit.cover),
        ),
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoding,
          child: Form(
            key: loginKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Welcome.... ",
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.purple,
                                    fontFamily: "Pacifico"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 2,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Let`s Start Login Now!!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontFamily: "Pacifico"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
//                    child: Stack(
//                      alignment: Alignment.center,
//                      children: <Widget>[
//                        Image(
//                          image: AssetImage("assets/images/icon.png"),
//                        ),
//                        Positioned(
//                            bottom: 10,
//                            child: Row(
//                              children: <Widget>[
//                                Text(
//                                  "Life Market",
//                                  style: TextStyle(
//                                      fontSize: 20,
//                                      fontWeight: FontWeight.w900),
//                                ),
//                              ],
//                            )),
//                      ],
//                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      CtextField(
                        txtIcon: Icons.email,
                        hint: "Enter Your Email",
                        TextValue: (x) {
                          _email = x;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CtextField(
                        txtIcon: Icons.lock_outline,
                        hint: "Enter Your Password",
                        TextValue: (x) {
                          _password = x;
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20, letterSpacing: 1),
                        ),
//                      textColor: Colors.white,
                        onPressed: () async {
                          _vildat(context);
                        },
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don`t have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignupScreen.id),
                      child: Text(
                        "signup",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .changeIsAdmin(true);

//                          Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: Text(
                            "Admin",
                            style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.black12
                                  : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);

//                        Navigator.pushNamed(context, SignupScreen.id);
                        },
                        child: Text(
                          "User",
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? Colors.red
                                : Colors.black12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _vildat(BuildContext context) async {
    loginKey.currentState.save();
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.ChangeIsLoding(true);
    if (loginKey.currentState.validate()) {
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == AdminPassworde) {
          try {
            await auth.signIn(_email, _password);
            modelhud.ChangeIsLoding(true);
            Navigator.pushReplacementNamed(context, AdminHomeScreen.id);
          } on PlatformException catch (e) {
            modelhud.ChangeIsLoding(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side:
                    BorderSide(color: Colors.purple, style: BorderStyle.solid),
              ),
              duration: Duration(seconds: 5),
              content: Text(
                e.message,
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white54,
            ));
          }
        } else {
          modelhud.ChangeIsLoding(true);
          Scaffold.of(context).showSnackBar(SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
            ),
            duration: Duration(seconds: 5),
            content: Text(
              "Admin Password InValid!!",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white54,
          ));
        }
      } else {
        try {
          await auth.signIn(_email, _password);
          modelhud.ChangeIsLoding(true);
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } on PlatformException catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.black, style: BorderStyle.solid),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.white54,
            content: Text(
              e.message,
              style: TextStyle(color: Colors.black),
            ),
          ));
        }
      }
      modelhud.ChangeIsLoding(false);
    }
    modelhud.ChangeIsLoding(false);
  }
}
