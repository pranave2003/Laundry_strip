import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Model/Category_Model/Category_Model.dart';
import '../../../../Model/Service_Model/Service_Model.dart';
import 'Add_Category.dart';
import 'Edit_Category.dart';

class ServiceCategory extends StatefulWidget {
  const ServiceCategory({super.key});

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  List<Service_category> category = [
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/shirt.png'),

    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "T-Shirt",
        Product_Image: 'assets/Dress/t-shirt.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Jacket",
        Product_Image: 'assets/Dress/jacket.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/shirt.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/t-shirt.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/shirt.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/t-shirt.png'),
    Service_category(
        Id: "",
        Service: "Wash + Fold",
        Category: "Men",
        Product_Name: "Shirt",
        Product_Image: 'assets/Dress/jacket.png'),

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
                  "Service Category",
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
                          hintText: 'Search Category',
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
                                width: 730, height: 500,
                                child: CategoryAdd(),
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
                      _buildColumn('Service Type'),
                      _buildColumn('Category'),
                      _buildColumn('Product Name'),
                      _buildColumn('Product Image'),
                      _buildColumn('Action'),

                    ],

                    rows: List.generate(
                      category.length,
                          (index) {
                        final Category_data = category[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              (index + 1).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataCell(Text(Category_data.Service)),
                            DataCell(Text(Category_data.Category)),
                            DataCell(Text(Category_data.Product_Name)),


                            DataCell(Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Category_data.Product_Image))),
                            )),

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
                                            width: 730, height: 500,// Adjust size as needed
                                            child: CategoryEdit(), // Embedding ServiceEdit Widget
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





