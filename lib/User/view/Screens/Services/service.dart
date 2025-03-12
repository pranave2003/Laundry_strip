import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Home/home_page.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Bottom_navigation/btm_navigation.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
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
      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,


      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GridView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   padding: EdgeInsets.all(10),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     mainAxisSpacing: 0,
            //     mainAxisExtent: 130,
            //     crossAxisSpacing: 15,
            //     childAspectRatio: 1.0,
            //     crossAxisCount: 4,
            //   ),
            //   itemCount: serviceList.length,
            //   itemBuilder: (context, index) {
            //     return WashFold(
            //       icon: serviceList[index]["icon"].toString(),
            //       title: serviceList[index]["name"].toString(),
            //     );
            //   },
            // ),

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
                return InkWell(
                  onTap: () {
                    print("Navigating to SelectService..."); // Debugging log
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectService()),
                    );
                  },
                  child: WashFold(
                    icon: serviceList[index]["icon"].toString(),
                    title: serviceList[index]["name"].toString(),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Near by Service Provider",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All",
                      style: TextStyle(color: Color(0xFF479CC9)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                index == 0
                                    ? "assets/shop_img/img.png"
                                    : "assets/shop_img/img2.png",
                                width: 179,
                                height: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow, size: 14),
                                    Text(
                                      index == 0 ? "4.8" : "3.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          index == 0 ? "Pure Press Laundry" : "NeatKnits Laundry",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Service Provider",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All",
                      style: TextStyle(color: Color(0xFF479CC9)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                index == 0
                                    ? "assets/shop_img/img2.png"
                                    : "assets/shop_img/img.png",
                                width: 179,
                                height: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow, size: 14),
                                    Text(
                                      index == 0 ? "4.5" : "4.2",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          index == 0 ? "Pure Press Laundry" : "NeatKnits Laundry",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
