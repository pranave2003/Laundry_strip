import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Profile/shop_profile.dart';
import 'dart:async';

import '../../../../User/view/Screens/Home/notification_page.dart';
import '../../../../Widget/constands/colors.dart';
import '../Profile/driver_profile.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset(
          "assets/splash_logo.png",
          width: 80,
          height: 80,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to,",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            Text(
              "Laundry Mate",
              style: TextStyle(
                fontSize: 25,
                color: defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverProfilewrapper(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person),
              ),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Slider


              // Total Earnings Section

              const SizedBox(height: 100),
              Center(
                child: Image.asset(
                  "assets/driverhome.png",
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
