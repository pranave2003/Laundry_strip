import 'package:flutter/material.dart';
import '../Bottom_Navigation/Shop_nav.dart';

class ViewShop extends StatelessWidget {
  final String shopName = "KneeKnits Laundry";
  final String laundryCapacity = "10 Kg";
  final String owner = "Arun";
  final String address = "2609+988, Jalahalli Cross Rd, Peenya, Bengaluru, India";

  final String? selectedService;
  final String? selectedCategory;
  final String? selectedMaterial;
  final List<String> selectedInstructions;
  final Map<String, Map<String, String>> productDetails;

  ViewShop({
    required this.selectedService,
    required this.selectedCategory,
    required this.selectedMaterial,
    required this.selectedInstructions,
    required this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("View Shop"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Shop_Navigation()));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop Image
            _buildImage("assets/shop_img/img3.png", 180),

            SizedBox(height: 10),
            Text(shopName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Laundry Capacity: $laundryCapacity"),
            Text("Owner: $owner"),
            Text("Address: $address"),
            SizedBox(height: 20),

            _buildInfoTile("Service Type", selectedService),
            _buildInfoTile("Category", selectedCategory),
            _buildInfoTile("Material Type", selectedMaterial),

            if (selectedInstructions.isNotEmpty) _buildInstructions(),

            if (productDetails.isNotEmpty) _buildProductDetails(),

            // Special Offers Images
            Text("Special Offers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildImage("assets/offer1.png", 100),
                  SizedBox(width: 10),
                  _buildImage("assets/offer2.png", 100),
                  SizedBox(width: 10),
                  _buildImage("assets/offer3.png", 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single information tile
  Widget _buildInfoTile(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text("$title: ${value ?? "Not selected"}", style: TextStyle(fontSize: 16)),
    );
  }

  /// Builds the special instructions section
  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Special Instructions:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...selectedInstructions.map((instruction) => Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("- $instruction"),
        )),
        SizedBox(height: 10),
      ],
    );
  }

  /// Builds the product details section with images and prices
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Products and Prices:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...productDetails.entries.map((entry) => Row(
          children: [
            _buildImage(entry.value["icon"] ?? "", 50),
            SizedBox(width: 10),
            Text("${entry.key}: ₹${entry.value["price"]}"),
          ],
        )),
        SizedBox(height: 20),
      ],
    );
  }

  /// Builds an image widget with error handling
  Widget _buildImage(String imagePath, double size) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            Icon(Icons.image_not_supported, size: size * 0.5, color: Colors.grey),
            Text("Image not found", style: TextStyle(fontSize: 12, color: Colors.red)),
          ],
        );
      },
    );
  }
}
