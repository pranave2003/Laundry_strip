import 'package:flutter/material.dart';

import 'Add_shop.dart';

class Laundry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaundryView(),
    );
  }
}

class LaundryView extends StatelessWidget {
  final List<Map<String, String>> serviceTypes = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
  ];

  final List<String> categories = ["Men"];

  final List<Map<String, String>> products = [
    {"icon": "assets/Dress/shirt.png", "name": "Shirt", "price": "₹50"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shop_Add()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://t3.ftcdn.net/jpg/04/44/84/96/360_F_444849699_egr1i6ghKxphlqUG6VBRKnFi4UtFHYvp.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text("KneeKnits Laundry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text("Laundry Capacity: 10 Kg", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Owner: Arun"),
              Text("Address: 2609+988, Jalahalli Cross Rd, Peenya, Bengaluru, India"),
              SizedBox(height: 16),
             ListView.builder(itemBuilder: (context, index) {
               return Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12),
                 ),
                 elevation: 4,
                 child: Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       buildDetailRow("Service", serviceTypes[0]['name']!),
                       buildDetailRow("Category", categories[0]),
                       SizedBox(height: 10),
                       Text("Products & Prices", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                       SizedBox(height: 5),
                       Row(
                         children: [
                           Image.asset(products[0]["icon"]!, height: 50),
                           SizedBox(width: 10),
                           Text(products[0]["name"]!, style: TextStyle(fontSize: 16)),
                           Spacer(),
                           Text(products[0]["price"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ],
                   ),
                 ),
               );
             },)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}



