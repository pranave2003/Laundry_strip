import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Auth/Shop_SignUp.dart';
import 'package:laundry/Shop/view/Screens/Home/Shop_home.dart';
import 'package:laundry/User/view/Screens/Services/bag_service.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';
import 'package:laundry/User/view/Screens/Splash/splash_screen.dart';

import 'Admin/View/Screens/Auth/Admin_login.dart';
import 'Shop/view/Screens/Bottom_Navigation/Shop_nav.dart';
import 'Shop/view/Screens/Driver/delivery.dart';
import 'Shop/view/Screens/Orders/order_details.dart';
import 'Shop/view/Screens/Shop/Add_shop.dart';
import 'Shop/view/Screens/Shop/S_view.dart';
import 'Shop/view/Screens/Splash/shop_splash.dart';
import 'User/view/Screens/Address/pickup_delivery.dart';
import 'User/view/Screens/Bottom_navigation/btm_navigation.dart';
import 'User/view/Screens/Home/home_page.dart';
import 'User/view/Screens/Services/select_service.dart';
import 'User/view/Screens/Services/shoe_service.dart';
import 'User/view/Screens/auth/ResetPasswordUser.dart';

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
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
