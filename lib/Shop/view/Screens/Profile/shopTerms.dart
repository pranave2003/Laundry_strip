import 'package:flutter/material.dart';

class LaundryShopTermsPage extends StatefulWidget {
  @override
  _LaundryShopTermsPageState createState() => _LaundryShopTermsPageState();
}

class _LaundryShopTermsPageState extends State<LaundryShopTermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Laundry Shop Terms & Conditions",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "By registering on Laundry Mate as a laundry service provider, you agree to the following terms and conditions:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 1: Registration & Approval
                    const Text("1. Registration & Approval",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                          "- Laundry Mate reserves the right to approve or reject any shop registration.\n"
                          "- Shops must comply with local business laws and regulations.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 2: Service Quality & Customer Satisfaction
                    const Text("2. Service Quality & Customer Satisfaction",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Shops must ensure high-quality service, including proper washing, drying, and ironing.\n"
                          "- Any disputes regarding damaged or lost items will be resolved as per Laundry Mate policies.\n"
                          "- Shops must address customer complaints promptly and professionally.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 3: Pricing & Payments
                    const Text("3. Pricing & Payments",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Shops must list accurate prices for their services.\n"
                          "- Prices may be subject to platform commission fees.\n"
                          "- Payments for services will be settled through Laundry Mate's payment system, and payouts will be processed as per the defined schedule.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 4: Order Cancellations & Refunds
                    const Text("4. Order Cancellations & Refunds",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Shops must notify customers in case of order cancellations.\n"
                          "- Refunds will be processed as per Laundry Mate's refund policy.\n"
                          "- Shops may be required to offer re-service if the customer is dissatisfied with the quality.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 5: Shop Responsibilities
                    const Text("5. Shop Responsibilities",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Shops must ensure accurate order processing and timely delivery.\n"
                          "- Any damage or loss due to shop negligence must be compensated as per policy.\n"
                          "- Shops are responsible for handling special care instructions provided by customers.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 6: Data Privacy & Confidentiality
                    const Text("6. Data Privacy & Confidentiality",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Shops must protect customer data and not share it with third parties.\n"
                          "- Any misuse of customer information will lead to account suspension.\n"
                          "- Shops agree to comply with data protection laws applicable in their region.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 7: Termination & Policy Changes
                    const Text("7. Termination & Policy Changes",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Laundry Mate reserves the right to suspend or terminate any shop account for policy violations.\n"
                          "- These terms may be updated periodically, and continued use of the platform implies agreement to the updated terms.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
