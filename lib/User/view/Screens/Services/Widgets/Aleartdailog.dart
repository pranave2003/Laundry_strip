import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../../Widget/constands/colors.dart';

Widget buildServiceItemList(List<Map<String, dynamic>> serviceItems,
    List<Map<String, dynamic>> selectedItems, Function updateSelectedItems) {
  return Expanded(
    child: ListView.builder(
      itemCount: serviceItems.length,
      itemBuilder: (context, index) {
        String? selectedFabricType;
        String? selectedInstruction;

        return Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    titlePadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shirt",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close_sharp, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFFBF8F8),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/Dress/shirt.png",
                                        width: 50, height: 50),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Shirts Standard Pack",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text("(Dry Clean)",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12)),
                                        SizedBox(height: 5),
                                        Text("₹ 75",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.add_circle)),
                                    CircleAvatar(
                                      radius: 15,
                                      child: Text('1'),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.add_circle))
                                  ],
                                ),
                                SizedBox(height: 15),
                                Text("Fabric Type",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      hint: Text("Select Fabric"),
                                      value: selectedFabricType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedFabricType = value;
                                        });
                                      },
                                      items: ["Cotton", "Silk", "Wool"]
                                          .map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Special Instructions",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      hint: Text("Select Instructions"),
                                      value: selectedInstruction,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedInstruction = value;
                                        });
                                      },
                                      items: [
                                        "None",
                                        "Hand Wash",
                                        "Low Heat Dry"
                                      ].map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Instruction Code : a4fd45hg11",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          updateSelectedItems({
                            ...serviceItems[index],
                            'fabricType': selectedFabricType,
                            'instructions': selectedInstruction,
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 80),
                          child: Text("Add item",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updateSelectedItems({
                            ...serviceItems[index],
                            'fabricType': selectedFabricType,
                            'instructions': selectedInstruction,
                            'serviceType': "Dry Clean", // You can modify this dynamically
                          });
                          Navigator.pop(context);
                        },

                        child:
                        Text("Cancel", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
            leading: Image.asset(serviceItems[index]["icon"]),
            title: Text(serviceItems[index]["name"]),
            subtitle: Text("₹ ${serviceItems[index]["price"]}"),
            trailing: IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
              onPressed: () {
                updateSelectedItems(serviceItems[index]);
              },
            ),
          ),
        );
      },
    ),
  );
}
