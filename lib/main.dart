import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/Screens/user/cart.dart';
import 'package:shoping/Screens/user/welcomeHome.dart';
import 'package:shoping/categories/pants.dart';
import 'package:shoping/provider/addres_Detils.dart';
import 'package:shoping/provider/admiMode.dart';
import 'package:shoping/provider/badge_cololr.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/serves/conectivti.dart';
import 'package:shoping/splash_screen.dart';
import 'package:shoping/theme/themeData.dart';

import 'Screens/admin/add_product.dart';
import 'Screens/admin/adminHome.dart';
import 'Screens/admin/editAndDelet.dart';
import 'Screens/admin/editProducts.dart';
import 'Screens/admin/productsInApp.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';
import 'Screens/user/address_detalis.dart';
import 'Screens/user/confirm_Ordar.dart';
import 'Screens/user/homeScreen.dart';
import 'Screens/user/ordar_cmplet.dart';
import 'Screens/user/poduct_detils.dart';
import 'enums/enum.dart';

void main() => runApp(DevicePreview(builder: (context) => MyApp()));
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
        ),
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
        ChangeNotifierProvider<BadgeCololr>(create: (context) => BadgeCololr()),
        ChangeNotifierProvider<CartItem>(create: (context) => CartItem()),
        ChangeNotifierProvider<SavedAdd>(create: (context) => SavedAdd()),
      ],
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        theme: ThemeStyle,
        debugShowCheckedModeBanner: false,
        title: "Your Market",
        initialRoute: SplashScrren.id,
        routes: {
          WelcomeHome.id: (c) => WelcomeHome(),
          SplashScrren.id: (c) => SplashScrren(),
          pants.id: (c) => pants(),
          Cart.id: (c) => Cart(),
          ProductDetiels.id: (c) => ProductDetiels(),
          EditProductHome.id: (c) => EditProductHome(),
          AddProduct.id: (c) => AddProduct(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          EditAdmin.id: (context) => EditAdmin(),
          EditProduct.id: (context) => EditProduct(),
          HomeScreen.id: (context) => HomeScreen(),
          LoginScrren.id: (c) => LoginScrren(),
          SignupScreen.id: (context) => SignupScreen(),
          ConfirmaOrder.id: (context) => ConfirmaOrder(),
          AdderessDetiels.id: (context) => AdderessDetiels(),
          CompletOrdar.id: (context) => CompletOrdar(),
        },
      ),
    );
  }
}
