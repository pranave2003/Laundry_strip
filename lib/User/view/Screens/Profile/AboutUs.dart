import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About Laundry Mate",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "Laundry Mate is your one-stop solution for professional laundry and dry cleaning services. Our mission is to provide top-notch, convenient, and reliable laundry solutions for individuals and businesses alike. We are committed to delivering fresh, clean, and well-cared-for garments to our customers.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text("Our Mission",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "At Laundry Mate, we aim to simplify laundry care through innovative technology, quality service, and customer satisfaction. We strive to make laundry hassle-free and convenient for everyone.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text("Why Choose Us?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "- Convenient Pickup & Delivery\n"
                  "- High-Quality Cleaning\n"
                  "- Affordable Pricing\n"
                  "- Eco-Friendly Practices\n"
                  "- 100% Customer Satisfaction",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
