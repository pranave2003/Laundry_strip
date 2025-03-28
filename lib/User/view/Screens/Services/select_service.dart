//Select a Service
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/User/view/Screens/Services/select_vendor.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Address/pickup_delivery.dart';
import 'Widgets/Aleartdailog.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  int selectedCategoryIndex = 0;
  List<Map<String, dynamic>> selectedItems = [];

  // List<Map<String, dynamic>> serviceList = [
  //   {"icon": "assets/icon/wash_fold.png", "name": "Wash +\nFold"},
  //   {"icon": "assets/icon/wash_iron.png", "name": "Wash +\nIron"},
  //   {"icon": "assets/icon/steam_iron.png", "name": "Steam \nIron"},
  //   {"icon": "assets/icon/dry_clean.png", "name": "Dry \nClean"},
  //   {"icon": "assets/icon/bag_service.png", "name": "Bag \nService"},
  //   {"icon": "assets/icon/shoe_service.png", "name": "Shoe \nService"},
  //   {
  //     "icon": "assets/icon/household_service.png",
  //     "name": "Household \nService"
  //   },
  //   {"icon": "assets/icon/stain_removal.png", "name": "Stain \nRemoval"},
  // ];

  List<String> categories = ["All", "Men", "Women", "Kids", "Household"];

  Map<String, List<Map<String, dynamic>>> categoryItems = {
    "All": [
      {
        "name": "Shirt Full Standard Pack",
        "price": 80,
        "icon": "assets/Dress/shirt.png"
      },
      {
        "name": "T-Shirt Full Standard Pack",
        "price": 100,
        "icon": "assets/Dress/t-shirt.png"
      },
      {
        "name": "Jacket Standard Pack",
        "price": 200,
        "icon": "assets/Dress/jacket.png"
      },
      {"name": "T-Shirt", "price": 150, "icon": "assets/Dress/wmtshirt.png"},
      {"name": "Gown", "price": 150, "icon": "assets/Dress/wmgown.png"},
      {
        "name": "Baby Clothes Pack",
        "price": 120,
        "icon": "assets/Dress/frock.png"
      },
      {"name": "Carpet", "price": 250, "icon": "assets/Dress/carpet.png"},
    ],
    "Men": [
      {
        "name": "Shirt Full Standard Pack",
        "price": 80,
        "icon": "assets/Dress/shirt.png"
      },
      {
        "name": "T-Shirt Full Standard Pack",
        "price": 100,
        "icon": "assets/Dress/t-shirt.png"
      },
      {
        "name": "Jacket Standard Pack",
        "price": 200,
        "icon": "assets/Dress/jacket.png"
      },
    ],
    "Women": [
      {"name": "T-Shirt", "price": 100, "icon": "assets/Dress/wmtshirt.png"},
      {"name": "Gown", "price": 150, "icon": "assets/Dress/wmgown.png"},
    ],
    "Kids": [
      {"name": "Frock", "price": 120, "icon": "assets/Dress/frock.png"},
      {
        "name": "Flared Frock",
        "price": 60,
        "icon": "assets/Dress/flared_frock.png"
      },
    ],
    "Household": [
      {"name": "Carpet", "price": 250, "icon": "assets/Dress/carpet.png"},
      {"name": "Curtains ", "price": 300, "icon": "assets/Dress/curtain.png"},
    ],
  };

  List<Map<String, dynamic>> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = List.from(categoryItems["All"]!);
  }

  void updateCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      displayedItems = List.from(categoryItems[categories[index]]!);
    });
  }

  void updateSelectedItems(Map<String, dynamic> item, {bool remove = false}) {
    setState(() {
      if (remove) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Select a Service",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Service()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
            //         icon: serviceList[index]["icon"].toString(),
            //         title: serviceList[index]["name"].toString());
            //   },
            // ),

            SizedBox(height: 10),
            _buildCategoryFilter(),
            SizedBox(height: 20),

            Expanded(
                child: buildServiceItemListShoe(
                    displayedItems, selectedItems, updateSelectedItems)),

            Expanded(
                child: buildAddedItemsSection(context, selectedItems,
                    updateSelectedItems)), // Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return BlocConsumer<AddproductBloc, AddproductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
    if (state is AddproductLoading) {
    return Center(child: Loading_Widget());
    } else if (state is addproductfail) {
    return Text(state.error.toString());
    } else if (state is AddproductLoaded) {
      if (state.product.isEmpty) {
        // Return "No data found" if txhe list is empty
        return Center(
          child: Text(
            "No data found",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(categories.length, (index) {
            return GestureDetector(
              onTap: () {
                updateCategory(index);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color:
                  selectedCategoryIndex == index ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: defaultColor),
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: selectedCategoryIndex == index
                        ? Colors.white
                        : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
    return SizedBox();
      },
    );
  }
}

Widget buildAddedItemsSection(BuildContext context,
    List<Map<String, dynamic>> selectedItems, Function updateSelectedItems) {
  return ListView(
    children: [
      ExpansionTile(
        title:
        Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
        children: selectedItems.map((item) {
          return ListTile(
            leading: Image.asset(item["icon"], width: 40, height: 40),
            title: Text(item["name"]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Service Type: ${item["serviceType"] ?? "N/A"}"),
                Text("Fabric: ${item["fabricType"] ?? "Not Selected"}"),
                Text("Instructions: ${item["instructions"] ?? "None"}"),
                Text("₹ ${item["price"]}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () {
                updateSelectedItems(item, remove: true);
              },
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 8),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultColor,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 140),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PickupDelivery()),
          );
        },
        child: Center(
          child: Text("Continue",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    ],
  );
}
