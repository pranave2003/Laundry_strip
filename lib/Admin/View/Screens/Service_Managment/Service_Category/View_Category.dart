import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';
import '../../../../Model/Category_Model/Category_Model.dart';
import '../../../../Model/Service_Model/Service_Model.dart';
import 'Add_Category.dart';
import 'Edit_Category.dart';

class ServiceCategoryWrapper extends StatelessWidget {
  const ServiceCategoryWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()..add(FetchCategory(searchQuery: null)),
      child: ServiceCategory(),
    );
  }
}

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
                        hintText: 'Search Category',
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
                    const SizedBox(width: 10), // Add some spacing
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: SizedBox(
                                width: 730,
                                height: 500,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<ServiceBloc, ServiceState>(
              listener: (context, state) {
                if(state is RefreshCategory){
                  context.read<ServiceBloc>().add(
                      FetchCategory(searchQuery: null));
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(child: Loading_Widget());
                } else if (state is Categoryfailerror) {
                  return Text(state.error.toString());
                } else if (state is Categoryloaded) {
                  if (state.category.isEmpty) {
                    // Return "No data found" if txhe list is empty
                    return Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Container(
                    // Background color
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context)
                              .size
                              .width, // Ensures full width
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
                            state.category.length,
                            (index) {
                              final category = state.category[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    (index + 1).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  DataCell(Text(category.service.toString())),
                                  DataCell(Text(category.category.toString())),
                                  DataCell(
                                      Text(category.product_name.toString())),
                                  DataCell(Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                category.product_image))),
                                  )),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                //title: Text("Edit Service"),
                                                content: SizedBox(
                                                  width: 730,
                                                  height: 500,
                                                  // Adjust size as needed
                                                  child:
                                                      CategoryEdit(), // Embedding ServiceEdit Widget
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close dialog
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
                                          onPressed: () {
                                            context.read<ServiceBloc>().add(
                                                DeleteCategory(
                                                    id: category.category_id));
                                          },
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
                  );
                }
                return SizedBox();
              },
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
