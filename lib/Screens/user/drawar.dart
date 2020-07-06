import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping/serves/auth.dart';

import '../login_screen.dart';

class Darwer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = MediaQuery.of(context).size.width * 100;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //==========================================================================================
          // build Top Section of Profile (include : Profile Image)
          //==========================================================================================
          _buildHeader(),

          //==========================================================================================
          // build middle Section of Profile (include : main info  )
          //==========================================================================================
          _buildMainInfo(context, widthC),

          SizedBox(height: 10.0),

          //==========================================================================================
          //  build Bottom Section of Profile (include : email - phone number - about - location )
          //==========================================================================================
          _buildInfo(context, widthC),
        ],
      ),
    ));
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Ink(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            gradient: LinearGradient(colors: [
              Colors.purple,
              Colors.purple,
              Colors.purple,
              Colors.purple,
              Colors.purple,
            ]),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 140),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.white,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.purple,
                      Colors.purple,
                      Colors.purple,
                      Colors.purple,
                    ]),
                  ),
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(85),
                        child: Image.network(
                            "https://scontent.fcai3-2.fna.fbcdn.net/v/t1.0-9/93049497_2558765277670159_5582735131430354944_o.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=VFEaBDJhb-wAX-86xwa&_nc_ht=scontent.fcai3-2.fna&oh=95d3f6a10e412a1a88433c8c9c612e78&oe=5EEBDF73",
                            width: 85,
                            height: 85,
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMainInfo(BuildContext context, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          Text('Mohamed Hassan',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Flutter', style: TextStyle(color: Colors.purple))
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, double width) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.purple),
                      title: Text("E-Mail"),
                      subtitle: Text("mh@gmailc.com"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.purple),
                      title: Text("Phone Number"),
                      subtitle: Text("******"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.purple),
                      title: Text("About"),
                      subtitle: Text("Flutter Devlobar"),
                    ),
                    Divider(),
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: Icon(Icons.my_location, color: Colors.purple),
                      title: Text("Location"),
                      subtitle: Text("Eygpt"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Auth _auth = Auth();

                        try {
                          _auth.logout();
                        } catch (e) {}
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScrren.id, (context) => false);
                      },
                      child: Text("Log out"),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
//      Scaffold(
//      body: Container(
//        child: ListView(
//          children: <Widget>[
//            UserAccountsDrawerHeader(
//              accountName: Text("mohamed"),
//              accountEmail: Text("mohamed"),
//              currentAccountPicture: GestureDetector(
//                onTap: null,
//                child: CircleAvatar(
//                  backgroundColor: Colors.grey,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pop(HomeScreen.id);
//              },
//              child: Center(
//                child: ListTile(
//                  leading: Icon(Icons.home),
//                  title: Text("Home"),
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pop(HomeScreen.id);
//              },
//              child: ListTile(
//                leading: Icon(Icons.person),
//                title: Text("My Account"),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pushNamed(Cart.id);
//              },
//              child: ListTile(
//                leading: Icon(Icons.shopping_cart),
//                title: Text("Cart"),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pop(HomeScreen.id);
//              },
//              child: ListTile(
//                leading: Icon(Icons.shopping_basket),
//                title: Text("My Orders"),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pop(HomeScreen.id);
//              },
//              child: ListTile(
//                leading: Icon(Icons.lightbulb_outline),
//                title: Text("Categoris"),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
