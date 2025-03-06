import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import 'Add_driver.dart';
import 'Edit_driver.dart';

void main() {
  runApp(MaterialApp(
    home: DeliveryPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String selectedFilter = "All Drivers"; // Default filter

  // Sample driver data
  final List<Map<String, dynamic>> drivers = [
    {
      "name": "Arun",
      "id": "#4556",
      "email": "arun@gmail.com",
      "phone": "6895236545",
      "image": "assets/driver1.png",
      "status": "Active",
    },
    {
      "name": "Sachind",
      "id": "#8795",
      "email": "arun@gmail.com",
      "phone": "9856325789",
      "image": "assets/driver1.png",
      "status": "In Active",
    },
    {
      "name": "Deepak",
      "id": "#7896",
      "email": "arun@gmail.com",
      "phone": "789652456",
      "image": "assets/driver1.png",
      "status": "Active",
    },
    {
      "name": "Arun",
      "id": "#4556",
      "email": "arun@gmail.com",
      "phone": "6895236545",
      "image": "assets/driver1.png",
      "status": "Active",
    },
    {
      "name": "Arun",
      "id": "#6528",
      "email": "arun@gmail.com",
      "phone": "6895236545",
      "image": "assets/driver1.png",
      "status": "In Active",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDrivers = selectedFilter == "All Drivers"
        ? drivers
        : drivers.where((driver) => driver["status"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filter Dropdown
                DropdownButton<String>(
                  value: selectedFilter,
                  items: ["All Drivers", "Active", "In Active"]
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                  },
                ),

                // Moved "Add" Button down
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add_Driver()),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,  // **Make text bold**
                      color: Colors.white,          // **Ensure text color is white**
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: defaultColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                ),

              ],
            ),
          ),

          // Driver List
          Expanded(
            child: ListView.builder(
              itemCount: filteredDrivers.length,
              itemBuilder: (context, index) {
                return _buildDriverCard(filteredDrivers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // **Driver Card**
  Widget _buildDriverCard(Map<String, dynamic> driver) {
    bool isActive = driver["status"] == "Active";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(driver["image"]),
          ),
          const SizedBox(width: 10),

          // Driver Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${driver["name"]} (ID: ${driver["id"]})",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Email: ${driver["email"]}", style: const TextStyle(fontSize: 14)),
                Text("Phone No: ${driver["phone"]}", style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),

          // Status + Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: isActive ? Colors.green : Colors.red),
                  const SizedBox(width: 5),
                  Text(driver["status"], style: TextStyle(color: isActive ? Colors.green : Colors.red)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Edit_Driver()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
