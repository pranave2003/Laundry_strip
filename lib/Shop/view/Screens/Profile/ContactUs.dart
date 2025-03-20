import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Get in Touch",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                "We're here to assist you! Reach out to us using any of the following methods:",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.email, size: 24),
                SizedBox(width: 10),
                Text("Email: support@laundrymate.com",
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, size: 24),
                SizedBox(width: 10),
                Text("Phone: +1 234 567 890", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, size: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Text("Office: 123 Laundry Street, City, Country",
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
