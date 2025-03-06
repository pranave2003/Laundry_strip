import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Orders/payment_successful.dart';

import '../../../../Widget/constands/colors.dart';
import 'E_receipt.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: const Text(
          "Order Summary",
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
            // Laundry Shop Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/shop_img/img.png", // Change this to your actual image path
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pure Press Laundry",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.local_laundry_service, size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          const Text("Laundry", style: TextStyle(color: Colors.black)),
                          const SizedBox(width: 10),
                          const Icon(Icons.star, color: Colors.yellow, size: 16),
                          const Text(" 4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.blue),
                          const Text(" 0.8 km"),
                          const SizedBox(width: 10),
                          const Icon(Icons.timer, size: 16, color: Colors.blue),
                          const Text(" 5 Mins"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Booking and Delivery Dates
            _buildDateRow("Booking Date", "Jan 03, 2025 | 09:10 AM"),
            _buildDateRow("Pickup Date & Time", "Jan 08, 2025 | 10:00 AM"),
            _buildDateRow("Delivery Date & Time", "Jan 14, 2025 | 09:00 AM"),
            const Divider(height: 20, thickness: 1),
            // Added Items
            const Text("Added items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildAddedItem("Dry Clean", "₹ 200.00"),
            _buildAddedItem("Dry Clean", "₹ 200.00"),
            const Divider(height: 20, thickness: 1),
            // Total Charges
            const Text("Total Charges", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildChargeRow("Wash + Fold", "₹ 150.00"),
            _buildChargeRow("Dry Clean (2)", "₹ 200.00"),
            _buildChargeRow("Delivery Charges", "₹ 30.00"),
            _buildChargeRow("Tax & Fees", "₹ 10.00"),
            const Divider(height: 20, thickness: 1),
            _buildChargeRow("Total", "₹ 360.00", isBold: true),
            const SizedBox(height: 80),
            // Complete Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentSuccessful()), // Replace with your destination page
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: defaultColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Complete Payment",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for booking/delivery details
  Widget _buildDateRow(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  // Widget for added items
  Widget _buildAddedItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 14)),
          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Handle delete action
                },
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for total charges row
  Widget _buildChargeRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
