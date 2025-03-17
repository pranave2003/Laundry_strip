import 'package:flutter/material.dart';
import '../../../../Widget/constands/colors.dart';
import '../Bottom_Navigation/Shop_nav.dart';
import '../Home/Shop_home.dart';
import 'View_shop.dart';

class Shop_Add extends StatefulWidget {
  @override
  _Shop_AddState createState() => _Shop_AddState();
}

class _Shop_AddState extends State<Shop_Add> {
  final List<Map<String, String>> services = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
    {"icon": "assets/icon/household_service.png", "name": "Household Service"},
  ];

  final List<String> categories = ["Men", "Women", "Kids", "Household"];

  final Map<String, List<Map<String, String>>> categoryProducts = {
    "Men": [
      {"icon": "assets/Dress/shirt.png", "name": "Shirt"},
      {"icon": "assets/Dress/t-shirt.png", "name": "T-Shirt"},
      {"icon": "assets/Dress/jacket.png", "name": "Jacket"},
    ],
    "Women": [
      {"icon": "assets/Dress/wmgown.png", "name": "Gown"},
      {"icon": "assets/Dress/wmtshirt.png", "name": "T-Shirt"},
    ],
    "Kids": [
      {"icon": "assets/Dress/frock.png", "name": "Frock"},
      {"icon": "assets/Dress/flared_frock.png", "name": "Flared Frock"},
    ],
    "Household": [
      {"icon": "assets/Dress/carpet.png", "name": "Carpet"},
      {"icon": "assets/Dress/curtain.png", "name": "Curtain"},
    ],
  };

  final Map<String, List<String>> materialTypes = {
    "Cloth Material": ["Cotton", "Wool", "Linen", "Silk"],
    "Shoe Material": ["Leather", "Denim", "Canvas"],
    "Bag Material": ["Leather", "Denim", "Canvas"],
  };

  final Map<String, List<String>> instructionTypes = {
    "Cloth Material": [
      "Wash Separately", "Machine Wash Cold", "Hand Wash",
      "Use Mild Detergent", "Do Not Bleach", "Do Not Wring",
      "Do not Tumble Dry", "Hang Dry in Shade", "Do not Soak"
    ],
    "Shoe Material": [
      "Cleaning", "Conditioning", "Polishing", "Deodorizing",
      "Odor Control", "Deep Cleaning", "Moisture Care", "Do not Soak"
    ],
    "Bag Material": [
      "Cleaning", "Conditioning", "Odor Control", "Deodorizing",
      "Prevent Stretching", "Strap Care", "Interior Protection", "Do not Soak"
    ],
  };


  String? selectedService;
  String? selectedCategory;
  String? selectedMaterial;
  List<String> selectedInstructions = [];
  Map<String, TextEditingController> productPrices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Shop"),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Shop_Navigation()));
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/shop_img/img3.png", height: 180),
            SizedBox(height: 10),
            Text("KneeKnits Laundry", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Laundry Capacity: 10 Kg "),
            Text("Owner: Arun"),
            Text("Address: 2609+988, Jalahalli Cross Rd, Peenya, Bengaluru, India"),
            SizedBox(height: 20),

            // Service Type Dropdown
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Service Type"),
              items: services.map((service) {
                return DropdownMenuItem(
                  value: service["name"],
                  child: Row(
                    children: [
                      Image.asset(service["icon"]!, width: 30, height: 30),
                      SizedBox(width: 10),
                      Text(service["name"]!),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedService = value as String?),
            ),
            SizedBox(height: 10),

            // Category Dropdown
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Category"),
              items: categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
              onChanged: (value) => setState(() => selectedCategory = value as String?),
            ),
            SizedBox(height: 10),

            if (selectedCategory != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Products:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 10,
                    children: categoryProducts[selectedCategory]!.map((product) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!productPrices.containsKey(product['name'])) {
                              productPrices[product['name']!] = TextEditingController();
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(product['icon']!, width: 50, height: 50),
                            Text(product['name']!, style: TextStyle(fontSize: 14))
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  if (productPrices.isNotEmpty)
                    Column(
                      children: productPrices.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: TextField(
                            controller: entry.value,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Price for ${entry.key}",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            SizedBox(height: 20),

            // Material Type Dropdown
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: "Material Type"),
              items: materialTypes.keys.map((material) => DropdownMenuItem(value: material, child: Text(material))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMaterial = value as String?;
                  selectedInstructions = [];
                });
              },
            ),
            //SizedBox(height: 5),

            // Special Instructions
            if (selectedMaterial != null)
              Wrap(
                spacing: 5,
                children: instructionTypes[selectedMaterial]!
                    .map((instruction) => ChoiceChip(
                  label: Text(instruction),
                  selected: selectedInstructions.contains(instruction),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedInstructions.add(instruction);
                      } else {
                        selectedInstructions.remove(instruction);
                      }
                    });
                  },
                ))
                    .toList(),
              ),
            SizedBox(height: 20),

            // Products


            // Special Offers Images
            Text("Special Offers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                  SizedBox(width: 10),
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                  SizedBox(width: 10),
                  Image.asset("assets/offer1.png", width: 100, height: 100),
                ],
              ),
            ),


            // Submit Button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {
                  Map<String, Map<String, String>> selectedProducts = {};
                  productPrices.forEach((key, controller) {
                    final product = categoryProducts[selectedCategory]!.firstWhere((p) => p['name'] == key);
                    selectedProducts[key] = {
                      "price": controller.text,
                      "icon": product["icon"] ?? "",
                    };
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewShop(
                        selectedService: selectedService ?? "Not selected",
                        selectedCategory: selectedCategory ?? "Not selected",
                        selectedMaterial: selectedMaterial ?? "Not selected",
                        selectedInstructions: selectedInstructions,
                        productDetails: selectedProducts,
                      ),
                    ),
                  );

                },

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Submit ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: defaultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
