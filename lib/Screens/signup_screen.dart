import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/serves/auth.dart';
import 'package:shoping/widgets/custom_textField.dart';

import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  static String id = "Signup";
  var signupkey = GlobalKey<FormState>();
  String _email, _password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
//    var height= MediaQuery.of(context).size.height;
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
            key: signupkey,
            child: ListView(
              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(top: 80),
//                  child: Container(
//                    height: MediaQuery.of(context).size.height * .2,
////                  child: Stack(
////                    alignment: Alignment.center,
////                    children: <Widget>[
////                      Image(
////                        image: AssetImage("assets/images/icon.png"),
////                      ),
////                      Positioned(
////                          bottom: 10,
////                          child: Row(
////                            children: <Widget>[
////                              Text(
////                                "Life Market",
////                                style: TextStyle(fontSize: 20),
////                              ),
////                            ],
////                          )),
////                    ],
////                  ),
//                  ),
//                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      CtextField(
                        txtIcon: Icons.person,
                        hint: "Enter Your Name",
                        TextValue: (x) {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CtextField(
                        txtIcon: Icons.email,
                        hint: "Enter Your Email",
                        TextValue: (x) {
                          _email = x;
                        },
                      ),
                      SizedBox(
                        height: 10,
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
                          "Sign up",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.black),
                        ),
                        textColor: Colors.white,
                        onPressed: () async {
                          final modelHud =
                              Provider.of<ModelHud>(context, listen: false);
                          modelHud.ChangeIsLoding(true);
                          if (signupkey.currentState.validate()) {
                            try {
                              signupkey.currentState.save();
                              final autthresult =
                                  await auth.signUp(_email, _password);
                              modelHud.ChangeIsLoding(true);
                              Navigator.pushReplacementNamed(
                                  context, LoginScrren.id);
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                ),
                              );
                            }
                          }
                          modelHud.ChangeIsLoding(false);
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
                      " have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                          context, LoginScrren.id),
                      child: Text(
                        "Signin",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
