import 'package:flutter/material.dart';

class DriverInProgressWrapper extends StatelessWidget {
  final String driverId;

  const DriverInProgressWrapper(this.driverId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ExpansionTile(
            title: Text("In Progress #${index + 1}"),
            subtitle: Text("Out for Delivery"),
            children: [
              ListTile(title: Text("Customer: Mark")),
              ListTile(title: Text("Address: 123 Main St")),
              ListTile(title: Text("Contact: 9876543210")),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    // mark as delivered
                  },
                  child: const Text("Mark as Delivered"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
