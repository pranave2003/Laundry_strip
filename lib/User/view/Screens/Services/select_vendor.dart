import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../Address/pickup_delivery.dart';

class VendorSelectionPage extends StatefulWidget {
  @override
  _VendorSelectionPageState createState() => _VendorSelectionPageState();
}

class _VendorSelectionPageState extends State<VendorSelectionPage> {
  int? selectedVendorIndex;
  int? expandedVendorIndex; // Track which vendor's services are expanded

  List<Map<String, dynamic>> vendors = [
    {
      'name': 'NearKnits Laundry',
      'address': 'Opposite KSRTC Bus Stand, Mavoor Road',
      'services': [
        {'name': 'Wash + Fold', 'price': 80},
        {'name': 'Dry Clean', 'price': 100},
        {'name': 'Steam Iron', 'price': 200},
        {'name': 'Bag Service', 'price': 150},
      ],
      'image': 'assets/shop_img/img.png',
    },
    {
      'name': 'Pure Press Laundry',
      'address': 'Opposite KSRTC Bus Stand, Mavoor Road',
      'services': [
        {'name': 'Wash + Fold', 'price': 80},
        {'name': 'Dry Clean', 'price': 100},
        {'name': 'Steam Iron', 'price': 200},
        {'name': 'Bag Service', 'price': 150},
      ],
      'image': 'assets/shop_img/img2.png',
    },
    {
      'name': 'NearKnits Laundry',
      'address': 'Opposite KSRTC Bus Stand, Mavoor Road',
      'services': [
        {'name': 'Wash + Fold', 'price': 80},
        {'name': 'Dry Clean', 'price': 100},
        {'name': 'Steam Iron', 'price': 200},
        {'name': 'Bag Service', 'price': 150},
      ],
      'image': 'assets/shop_img/img.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Vendors",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SelectService()),
            );
          },
        ),
      ),


      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedVendorIndex == index;
                bool isExpanded = expandedVendorIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVendorIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                vendors[index]['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendors[index]['name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.blue, size: 16),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          vendors[index]['address'],
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        expandedVendorIndex =
                                        (expandedVendorIndex == index)
                                            ? null
                                            : index;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "View Services",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (isExpanded) ...[
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: vendors[index]['services']
                                .map<Widget>((service) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(service['name'],
                                        style: TextStyle(fontSize: 14)),
                                    //Text("₹ ${service['price']}",
                                       //style: TextStyle(
                                            //fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: defaultColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickupDelivery()),
                );
              },
              child: Center(
                child: Text("Continue",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
