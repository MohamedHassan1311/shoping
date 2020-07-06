import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping/categories/pants.dart';
import 'package:shoping/responsive/eesponsive_widget.dart';

class HerizontalList extends StatelessWidget {
//    "imageCaption":"Dress" ,

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Container(
        width: deviceInfo.screenWidth * .10,
        height: deviceInfo.screenHeight * .10,
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Category(
              imageCaption: "Dress",
              imageLocation: "assets/images/icon/dress.png",
            ),
            Category(
              x: () => Navigator.of(context).pushNamed(pants.id),
              imageCaption: "Pants",
              imageLocation: "assets/images/icon/pants.png",
            ),
            Category(
              imageCaption: "T-Shirt",
              imageLocation: "assets/images/icon/tshirt.png",
            ),
            Category(
              imageCaption: "Jacket",
              imageLocation: "assets/images/icon/jacket.png",
            ),
            Category(
              imageCaption: "Coat",
              imageLocation: "assets/images/icon/coat.png",
            ),
            Category(
              imageCaption: "Shirt",
              imageLocation: "assets/images/icon/shirt.png",
            ),
          ],
        ),
      );
    });
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  var x;

  Category({this.imageLocation, this.imageCaption, this.x});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo) => InkWell(
        onTap: x,
        child: Card(
//        color: Colors.white54,
          elevation: 20,
          child: Container(
            width: deviceInfo.screenWidth,
            height: deviceInfo.screenHeight * .2,
            child: ListTile(
              title: Image.asset(
                imageLocation,
                height: deviceInfo.screenHeight * .10,
                width: deviceInfo.screenWidth,
              ),
              subtitle: Text(
                imageCaption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
