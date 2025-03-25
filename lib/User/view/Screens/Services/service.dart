import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  int? selectedIndex = 0; // Stores the index of the selected service
  String? selectedService; // Stores the name of the selected service

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
            // Service Grid
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                mainAxisExtent: 130,
                crossAxisSpacing: 15,
                crossAxisCount: 4,
              ),
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedService = serviceList[index]["name"];
                      print(selectedService);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.grey : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          serviceList[index]["icon"].toString(),
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 5),
                        Text(
                          serviceList[index]["name"].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Secondary : Colors.black,
                          ),
                        ),
                      ],
                    ),
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
                    "Nearby Service Providers",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            // Nearby Service Provider List
            BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ShopLoading) {
                  return Center(child: Loading_Widget());
                } else if (state is Shopfailerror) {
                  return Text(state.error.toString());
                } else if (state is Shoploaded) {
                  if (state.Shop.isEmpty) {
// Return "No data found" if txhe list is empty
                    return Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: state.Shop.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: selectedService == "Wash +\nFold"
                                ? Colors.white
                                : Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectService(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          child: Image.asset(
                                            "assets/shop_img/img.png",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("Provider Name"),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            "Address example, City, Zip Code",
                                          ),
                                        ),
                                        Text("Additional Info"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              }

            ),
          ],
        ),
      ),
    );
  }
}
