import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';

import 'User/view/Screens/Bottom_navigation/btm_navigation.dart';
import 'User/view/Screens/Home/home_page.dart';
import 'User/view/Screens/Home/notification_page.dart';
import 'User/view/Screens/Orders/E_receipt.dart';
import 'User/view/Screens/Orders/My_orders.dart';
import 'User/view/Screens/Orders/order_summary.dart';
import 'User/view/Screens/Orders/payment_successful.dart';
import 'User/view/Screens/Profile/profilepage.dart';
import 'User/view/Screens/Services/select_service.dart';
import 'User/view/Screens/Services/select_vendor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyOrdersPage(),
    );
  }
}


