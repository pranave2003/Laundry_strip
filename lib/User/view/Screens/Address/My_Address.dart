import 'package:flutter/material.dart';
import 'Add_address.dart';

import 'Edit_address.dart';

class AddressesPage extends StatefulWidget {
  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  List<Map<String, String>> addresses = [
    {"address": "2GQ9+988, Jalahalli Cross Rd, Peenya, Bengaluru", "tag": "Home"},
    {"address": "123 MG Road, Indiranagar, Bengaluru", "tag": "Office"}
  ]; // Initial dummy addresses
  int selectedIndex = 0; // Track selected radio button

  void addNewAddress(String newAddress, String tag) {
    setState(() {
      addresses.add({"address": newAddress, "tag": tag});
    });
  }

  void updateAddress(int index, String updatedAddress, String updatedTag) {
    setState(() {
      addresses[index] = {"address": updatedAddress, "tag": updatedTag};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "My Addresses",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Saved Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: index,
                                groupValue: selectedIndex,
                                onChanged: (value) {
                                  setState(() {
                                    selectedIndex = value as int;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Text(
                                "${addresses[index]['tag']}",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              addresses[index]['address']!,
                              style: TextStyle(fontSize: 15, color: Colors.black87),
                            ),
                          ),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditAddressPage(
                                        initialAddress: addresses[index]["address"]!,
                                        initialTag: addresses[index]["tag"]!,
                                      ),
                                    ),
                                  );

                                  if (result != null) {
                                    updateAddress(index, result["address"], result["tag"]);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text("Edit", style: TextStyle(color: Colors.green)),
                              ),
                              SizedBox(width: 30),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    addresses.removeAt(index);
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.red),
                                ),
                                child: Text("Delete", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAddressPage()),
                  );

                  if (result != null) {
                    addNewAddress(result["address"], result["tag"]);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Add New Address", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
