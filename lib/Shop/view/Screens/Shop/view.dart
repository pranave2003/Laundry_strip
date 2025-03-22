import 'package:flutter/material.dart';

import 'Add_shop.dart';

// void main() {
//   runApp(LaundryApp());
// }

class LaundryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaundryView(),
    );
  }
}

class LaundryView extends StatelessWidget {
  // Service Types
  final List<Map<String, String>> serviceTypes = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
    {"icon": "assets/icon/household_service.png", "name": "Household Service"},
  ];

  // Categories
  final List<String> categories = ["Men","Women","Kids","Household"];

  // Material Types
  final Map<String, List<String>> materialTypes = {
    "Cloth Material": ["Cotton", "Silk", "Linen", "Wool", "Denim"],
    "Shoes Material": ["Leather", "Canvas", "Suede", "Mesh", "Synthetic"],
    "Bag Material": ["Leather", "Nylon", "Polyester", "Canvas", "Jute"],
  };

  // Instruction Types
  final Map<String, List<String>> instructionTypes = {
    "Cloth Instructions": [
      "Wash Separately",
      "Machine Wash Cold",
      "Hand Wash",
      "Use Mild Detergent",
      "Do Not Bleach",
    ],
    "Shoes Instructions": [
      "Remove Laces Before Washing",
      "Use Mild Soap",
      "Hand Wash Only",
      "Do Not Soak in Water",
    ],
    "Bag Instructions": [
      "Wipe with Damp Cloth",
      "Do Not Wash in Machine",
      "Use Leather Cleaner for Leather Bags",
    ],
  };

  // Products & Prices
  final Map<String, List<Map<String, String>>> products = {
    "Men": [
      {"icon": "assets/Dress/shirt.png", "name": "Shirt", "price": "₹50"},
      {"icon": "assets/Dress/t-shirt.png", "name": "T-Shirt", "price": "₹60"},
      {"icon": "assets/Dress/jacket.png", "name": "Jacket", "price": "₹65"},
    ],
    "Women": [
      {"icon": "assets/Dress/wmgown.png", "name": "Gown", "price": "₹80"},
      {"icon": "assets/Dress/wmtshirt.png", "name": "T-Shirt", "price": "₹55"},
    ],
    "Kids": [
      {"icon": "assets/Dress/frock.png", "name": "Frock", "price": "₹40"},
      {"icon": "assets/Dress/flared_frock.png", "name": "Flared Frock", "price": "₹45"},
    ],
    "Household": [
      {"icon": "assets/Dress/carpet.png", "name": "Carpet", "price": "₹200"},
      {"icon": "assets/Dress/curtain.png", "name": "Curtain", "price": "₹100"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        backgroundColor: null,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            icon: Icon(Icons.add),  // ➕ Add Button
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shop_Add()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),  // 🖊️ Edit Button
            onPressed: () {
              // TODO: Add logic for editing items
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Edit button clicked")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image & Shop Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://t3.ftcdn.net/jpg/04/44/84/96/360_F_444849699_egr1i6ghKxphlqUG6VBRKnFi4UtFHYvp.jpg",
                      height: 200,

                      width: 700,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("KneeKnits Laundry",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16),

              // Address & Details
              Text("Laundry Capacity: 10 Kg", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Owner: Arun"),
              Text("Address: 2609+988, Jalahalli Cross Rd, Peenya, Bengaluru, India"),
              SizedBox(height: 16),

              // Service Types
              buildSection("Service Types", serviceTypes.map((service) {
                return ListTile(
                  leading: Image.asset(service["icon"]!, height: 40),
                  title: Text(service["name"]!),
                );
              }).toList()),

              // Categories
              Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0), // Proper indentation
                    child: Text("• $category", style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),


              // Material Types
              buildListSection("Material Types", materialTypes),

              // Instruction Types
              buildListSection("Instruction Types", instructionTypes),

              // Products & Prices
              buildSection("Products & Prices", products.keys.map((type) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Column(
                      children: products[type]!.map((product) {
                        return ListTile(
                          leading: Image.asset(product["icon"]!, height: 40),
                          title: Text(product["name"]!),
                          trailing: Text(product["price"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }).toList()),

              // Special Offers
              Text("Special Offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(children: children),
        SizedBox(height: 16),
      ],
    );
  }


  Widget buildListSection(String title, Map<String, List<String>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.keys.map((type) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0), // Indent slightly
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0), // Further indent bullet points
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data[type]!
                          .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text("• $item", style: TextStyle(fontSize: 14)),
                      ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

}
