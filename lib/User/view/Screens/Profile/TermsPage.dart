import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  //bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Terms and Conditions",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "Welcome to Laundry Mate! By using our services, you agree to the following terms and conditions. Please read them carefully:",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("1. Service Agreement",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- Laundry Mate provides professional laundry, dry cleaning, and related services. \n"
                          "- We strive to handle your garments with utmost care but do not guarantee the removal of all stains.\n"
                          "- Some materials may react differently to washing processes. We are not liable for natural wear and tear.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("2. Payments & Pricing",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- All prices are subject to change without prior notice.\n"
                          "- Payments must be made before or at the time of delivery.\n"
                          "- Any additional services requested will incur extra charges.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("3. Cancellations & Refunds",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- Orders can be canceled within 30 minutes of placement for a full refund.\n"
                          "- No refunds will be provided once the service is in progress.\n"
                          "- In case of a service failure, we may offer a partial refund or free rewash based on our discretion.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("4. Customer Responsibilities",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- Customers must check their pockets before handing over laundry. We are not responsible for lost or damaged valuables.\n"
                          "- Any special care instructions must be provided before placing an order.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("5. Limitation of Liability",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- Laundry Mate is not responsible for any damage caused by normal wear, pre-existing conditions, or manufacturer defects.\n"
                          "- Our liability for lost or damaged garments is limited to 5 times the cost of the cleaning service paid.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text("6. Changes to Terms",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "- We reserve the right to update these terms at any time. Continued use of our services constitutes agreement to the new terms.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: isAccepted,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           isAccepted = value ?? false;
            //         });
            //       },
            //     ),
            //     Expanded(
            //       child: Text("I accept the Terms and Conditions",
            //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
