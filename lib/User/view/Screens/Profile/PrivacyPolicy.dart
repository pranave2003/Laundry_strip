import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  "Welcome to Laundry Mate. Your privacy is important to us. This Privacy Policy explains how we collect, use, and safeguard your information when using our services.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("1. Information We Collect",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "- Personal Information: We may collect your name, email, phone number, and address when you register or place an order.\n"
                      "- Payment Information: We collect billing details to process transactions securely.\n"
                      "- Usage Data: Information about how you interact with our app may be collected to improve our services.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("2. How We Use Your Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "- To provide and manage our laundry services.\n"
                      "- To process payments securely.\n"
                      "- To improve user experience and personalize content.\n"
                      "- To send notifications about your orders and promotions.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("3. Information Sharing & Security",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "- We do not sell or rent your personal information.\n"
                      "- Your data is protected with encryption and secure storage.\n"
                      "- We may share data with third-party service providers to improve our services.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("4. Your Rights & Choices",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "- You can update or delete your account information at any time.\n"
                      "- You may opt out of promotional messages.\n"
                      "- You can request access to the data we hold about you.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("5. Changes to This Policy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "- We reserve the right to update this policy at any time.\n"
                      "- We encourage you to review this page periodically for any changes.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text("6. Contact Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "If you have any questions about our Privacy Policy, please contact us at support@laundrymate.com.",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
