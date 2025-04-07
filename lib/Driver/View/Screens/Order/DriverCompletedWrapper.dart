import 'package:flutter/material.dart';

class DriverCompletedWrapper extends StatelessWidget {
  final String driverId;

  const DriverCompletedWrapper(this.driverId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ExpansionTile(
            title: Text("Delivered Order #${index + 1}"),
            subtitle: Text("Status: Completed"),
            children: [
              ListTile(title: Text("Customer: Sarah")),
              ListTile(title: Text("Delivered At: 4:00 PM")),
              ListTile(title: Text("Payment: Collected")),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("✅ Successfully Delivered", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        );
      },
    );
  }
}
