import 'package:flutter/material.dart';

class DriverTermsPage extends StatefulWidget {
  @override
  _DriverTermsPageState createState() => _DriverTermsPageState();
}

class _DriverTermsPageState extends State<DriverTermsPage> {
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
                      "Driver Terms & Conditions",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "By registering as a delivery driver on Laundry Mate, you agree to the following terms and conditions:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 1: Registration & Background Check
                    const Text("1. Registration & Background Check",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- All drivers must provide valid identification and undergo verification.\n"
                          "- Laundry Mate reserves the right to accept or reject any application.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 2: Order Pickup & Delivery
                    const Text("2. Order Pickup & Delivery",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Drivers must ensure timely pickup and delivery of laundry orders.\n"
                          "- Any delay or issue must be communicated immediately to the platform and customer.\n"
                          "- Drivers are responsible for handling items with care during transportation.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 3: Earnings & Payouts
                    const Text("3. Earnings & Payouts",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Drivers will receive payments for each completed delivery.\n"
                          "- All payments will be processed through Laundry Mate's system on a scheduled basis.\n"
                          "- Platform service fees may apply.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 4: Conduct & Responsibilities
                    const Text("4. Conduct & Responsibilities",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Drivers must maintain professional behavior while interacting with customers.\n"
                          "- Smoking, misconduct, or inappropriate behavior during delivery is strictly prohibited.\n"
                          "- Any loss or damage caused by negligence must be compensated.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 5: Safety & Legal Compliance
                    const Text("5. Safety & Legal Compliance",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Drivers must follow all local traffic laws and safety regulations.\n"
                          "- Valid driving license and vehicle insurance must be maintained at all times.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 6: Data & Confidentiality
                    const Text("6. Data & Confidentiality",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Drivers must not share customer details or order information with unauthorized persons.\n"
                          "- All customer data must be treated as confidential.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    // Section 7: Termination & Policy Updates
                    const Text("7. Termination & Policy Updates",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text(
                      "- Laundry Mate may suspend or terminate a driver's account for policy violations.\n"
                          "- Terms may be updated periodically. Continued use indicates acceptance of the changes.",
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
