import 'package:flutter/material.dart';
import '../Bottom_Navigation/Shop_nav.dart';
import 'available_drivers.dart';

void main() {
  runApp(MaterialApp(
    home: OrderAssignPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class OrderAssignPage extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      "name": "Arun",
      "phone": "8547 9658 2578",
      "orderId": "8547 9658 2578",
      "orderDate": "Jan 03, 2025",
      "amount": "350.00"
    },
    {
      "name": "Sandra",
      "phone": "8547 9658 2578",
      "orderId": "8547 9658 2578",
      "orderDate": "Jan 03, 2025",
      "amount": "350.00"
    },
    {
      "name": "Sachind",
      "phone": "8547 9658 2578",
      "orderId": "8547 9658 2578",
      "orderDate": "Jan 03, 2025",
      "amount": "350.00"
    },
    {
      "name": "Amal",
      "phone": "8547 9658 2578",
      "orderId": "8547 9658 2578",
      "orderDate": "Jan 03, 2025",
      "amount": "350.00"
    },
    {
      "name": "Manu",
      "phone": "8547 9658 2578",
      "orderId": "8547 9658 2578",
      "orderDate": "Jan 03, 2025",
      "amount": "350.00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Order Assign",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("All Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return _buildOrderCard(orders[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, String> order, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order["name"]!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text("Phone No:  ${order["phone"]}"),
          Text("Order ID:  ${order["orderId"]}"),
          Text("Order Date:  ${order["orderDate"]}"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount: ₹ ${order["amount"]}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AvailableDrivers()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const Text("Assign Driver",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
