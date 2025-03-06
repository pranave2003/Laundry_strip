import 'package:flutter/material.dart';

class OrderTracking extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderTracking({super.key, required this.order});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Tracking",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            Text(
              "Order ID: ${order["orderId"]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Estimated Delivery
            Row(
              children: [
                const Icon(Icons.local_shipping, color: Color(0xFF3582C3)),
                const SizedBox(width: 8),
                Text(
                  "Estimated Delivery: ${order["date"]}",
                  style: const TextStyle(color: Color(0xFF3582C3), fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            // Order Items
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Display ordered item
            _buildOrderItem(order["service"], "₹ 200.00"), // Example price

            const Divider(),

            // Order Status
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Status:",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: order["statusColor"],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order["status"],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: order["textColor"]),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Total Amount
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ 200.00", // Example total amount, you can update it dynamically
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),

            const Divider(),
            const SizedBox(height: 12),
            // Tracking Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tracking Order",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Refresh tracking logic
                  },
                  child: Text(
                    "Refresh",
                    style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tracking Steps
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTrackingStep("Order Confirmed", "Your order is confirmed",
                        Icons.inventory_2, order["status"] == "In Progress" ? Colors.blue : Colors.grey),
                    _buildTrackingStep("Parcel Picked", "Your order is picked",
                        Icons.local_shipping, order["status"] == "Delivered" ? Colors.green : Colors.grey),
                    _buildTrackingStep("In Progress", "Your order is in progress",
                        Icons.local_laundry_service_outlined, order["status"] == "In Progress" ? Colors.orange : Colors.grey),
                    _buildTrackingStep("Delivered",
                        "Your order is successfully delivered", Icons.check_circle, order["status"] == "Delivered" ? Colors.green : Colors.grey, false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Order Item Widget
  Widget _buildOrderItem(String itemName, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(itemName, style: const TextStyle(fontSize: 14)),
          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              //const Icon(Icons.delete, color: Colors.red, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  // Tracking Step Widget
  Widget _buildTrackingStep(String title, String subtitle, IconData icon, Color color, [bool showLine = true]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: color, size: 24),
              if (showLine)
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
