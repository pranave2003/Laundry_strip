import 'package:flutter/material.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import 'Widgets/Aleartdailog.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  int selectedCategoryIndex = 0;
  List<Map<String, dynamic>> selectedItems = [];

  List<Map<String, dynamic>> serviceList = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash +\nFold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash +\nIron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam \nIron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry \nClean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag \nService"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe \nService"},
    {
      "icon": "assets/icon/household_service.png",
      "name": "Household \nService"
    },
    {"icon": "assets/icon/stain_removal.png", "name": "Stain \nRemoval"},
  ];

  List<String> categories = ["All", "Men", "Women", "Kids", "Household"];

  // Master list of service items for each category
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
    displayedItems = List.from(categoryItems["All"]!); // Show "All" by default
  }

  // Function to update the displayed items when category is selected
  void updateCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      displayedItems = List.from(categoryItems[categories[index]]!);
    });
  }

  // Function to update selected items (add or remove)
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Select a Service",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service List (Grid view)
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  mainAxisExtent: 130,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.0,
                  crossAxisCount: 4),
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                return WashFold(
                    icon: serviceList[index]["icon"].toString(),
                    title: serviceList[index]["name"].toString());
              },
            ),

            SizedBox(height: 10),

            // Category Filter (All, Men, Women, Kids, Household)
            _buildCategoryFilter(),

            SizedBox(height: 20),

            // Service Item List with "Add" Button
            Expanded(
                child: buildServiceItemList(
                    displayedItems, selectedItems, updateSelectedItems)),

            // Added Items Section
            Expanded(
                child:
                    buildAddedItemsSection(selectedItems, updateSelectedItems)),

          ],
        ),
      ),
    );
  }

  /// Category Filter (All, Men, Women, Kids, Household)
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
                border: Border.all(color: Colors.blue),
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

/// Added Items Section with "Continue" Button
Widget buildAddedItemsSection(
    List<Map<String, dynamic>> selectedItems, Function updateSelectedItems) {
  return ListView(
    children: [
      ExpansionTile(
        title: Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
        children: selectedItems.map((item) {
          return ListTile(
            leading: Image.asset(item["icon"], width: 40, height: 40), // Product image
            title: Text(item["name"]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Service Type: ${item["serviceType"] ?? "N/A"}"), // Service type
                Text("Fabric: ${item["fabricType"] ?? "Not Selected"}"), // Fabric Type
                Text("Instructions: ${item["instructions"] ?? "None"}"), // Special Instructions
                Text("₹ ${item["price"]}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), // Price
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
      SizedBox(height: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultColor,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 140),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          // Action for continue button
        },
        child: Center(
            child: Text("Continue",
                style: TextStyle(color: Colors.white, fontSize: 20))),
      ),
    ],
  );
}
