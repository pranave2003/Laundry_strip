import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Orderhistory extends StatelessWidget {
  const Orderhistory(
      {super.key,
      required this.orderId,
      required this.totalitems,
      required this.username});
  final orderId;
  final totalitems;
  final username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Order History",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code

            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: QrImageView(
                data: orderId,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(100, 100),
                ),
              ),
            ),
            // Order Details
            Text(
              "ORDER ${username.toString()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailText("Rider ID", orderId),
            _buildDetailText("Total items", totalitems.toString()),
          ],
        ),
      ),
    );
  }

  // Widget to display order details
  Widget _buildDetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$title : $value",
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
