import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../Model/Shop_Model/Shop_model.dart';
import 'Shop_Details.dart';

class AllShop extends StatefulWidget {
  const AllShop({super.key});

  @override
  State<AllShop> createState() => _AllShopState();
}

class _AllShopState extends State<AllShop> {
  List<Map<String, dynamic>> laundryShops = [
    {
      "id": "1",
      "shopName": "KneeKnits Laundry",
      "registerDate": "05 Jan 2025",
      "email": "knee@gmail.com",
      "phone": "9856321475",
      "status": "Pending"
    },
    {
      "id": "2",
      "shopName": "Landomart",
      "registerDate": "05 Jan 2025",
      "email": "landomart@gmail.com",
      "phone": "9856321475",
      "status": "Pending"
    },
    {
      "id": "3",
      "shopName": "LandroKart",
      "registerDate": "08 Jan 2025",
      "email": "landrokart@gmail.com",
      "phone": "9856321475",
      "status": "Pending"
    },
  ];

  void updateStatus(int index, String newStatus) {
    setState(() {
      laundryShops[index]['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hello !",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Cheers and happy activities",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Search Bar
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18)),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          hintText: 'Search Laundry Shops',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color(0xffD9D9D9),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color(0xffD9D9D9),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Page Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Laundry Shops",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: DataTable(
                    columns: [
                      _buildColumn("SI No"),
                      _buildColumn("Shop Name"),
                      _buildColumn("Register Date"),
                      _buildColumn("Email"),
                      _buildColumn("Phone"),
                      _buildColumn("Status"),
                      _buildColumn("Action"),
                    ],
                    rows: List.generate(
                      laundryShops.length,
                      (index) {
                        final shop = laundryShops[index];
                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString(),
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(shop["shopName"])),
                            DataCell(Text(shop["registerDate"])),
                            DataCell(Text(shop["email"])),
                            DataCell(Text(shop["phone"])),
                            DataCell(Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    updateStatus(index, "Accepted");
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: Colors.green,
                                        width: 2), // Green border
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text("Accept",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16)),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    updateStatus(index, "Rejected");
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: Colors.red,
                                        width: 2), // Red border
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text("Reject",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16)),
                                ),
                              ],
                            )),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.visibility,
                                    color: Colors.blueGrey),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShopDetailsDialog(
                                        // Ensure it's returned
                                        shopName: laundryShops[index]
                                                ["shopName"] ??
                                            "N/A",
                                        laundryCapacity: laundryShops[index]
                                                ['laundryCapacity'] ??
                                            "N/A",
                                        address: laundryShops[index]
                                                ['address'] ??
                                            "N/A",
                                        email: laundryShops[index]["email"] ??
                                            "N/A",
                                        phone: laundryShops[index]["phone"] ??
                                            "N/A",
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
