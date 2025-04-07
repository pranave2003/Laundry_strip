import 'package:flutter/material.dart';

class DriverPendingWrapper extends StatelessWidget {
  const DriverPendingWrapper(String driverId, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DriverPending extends StatelessWidget {
  final String driverId;

  const DriverPending(this.driverId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ExpansionTile(
            title: Text("Pending Order #${index + 1}"),
            subtitle: Text("Awaiting Pickup"),
            children: [
              ListTile(title: Text("Customer: Alice")),
              ListTile(title: Text("Pickup Time: 9:30 AM")),
              ListTile(title: Text("Order Type: Wash & Fold")),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Pickup logic here
                  },
                  child: const Text("Mark as Picked Up"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
