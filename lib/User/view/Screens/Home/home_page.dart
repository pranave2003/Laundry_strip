import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = ["user_offer.png", "offer1.png", "c2.jpg", "c2.jpg"];
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentIndex + 1) % images.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  List<Map<String, dynamic>> serviceList = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash +\nFold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash +\nIron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam\nIron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry\nClean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag\nServices"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/household_service.png", "name": "Household Services"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        leading: Image.asset(
          "assets/splash_logo.png",
          width: 80,
          height: 80,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to,", style: TextStyle(fontSize: 15, color: Colors.black)),
            Text(
              "Laundry Mate",
              style: TextStyle(fontSize: 25, color: defaultColor, fontWeight: FontWeight.bold),
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
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },

              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.notification_add),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Image Slider
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/${images[index]}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Indicator (Blue Dots)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      height: 10,
                      width: currentIndex == index ? 30 : 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: currentIndex == index ? Colors.blueAccent : Colors.black.withOpacity(0.4),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  mainAxisExtent: 130,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.0,
                  crossAxisCount: 4,
                ),
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  return WashFold(
                    icon: serviceList[index]["icon"].toString(),
                    title: serviceList[index]["name"].toString(),
                  );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Popular Service Provider",
              //         style: TextStyle(
              //             color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              //       ),
              //       TextButton(
              //         onPressed: () {},
              //         child: Text("See All", style: TextStyle(color: Color(0xFF479CC9))),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 2,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //         child: Column(
              //           children: [
              //             Stack(
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(10),
              //                   child: Image.asset(
              //                     index == 0
              //                         ? "assets/shop_img/img.png"
              //                         : "assets/shop_img/img2.png",
              //                     width: 175,
              //                     height: 175,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 Positioned(
              //                   top: 5,
              //                   left: 5,
              //                   child: Container(
              //                     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              //                     decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.circular(5),
              //                     ),
              //                     child: Row(
              //                       children: [
              //                         Icon(Icons.star, color: Colors.yellow, size: 14),
              //                         Text(
              //                           index == 0 ? "4.8" : "3.5",
              //                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              //                         ),
              //
              //                       ],
              //
              //                     ),
              //
              //                   ),
              //
              //                 ),
              //               ],
              //             ),SizedBox(height: 5),
              //             Text(
              //               index == 0 ? "Pure Press Laundry" : "NeatKnits Laundry",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}