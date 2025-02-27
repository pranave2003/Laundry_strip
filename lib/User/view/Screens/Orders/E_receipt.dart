import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

class EReceiptPage extends StatelessWidget {
  const EReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "E - Receipt",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // QR Code (from assets)
            Center(
              child: Image.asset(
                "assets/receipt_qrcode.png", // Ensure this path is correct
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(height: 16),
            // Booking and Delivery Dates
            _buildDateRow("Booking Date", "Jan 03, 2025 | 09:10 AM"),
            _buildDateRow("Pickup Date & Time", "Jan 08, 2025 | 10:00 AM"),
            _buildDateRow("Delivery Date & Time", "Jan 14, 2025 | 09:00 AM"),
            const Divider(height: 20, thickness: 1),
            // Total Charges
            _buildChargeRow("Wash + Fold", "₹ 150.00"),
            _buildChargeRow("Dry Clean", "₹ 200.00"),
            _buildChargeRow("Tax & Fees", "₹ 10.00"),
            //const Divider(height: 20, thickness: 1),

            // Larger & Bold "Total" and Amount
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ 360.00",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Divider(height: 20, thickness: 1),
            // Transaction Details
            _buildTransactionRow("Transaction Id", "TR45678899JT"),
            _buildTransactionRow("Date", "8 Jan 2025, 9:00 AM"),
            _buildTransactionRow("Payment Method", "Online Payment"),
            const SizedBox(height: 140),
            // Download E-Receipt Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle download action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: defaultColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Download E - Receipt",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for date rows
  Widget _buildDateRow(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87, fontSize: 15)),
          Text(date, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
        ],
      ),
    );
  }

  // Widget for charge rows
  Widget _buildChargeRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          Text(amount, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  // Widget for transaction details
  Widget _buildTransactionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
