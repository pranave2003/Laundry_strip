import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

class AssignDriverPage extends StatelessWidget {
  final Map<String, String> selectedDriver;

  AssignDriverPage({required this.selectedDriver});

  final List<Map<String, String>> orders = [
    {"name": "Arun", "phone": "8547 9658 2578", "orderId": "8547 9658 2578", "orderDate": "Jan 03, 2025", "totalAmount": "₹ 350.00"},
    {"name": "Sandra", "phone": "8547 9658 2578", "orderId": "8547 9658 2578", "orderDate": "Jan 03, 2025", "totalAmount": "₹ 420.00"},
    {"name": "Sachind", "phone": "8547 9658 2578", "orderId": "8547 9658 2578", "orderDate": "Jan 03, 2025", "totalAmount": "₹ 250.00"},
    {"name": "Amal", "phone": "8547 9658 2578", "orderId": "8547 9658 2578", "orderDate": "Jan 03, 2025", "totalAmount": "₹ 310.00"},
    {"name": "Manu", "phone": "8547 9658 2578", "orderId": "8547 9658 2578", "orderDate": "Jan 03, 2025", "totalAmount": "₹ 275.00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Assign Order to ${selectedDriver["name"]}",
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select an Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return _buildOrderCard(context, orders[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, String> order) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order["name"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Phone No:  ${order["phone"]}"),
          Text("Order ID:  ${order["orderId"]}"),
          Text("Order Date:  ${order["orderDate"]}"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(order["totalAmount"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Handle Order Assignment Logic Here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Secondary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text("Assign to ${selectedDriver["name"]}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
