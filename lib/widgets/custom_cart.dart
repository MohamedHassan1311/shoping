import 'package:flutter/material.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/responsive/dvise_info.dart';
import 'package:shoping/responsive/text_size.dart';

class CustomCArd extends StatelessWidget {
  BuildContext context;
  List<Product> product;
  int index;
  var onpress;
  DeviceInfo deviseinfo;

  CustomCArd(
      {this.context, this.product, this.deviseinfo, this.index, this.onpress});
  @override
  Widget build(BuildContext context) {
    return Material(
        shadowColor: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 3.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width - 20.0,
              height: deviseinfo.screenHeight * .200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(children: <Widget>[
                Container(
                  height: deviseinfo.screenHeight,
                  width: deviseinfo.screenWidth * .200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(product[index].Ploction),
                          fit: BoxFit.contain)),
                ),
                SizedBox(width: deviseinfo.screenHeight * .020),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Price",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: HeadTitel(deviseinfo),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviseinfo.screenHeight * .01),
                    Text(
                      "${product[index].Pprice}" + "\EGP",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: SubTitel(deviseinfo),
                          color: Colors.red),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: deviseinfo.screenHeight * .030),
                      Text(
                        'qantati:',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: HeadTitel(deviseinfo),
                            color: Colors.grey),
                      ),
                      Text(
                        '${product[index].qantati} ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SubTitel(deviseinfo),
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: deviseinfo.screenHeight * .010,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        product[index].Pname,
                        style: TextStyle(
                            fontSize: HeadTitel(deviseinfo),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FlatButton.icon(
//                padding: EdgeInsets.all(20.0),
//                            color: Colors.purple,
                      icon: Icon(
                        Icons.delete,
                        size: SubTitel(deviseinfo),
                      ),
                      label: Text(
                        "Remove",
                        style: TextStyle(
                          fontSize: SubTitel(deviseinfo),
                        ),
                      ),
                      onPressed: onpress,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.purple,
              height: 2,
              endIndent: 25,
              thickness: 3,
              indent: 25,
            )
          ],
        ));
  }
}
