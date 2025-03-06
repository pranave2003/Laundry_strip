import 'package:flutter/material.dart';
import 'assign_driver.dart';

class AvailableDrivers extends StatelessWidget {
  final List<Map<String, String>> drivers = [
    {"name": "Vishnu", "id": "#4556", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
    {"name": "Deepak", "id": "#3584", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
    {"name": "Varun", "id": "#8965", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
    {"name": "Rahul", "id": "#8965", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
    {"name": "Danish", "id": "#6856", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
    {"name": "Abhin", "id": "#9862", "email": "arun@gmail.com", "phone": "6895236545", "image": "assets/driver1.png", "status": "Active"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Assign Driver", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Available Drivers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return _buildDriverCard(context, drivers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Map<String, String> driver) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignDriverPage(selectedDriver: driver),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(driver["image"]!),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${driver["name"]} (ID: ${driver["id"]})", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Email: ${driver["email"]}"),
                  Text("Phone No: ${driver["phone"]}"),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle, size: 10, color: Colors.green),
                    const SizedBox(width: 5),
                    const Text("Active", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
