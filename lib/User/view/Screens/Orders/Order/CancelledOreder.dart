
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelledOrders extends StatelessWidget {
  const CancelledOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              // child: Center(
              //   child: Image.asset("order["icon"]", width: 35, height: 35),
              // ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("service",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text("Order ID:",
                      style:
                      const TextStyle(fontSize: 12, color: Colors.black87)),
                  Text("Order Date:" "date",
                      style:
                      const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                // color: "statusColor"],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("status",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    // color: order["textColor"]
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
