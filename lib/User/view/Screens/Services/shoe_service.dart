import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import 'package:laundry/User/view/Screens/Services/service.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import 'Widgets/AleartdailogShoe.dart';

class ShoeService extends StatefulWidget {
  const ShoeService({super.key});

  @override
  State<ShoeService> createState() => _ShoeServiceState();
}

class _ShoeServiceState extends State<ShoeService> {
  int selectedCategoryIndex = 0;
  List<Map<String, dynamic>> selectedItems = [];

  List<Map<String, dynamic>> serviceList = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash +\nFold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash +\nIron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam \nIron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry \nClean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag \nService"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe \nService"},
    {"icon": "assets/icon/household_service.png", "name": "Household \nService"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain \nRemoval"},
  ];

  List<String> categories = ["All", "Sneakers", "Leather Shoes", "Boots"];

  Map<String, List<Map<String, dynamic>>> categoryItems = {
    "All": [
      {"name": "Sneakers", "price": 250, "icon": "assets/Dress/sneaker.jpg"},
      {"name": "Leather Shoes", "price": 300, "icon": "assets/Dress/sh.jpg"},
      {"name": "Boots", "price": 350, "icon": "assets/Dress/boot_heels.jpg"},
    ],
    "Sneakers": [
      {"name": "Sneakers", "price": 250, "icon": "assets/Dress/sneaker.jpg"},
    ],
    "Leather Shoes": [
      {"name": "Heels", "price": 250, "icon": "assets/Dress/sh.jpg"},
    ],
    "Boots": [
      {"name": "Boot Heels", "price": 350, "icon": "assets/Dress/boot_heels.jpg"},
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

  void updateSelectedItemsShoe(Map<String, dynamic> item, {bool remove = false}) {
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
          "Shoe Service",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                    title: serviceList[index]["name"].toString());
              },
            ),
            SizedBox(height: 10),
            _buildCategoryFilter(),
            SizedBox(height: 20),
            Expanded(
                child: buildServiceItemListShoe(
                    displayedItems, selectedItems, updateSelectedItemsShoe)),
            Expanded(
                child: buildAddedItemsSection(
                    context, selectedItems, updateSelectedItemsShoe)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
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
}
