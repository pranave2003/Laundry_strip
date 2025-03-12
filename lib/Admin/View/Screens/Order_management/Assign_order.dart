import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';

class AssignOrderPage extends StatefulWidget {
  @override
  _AssignOrderPageState createState() => _AssignOrderPageState();
}

class _AssignOrderPageState extends State<AssignOrderPage> {
  String selectedDriver = ""; // Stores the assigned driver's name

  // Dummy List of Drivers (You can replace it with real data)
  final List<Map<String, String>> drivers = [
    {"name": "Amal", "phone": "8962147896", "image": "assets/driver1.png"},
    {"name": "Sachind", "phone": "7845963214", "image": "assets/driver1.png"},
    {"name": "Rahul", "phone": "6589741236", "image": "assets/driver1.png"},
  ];
  List<Map<String, dynamic>> orders = [
    {
      "orderId": "ORD001",
      "customerName": "John Doe",
      "customerPhone": "9876543210",
      "customerAddress": "123 Main Street, Downtown",
      "orderedDate": "2025-03-10",
      "pickupDate": "2025-03-11",
      "laundryShops": [
        {
          "name": "Clean Wash",
          "owner": "Michael Johnson",
          "location": "Downtown",
          "contact": "123-456-7890",
          "image": "assets/shop_img/img.png",
          "services": ["Wash & Fold", "Steam Iron"],
          "products": [
            {
              "productName": "Shirt",
              "price": 5.0,
              "image": "assets/Dress/shirt.png",
              "serviceName": "Wash & Fold",
            },
            {
              "productName": "Jacket",
              "price": 15.0,
              "image": "assets/Dress/jacket.png",
              "serviceName": "Steam Iron",
            }
          ],
        },
        {
          "name": "Quick Clean",
          "owner": "Sarah Lee",
          "location": "Uptown",
          "contact": "789-123-4560",
          "image": "assets/shop_img/img2.png",
          "services": ["Household", "Dry Clean"],
          "products": [
            {
              "productName": "Carpet",
              "price": 10.0,
              "image": "assets/Dress/carpet.png",
              "serviceName": "Household",
            },
            {
              "productName": "T-shirt",
              "price": 12.0,
              "image": "assets/Dress/t-shirt.png",
              "serviceName": "Dry Clean",
            }
          ],
        },
        {
          "name": "Fresh Laundry",
          "owner": "Emma Wilson",
          "location": "Midtown",
          "contact": "654-987-3210",
          "image": "assets/shop_img/img3.png",
          "services": ["Steam Iron", "Dry Clean"],
          "products": [
            {
              "productName": "Frock",
              "price": 8.0,
              "image": "assets/Dress/frock.png",
              "serviceName": "Steam Iron",
            },
            {
              "productName": "Gown",
              "price": 6.0,
              "image": "assets/Dress/wmgown.png",
              "serviceName": "Dry Clean",
            }
          ],
        }
      ]
    },
    {
      "orderId": "ORD002",
      "customerName": "Jane Smith",
      "customerPhone": "8765432109",
      "customerAddress": "456 Elm Street, Uptown",
      "orderedDate": "2025-03-09",
      "pickupDate": "2025-03-10",
      "laundryShops": [
        {
          "name": "Quick Clean",
          "owner": "Sarah Lee",
          "location": "Uptown",
          "contact": "789-123-4560",
          "image": "assets/shop_img/img2.png",
          "services": ["Dry Clean", "Special Care"],
          "products": [
            {
              "productName": "Dress",
              "price": 12.0,
              "image": "assets/Dress/frock.png",
              "serviceName": "Dry Clean",
            },
            {
              "productName": "T-Shirt",
              "price": 8.0,
              "image": "assets/Dress/t-shirt.png",
              "serviceName": "Special Care",
            }
          ],
        }
      ]
    },
    {
      "orderId": "ORD003",
      "customerName": "John Doe",
      "customerPhone": "9876543210",
      "customerAddress": "123 Main Street, Downtown",
      "orderedDate": "2025-03-10",
      "pickupDate": "2025-03-11",
      "laundryShops": [
        {
          "name": "Clean Wash",
          "owner": "Michael Johnson",
          "location": "Downtown",
          "contact": "123-456-7890",
          "image": "assets/shop_img/img.png",
          "services": ["Wash & Fold", "Steam Iron"],
          "products": [
            {
              "productName": "Shirt",
              "price": 5.0,
              "image": "assets/Dress/shirt.png",
              "serviceName": "Wash & Fold",
            },
            {
              "productName": "Jacket",
              "price": 15.0,
              "image": "assets/Dress/jacket.png",
              "serviceName": "Steam Iron",
            }
          ],
        },
        {
          "name": "Quick Clean",
          "owner": "Sarah Lee",
          "location": "Uptown",
          "contact": "789-123-4560",
          "image": "assets/shop_img/img2.png",
          "services": ["Household", "Dry Clean"],
          "products": [
            {
              "productName": "Carpet",
              "price": 10.0,
              "image": "assets/Dress/carpet.png",
              "serviceName": "Household",
            },
            {
              "productName": "T-shirt",
              "price": 12.0,
              "image": "assets/Dress/t-shirt.png",
              "serviceName": "Dry Clean",
            }
          ],
        },
        {
          "name": "Fresh Laundry",
          "owner": "Emma Wilson",
          "location": "Midtown",
          "contact": "654-987-3210",
          "image": "assets/shop_img/img3.png",
          "services": ["Steam Iron", "Dry Clean"],
          "products": [
            {
              "productName": "Frock",
              "price": 8.0,
              "image": "assets/Dress/frock.png",
              "serviceName": "Steam Iron",
            },
            {
              "productName": "Gown",
              "price": 6.0,
              "image": "assets/Dress/wmgown.png",
              "serviceName": "Dry Clean",
            }
          ],
        }
      ]
    },
    {
      "orderId": "ORD004",
      "customerName": "Jane Smith",
      "customerPhone": "8765432109",
      "customerAddress": "456 Elm Street, Uptown",
      "orderedDate": "2025-03-09",
      "pickupDate": "2025-03-10",
      "laundryShops": [
        {
          "name": "Quick Clean",
          "owner": "Sarah Lee",
          "location": "Uptown",
          "contact": "789-123-4560",
          "image": "assets/shop_img/img2.png",
          "services": ["Dry Clean", "Special Care"],
          "products": [
            {
              "productName": "Dress",
              "price": 12.0,
              "image": "assets/Dress/frock.png",
              "serviceName": "Dry Clean",
            },
            {
              "productName": "T-Shirt",
              "price": 8.0,
              "image": "assets/Dress/t-shirt.png",
              "serviceName": "Special Care",
            }
          ],
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Greeting & Admin Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello !",
                            style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Cheers and Happy Activities ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 400,
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(18)),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                BorderSide(color: Theme.of(context).primaryColor),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              hintText: 'Search orders',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 21,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xffD9D9D9),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.person)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xffD9D9D9),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.notification_add)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

              ),

              SizedBox(height: 35),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Assign Order",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),

                  ],
                ),
              ),

              SizedBox(height: 20),
              //appBar: AppBar(title: Text("Assign Order")),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 600, // Set appropriate height
                  child: ListView(
                    children: orders.map<Widget>((order) {
                      double totalOrderAmount = 0;

                      return Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ExpansionTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID: ${order['orderId']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text("Customer: ${order['customerName']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Phone: ${order['customerPhone']}",
                                  style: TextStyle(color: Colors.grey[700])),
                              Text("Address: ${order['customerAddress']}",
                                  style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ordered Date: ${order['orderedDate']}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600])),
                              Text("Pickup Date: ${order['pickupDate']}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600])),
                            ],
                          ),
                          children: [
                            Divider(),
                            ...order["laundryShops"].map<Widget>((shop) {
                              double shopTotal = shop["products"].fold(
                                  0.0, (sum, item) => sum + item["price"]);
                              totalOrderAmount += shopTotal;

                              return Column(
                                children: [
                                  ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(shop['image'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                    ),
                                    title: Text(shop['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Owner: ${shop['owner']}"),
                                        Text("Location: ${shop['location']}"),
                                        Text("Contact: ${shop['contact']}"),
                                        Text(
                                            "Services: ${shop['services'].join(", ")}",
                                            style: TextStyle(
                                                color: Colors.blueAccent)),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  ...shop["products"].map<Widget>((product) {
                                    return ListTile(
                                      leading: Image.asset(product["image"],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                      title: Text(product["productName"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                          "Service: ${product["serviceName"]}",
                                          style: TextStyle(
                                              color: Colors.blueAccent)),
                                      trailing: Text(
                                          "\$${product["price"].toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    );
                                  }).toList(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Total: \$${shopTotal.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green)),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            }).toList(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    "Grand Total: \$${totalOrderAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  showAvailableDrivers(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      defaultColor, // Use defaultColor
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                //child: Text("Assign Driver", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                child: Text(
                                  selectedDriver.isNotEmpty
                                      ? selectedDriver
                                      : "Assign Driver",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // Method to Show Available Drivers in a Dialog
  void showAvailableDrivers(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Available Drivers"),
          content: SizedBox(
            width: 400,
            height: 300,
            child: ListView(
              children: drivers.map((driver) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(driver["image"]!),
                  ),
                  title: Text(driver["name"]!),
                  subtitle: Text(driver["phone"]!),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Set Selected Driver
                      setState(() {
                        selectedDriver = driver["name"]!;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Select"),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
