import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';
import '../Service_Managment/Material_type/Add_shoe_material.dart';
import 'Driver_Add.dart';
import 'edit_driver.dart';

class Driver {
  final String name;
  final String phone;
  final String driverId;
  final String email;
  final String image;
  final bool isActive;

  Driver({
    required this.name,
    required this.phone,
    required this.driverId,
    required this.email,
    required this.image,
    required this.isActive,
  });
}

class AllDriversPage extends StatefulWidget {
  const AllDriversPage({super.key});

  @override
  State<AllDriversPage> createState() => _AllDriversPageState();
}

class _AllDriversPageState extends State<AllDriversPage> {
  String selectedFilter = "All Drivers";

  final List<Driver> drivers = [
    Driver(name: "Amal", phone: "8962147896", email: "amal@gmail.com", driverId: "8547 9658 2578", image: "assets/driver1.png", isActive: true),
    Driver(name: "Sachind", phone: "8962147896",  email: "sachind@gmail.com",driverId: "5566 7788 5662", image: "assets/driver1.png", isActive: true),
    Driver(name: "Rahul", phone: "8962147896",  email: "rahul@gmail.com",driverId: "5566 7788 5662", image: "assets/driver1.png", isActive: false),
    Driver(name: "Arjun", phone: "8962147896",  email: "arjun@gmail.com", driverId: "5566 7788 5662", image: "assets/driver1.png", isActive: false),
  ];

  @override
  Widget build(BuildContext context) {
    List<Driver> filteredDrivers = drivers;
    if (selectedFilter == "Active") {
      filteredDrivers = drivers.where((d) => d.isActive).toList();
    } else if (selectedFilter == "Inactive") {
      filteredDrivers = drivers.where((d) => !d.isActive).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                          hintText: 'Search Driver',
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
            SizedBox(
              height: 35,
            ),
            const SizedBox(height: 20),
            Text(
              "Driver",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        isExpanded: true,
                        underline: Stack(
                          children: [
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                        items: ["All Drivers", "Active", "Inactive"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: SizedBox(
                                width: 700, height: 600,
                                child: DriverAdd(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: defaultColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
                        "Add",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 700),
                  child: ListView.builder(
                    itemCount: filteredDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = filteredDrivers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: driver.image.isNotEmpty
                                    ? AssetImage(driver.image)
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(driver.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    Text("Phone No: ${driver.phone}"),
                                    Text("Email Id: ${driver.email}"),
                                    Text("Driver ID: ${driver.driverId}"),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: driver.isActive ? Colors.green : Colors.red,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        driver.isActive ? "Active" : "Inactive",
                                        style: TextStyle(
                                          color: driver.isActive ? Colors.black : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(backgroundColor: Colors.white,
                                                //title: Text("Edit Service"),
                                                content: SizedBox(
                                                  width: 700, height: 600,// Adjust size as needed
                                                  child: DriverEdit(), // Embedding ServiceEdit Widget
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(); // Close dialog
                                                    },
                                                    child: Text("Cancel"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
