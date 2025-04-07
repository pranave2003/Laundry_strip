import 'package:flutter/material.dart';

class DriverAllOrdersWrapper extends StatelessWidget {
  final String driverId;

  const DriverAllOrdersWrapper(this.driverId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6, // Use dynamic data count when integrating Firebase
      itemBuilder: (context, index) {
        // Simulated statuses: You can map these from your backend
        final statuses = ["Pending", "In Progress", "Completed", "Cancelled"];
        final status = statuses[index % statuses.length];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ExpansionTile(
            leading: const Icon(Icons.local_shipping),
            title: Text("Order #${index + 1}"),
            subtitle: Text("Status: $status"),
            children: [
              ListTile(title: Text("Customer: User ${index + 1}")),
              ListTile(title: Text("Phone: 9876543210")),
              ListTile(title: Text("Pickup Time: 10:00 AM")),
              ListTile(title: Text("Delivery Time: 5:00 PM")),
              ListTile(title: Text("Payment: ₹250 - Paid")),
              if (status != "Completed" && status != "Cancelled")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Update order status here
                    },
                    child: const Text("Update Status"),
                  ),
                ),
              if (status == "Completed")
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("✅ Order Delivered", style: TextStyle(color: Colors.green)),
                ),
              if (status == "Cancelled")
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("❌ Order Cancelled", style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        );
      },
    );
  }
}
