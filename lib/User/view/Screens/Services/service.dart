import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Admin/Model/User_Model/user_model.dart';
import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';

class Userservice extends StatefulWidget {
  const Userservice({super.key});

  @override
  State<Userservice> createState() => _UserserviceState();
}

class _UserserviceState extends State<Userservice> {
  int? selectedIndex = 0; // Stores the index of the selected service
  String? selectedService; // Stores the name of the selected service
  bool isChecked = false;

  List<Map<String, dynamic>> serviceList = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/household_service.png", "name": "Household Service"},
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
                      final state = context.read<AuthBloc>().state;

                      if (state is UserByidLoaded) {
                        final userData = state.Userdata;

                        context.read<ShopAuthblocBloc>().add(UserFetchShop(
                            searchQuery: null,
                            service: selectedService,
                            status: "1",
                            userpost: userData.pin,
                            nearbypost: isChecked ? "1" : "0"));
                      }
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
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ],
                )),

            // Nearby Service Provider List
            BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
                listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is ShopLoading) {
                return Center(child: Loading_Widget());
              } else if (state is Shopfailerror) {
                return Text(state.error.toString());
              } else if (state is Shoploaded) {
                if (state.Shop.isEmpty) {
                  return Center(
                    child: Text(
                      "No data found",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: state.Shop.length,
                    itemBuilder: (context, index) {
                      final Shop = state.Shop[index];
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
                                        MaterialPageRoute(builder: (context) {
                                          return SelectService(Shop);
                                        }),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            12), // Rounded corners for image
                                        child: CachedNetworkImage(
                                          imageUrl: Shop.ShopImage.toString(),
                                          width: 130, // Adjusted width
                                          height: 100, // Adjusted height
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 100,
                                            height: 100,
                                            color: Colors.grey[
                                                300], // Placeholder background
                                            child: Center(
                                              child:
                                                  Loading_Widget(), // Loading indicator
                                            ),
                                          ),
                                          errorWidget:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: 130,
                                              height: 100,
                                              color: Colors.grey[
                                                  300], // Placeholder background
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: 50,
                                                color: Colors.grey[600],
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(10),
                                      //   child: Image.asset(
                                      //     "assets/shop_img/img.png",
                                      //     width: 100,
                                      //     height: 100,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Shop.shop_name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        Shop.shopid.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          "${Shop.District}, ${Shop.city}, ${Shop.post}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Shop.selectServices != null &&
                                                Shop.selectServices!.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  Shop.selectServices!.length,
                                                  (index) => Text(
                                                    Shop.selectServices![index],
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ), // Display each service
                                                ),
                                              )
                                            : Text(
                                                "No Services Available"), // Show message if list is empty
                                      ),
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
            }),
          ],
        ),
      ),
    );
  }
}
