import 'package:flutter/material.dart';
import 'package:laundry/Controller/bloc/Orderbloc/OrderModel/Order_Model.dart';
import 'package:laundry/Widget/constands/colors.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.order});
  final OrderModel order;
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String orderStatus = "In Progress"; // Default status

  // Function to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green[100]!; // Light green
      case "Cancelled":
        return Colors.red[100]!; // Light red
      default:
        return Colors.orange[100]!; // Light orange for "In Progress"
    }
  }

  Color _getTextColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Orders()),
            // );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Amal",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text("Phone No: 8962147896",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text(
                        "Address: 2GQ9+988, Jalahalli Cross Rd, Peenya, Bengaluru, Karnataka 560058, India",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(orderStatus),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          color: _getTextColor(orderStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/driver1.png"), // Change as needed
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Order Details
            const Text("Services: Wash+Fold, Dry Clean",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            const Text("Order ID: 8547 9658 2578",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            const Text("Order Date: Jan 03, 2025",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            const Text("Expected Delivery Date: Jan 07, 2025",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            const Text(
              "Total Amount: ₹ 350.00",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Items List
            const Text("Items Added:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Item 1
            Row(
              children: [
                Image.asset("assets/Dress/shirt.png", width: 40), // Adjust path
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shirt Standard Pack", style: TextStyle(fontSize: 16)),
                    Text("(Dry Clean) ₹ 150",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Item 2
            Row(
              children: [
                Image.asset("assets/Dress/shirt.png", width: 40), // Adjust path
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jacket Standard Pack",
                        style: TextStyle(fontSize: 16)),
                    Text("(Wash + Fold) ₹ 200",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Order Status Dropdown
            Row(
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: orderStatus,
                  items: ["In Progress", "Delivered", "Cancelled"]
                      .map((String status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(
                        status,
                        style: TextStyle(
                          fontWeight: status == "In Progress"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newStatus) {
                    setState(() {
                      orderStatus = newStatus!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Orders()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: defaultColor,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
