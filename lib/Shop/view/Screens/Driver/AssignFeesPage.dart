import 'package:flutter/material.dart';

class AssignFeesPage extends StatelessWidget {
  const AssignFeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pickupFeeController = TextEditingController();
    final deliveryFeeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Fees"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Section
            _infoTile(title: "Order ID", value: "ORD123456"),
            _infoTile(title: "Customer Name", value: "Rahul Sharma"),
            _infoTile(title: "Order Date", value: "08-Apr-2025"),
            const SizedBox(height: 20),

            // Driver Info Section
            _infoTile(title: "Driver Name", value: "Akhil M"),
            _infoTile(title: "Driver Phone", value: "+91 9876543210"),
            const SizedBox(height: 30),

            // Input Fields
            const Text("Pickup Fee (₹)", style: _labelStyle),
            const SizedBox(height: 6),
            _customInputField(controller: pickupFeeController, hint: "Enter pickup fee"),

            const SizedBox(height: 20),
            const Text("Delivery Fee (₹)", style: _labelStyle),
            const SizedBox(height: 6),
            _customInputField(controller: deliveryFeeController, hint: "Enter delivery fee"),

            const SizedBox(height: 30),

            // Assign Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Assign Fees", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _customInputField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static const TextStyle _labelStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
}
