import 'package:flutter/material.dart';

class ShopDetailsDialog extends StatelessWidget {
  final String shopName;
  final String laundryCapacity;
  final String address;
  final String email;
  final String phone;

  ShopDetailsDialog({
    required this.shopName,
    required this.laundryCapacity,
    required this.address,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Shop Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),

              // Shop Details Table
              Table(
                border: TableBorder.all(color: Colors.black12),
                columnWidths: {0: FixedColumnWidth(180)},
                children: [
                  _buildTableRow("Shop Name", Text(shopName)),
                  _buildTableRow(
                    "Shop Image",
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/shop_img/img2.png",
                          height: 250,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  _buildTableRow("Laundry Capacity", Text(laundryCapacity)),
                  _buildTableRow("Address", Text(address)),
                  _buildTableRow("Email", Text(email)),
                  _buildTableRow("Phone", Text(phone)),
                  _buildTableRow("Service Types", _buildButton(context, "View Services", _showServicesDialog)),
                  _buildTableRow("Category", _buildButton(context, "View Categories", _showCategoriesDialog)),
                  _buildTableRow("Product Details", _buildButton(context, "View Products", _showProductsDialog)),
                  _buildTableRow("Material Types", _buildButton(context, "View Materials", _showMaterialsDialog)),
                  _buildTableRow("Special Instructions", _buildButton(context, "View Instructions", _showInstructionsDialog)),
                ],
              ),
              SizedBox(height: 15),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, Widget content) {
    return TableRow(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: content),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String title, Function(BuildContext) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: Text(title),
    );
  }

  // ==================== DIALOG FUNCTIONS ====================

  void _showServicesDialog(BuildContext context) {
    _showDetailsDialog(
      context,
      "Service Types",
      [
        {"name": "Wash + Fold", "icon": "assets/icon/wash_fold.png"},
        {"name": "Wash + Iron", "icon": "assets/icon/wash_iron.png"},
        {"name": "Steam Iron", "icon": "assets/icon/steam_iron.png"},
        {"name": "Household", "icon": "assets/icon/household_service.png"},
        {"name": "Dry Clean", "icon": "assets/icon/dry_clean.png"},
        {"name": "Stain Removal", "icon": "assets/icon/stain_removal.png"},
        {"name": "Shoes Service", "icon": "assets/icon/shoe_service.png"},
        {"name": "Bag Service", "icon": "assets/icon/bag_service.png"},
      ],
    );
  }

  void _showCategoriesDialog(BuildContext context) {
    _showDetailsDialog(
      context,
      "Categories",
      [
        {"name": "Men"},
        {"name": "Women"},
        {"name": "Kids"},
        {"name": "Household"},
      ],
    );
  }

  void _showProductsDialog(BuildContext context) {
    _showDetailsDialog(
      context,
      "Product Details",
      [
        {"name": "Shirt", "price": 24.5, "image": "assets/Dress/shirt.png"},
        {"name": "T-Shirt", "price": 4, "image": "assets/Dress/t-shirt.png"},
      ],
    );
  }

  void _showMaterialsDialog(BuildContext context) {
    _showNestedDetailsDialog(
      context,
      "Material Types",
      {
        "Shoes Material": ["Leather", "Synthetic", "Canvas"],
        "Bag Material": ["Nylon", "Polyester", "Leather"],
        "Cloth Material": ["Cotton", "Silk", "Wool"],
      },
    );
  }

  void _showInstructionsDialog(BuildContext context) {
    _showNestedDetailsDialog(
      context,
      "Special Instructions",
      {
        "Bag Instructions": ["Do not machine wash", "Air dry only"],
        "Shoes Instructions": ["Use soft brush", "Avoid water"],
        "Cloth Instructions": ["Wash in cold water", "Iron at low heat"],
      },
    );
  }

  // ==================== ALERT BOX HELPER FUNCTIONS ====================

  void _showDetailsDialog(BuildContext context, String title, List<Map<String, dynamic>> details) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              children: details.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.containsKey("image") || item.containsKey("icon")) // Show image if available
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              item["image"] ?? item["icon"], // Use `image` for products, `icon` for services
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                            if (item.containsKey("price")) Text("Price: \$${item["price"]}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }


  void _showNestedDetailsDialog(BuildContext context, String title, Map<String, List<String>> categories) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              children: categories.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ...entry.value.map((item) => Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text("• $item"),
                    )),
                    SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
