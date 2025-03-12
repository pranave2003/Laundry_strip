
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Auth/Shop_SignUp.dart';
import 'package:laundry/Shop/view/Screens/Home/Shop_home.dart';
import 'package:laundry/User/view/Screens/Services/bag_service.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';
import 'package:laundry/User/view/Screens/Splash/splash_screen.dart';

import 'Shop/view/Screens/Driver/delivery.dart';
import 'Shop/view/Screens/Orders/order_details.dart';
import 'Shop/view/Screens/Shop/Add_shop.dart';
import 'Shop/view/Screens/Splash/shop_splash.dart';
import 'User/view/Screens/Bottom_navigation/btm_navigation.dart';
import 'User/view/Screens/Home/home_page.dart';
import 'User/view/Screens/Services/select_service.dart';
import 'User/view/Screens/Services/shoe_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Shop_Splash());
  }
}
