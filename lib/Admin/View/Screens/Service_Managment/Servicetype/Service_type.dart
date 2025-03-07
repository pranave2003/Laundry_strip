import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Model/Service_Model/Service_Model.dart';
import 'Edit_Service.dart';
import 'Service_Add.dart';

class ServiceType extends StatefulWidget {
  const ServiceType({super.key});

  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  List<Service_type> service = [
    Service_type(
        Id: "",
        Image: 'assets/icon/wash_fold.png',
        All_Materials: "Wash + Fold"),
    Service_type(
        Id: "",
        Image: 'assets/icon/wash_iron.png',
        All_Materials: "Wash + Iron"),
    Service_type(
        Id: "",
        Image: 'assets/icon/steam_iron.png',
        All_Materials: "Steam Iron"),
    Service_type(
        Id: "", Image: 'assets/icon/dry_clean.png', All_Materials: "Dry clean"),
    Service_type(
        Id: "",
        Image: 'assets/icon/stain_removal.png',
        All_Materials: "Stain Removal"),
    Service_type(
        Id: "",
        Image: 'assets/icon/bag_service.png',
        All_Materials: "Bag Service"),
    Service_type(
        Id: "",
        Image: 'assets/icon/shoe_service.png',
        All_Materials: "Shoe Service"),
    Service_type(
        Id: "",
        Image: 'assets/icon/household_service.png',
        All_Materials: "Household Service"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  Text(
                    "Admin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffD9D9D9),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Service Type",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
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
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          hintText: 'Search Services',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Add some spacing
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(backgroundColor: Colors.white,
                              content: SizedBox(
                                width: 700, height: 400,
                                child: ServiceAdd(),
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              // Background color
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth:
                        MediaQuery.of(context).size.width, // Ensures full width
                  ),
                  child: DataTable(
                    // border: TableBorder(
                    //   verticalInside: BorderSide(
                    //       color: Colors.black,
                    //       width: 1), // Vertical line between columns
                    //   horizontalInside: BorderSide(
                    //       color: Colors.grey, width: 0.5), // Horizontal lines
                    // ),
                    decoration: BoxDecoration(color: Colors.white),
                    columns: [
                      _buildColumn('SI/NO'),
                      _buildColumn('Service Image'),
                      _buildColumn('Service Type'),
                      _buildColumn('Action'),
                    ],

                    rows: List.generate(
                      service.length,
                      (index) {
                        final Service_data = service[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              (index + 1).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataCell(Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Service_data.Image))),
                            )),
                            DataCell(Text(Service_data.All_Materials)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(backgroundColor: Colors.white,
                                          //title: Text("Edit Service"),
                                          content: SizedBox(
                                            width: 700, height: 400,// Adjust size as needed
                                            child: ServiceEdit(), // Embedding ServiceEdit Widget
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
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))

                              ],
                            )),
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
    ();
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }
}
