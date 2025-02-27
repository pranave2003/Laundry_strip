import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> orders = [
    {
      "item": "Shirt",
      "pack": "Standard Pack",
      "service": "Dry Clean",
      "orderId": "8547 9658 2578",
      "date": "Jan 03, 2025",
      "status": "In Progress",
      "icon": "assets/Dress/shirt.png",
      "statusColor": Colors.orange.shade100,
      "textColor": Colors.orange,
    },
    {
      "item": "Jacket",
      "pack": "Standard Pack",
      "service": "Steam Iron",
      "orderId": "7541 9674 5789",
      "date": "Jan 08, 2025",
      "status": "Delivered",
      "icon": "assets/Dress/t-shirt.png",
      "statusColor": Colors.green.shade100,
      "textColor": Colors.green,
    },
    {
      "item": "Frock",
      "pack": "Standard Pack",
      "service": "Steam Iron",
      "orderId": "7541 9674 5789",
      "date": "Dec 03, 2024",
      "status": "Cancelled",
      "icon": "assets/Dress/frock.png",
      "statusColor": Colors.red.shade100,
      "textColor": Colors.red,
    },
    {
      "item": "Jacket",
      "pack": "Standard Pack",
      "service": "Steam Iron",
      "orderId": "7541 9674 5789",
      "date": "Jan 08, 2025",
      "status": "Delivered",
      "icon": "assets/Dress/shirt.png",
      "statusColor": Colors.green.shade100,
      "textColor": Colors.green,
    },
    {
      "item": "T-Shirt",
      "pack": "Standard Pack",
      "service": "Steam Iron",
      "orderId": "7541 9674 5789",
      "date": "Dec 03, 2024",
      "status": "Cancelled",
      "icon": "assets/Dress/flared_frock.png",
      "statusColor": Colors.red.shade100,
      "textColor": Colors.red,
    },
  ];

  List<String> filters = ["All", "In Progress", "Delivered", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(filters.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? Colors.blue
                            : Colors.grey.shade200,
                        foregroundColor: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(filters[index]),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          // Orders List
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                // Apply filter
                if (selectedIndex != 0 &&
                    filters[selectedIndex] != order["status"]) {
                  return const SizedBox.shrink();
                }

                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Order Card Widget
  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color:primary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Image.asset(order["icon"], width: 35, height: 35),
              ),
            ),
            const SizedBox(width: 12),
            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order["item"],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order["pack"],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "(${order["service"]})",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Order ID:  ${order["orderId"]}",
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  Text(
                    "Order Date:  ${order["date"]}",
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: order["statusColor"],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                order["status"],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: order["textColor"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
