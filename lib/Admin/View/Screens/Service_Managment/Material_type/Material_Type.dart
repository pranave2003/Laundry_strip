import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';
import '../../../../Model/Material_Model/Cloth_Model.dart';
import '../../../../Model/Service_Model/Service_Model.dart';
import 'Add_Material_Type.dart';
import 'Edit_Material_Type.dart';

class MaterialWrapper extends StatelessWidget {
  const MaterialWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()..add(FetchMaterial(searchQuery: null)),
      child: MaterialType(),
    );
  }
}

class MaterialType extends StatefulWidget {
  const MaterialType({super.key});

  @override
  State<MaterialType> createState() => _MaterialTypeState();
}

class _MaterialTypeState extends State<MaterialType> {
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
                        hintText: 'Search Material',
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
            padding: const EdgeInsets.only(
                left: 25, right: 25), // Adjusted right padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cloth Material",
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
                              //title: Text("Edit Service"),
                              content: SizedBox(
                                width: 700,
                                height: 400, // Adjust size as needed
                                child:
                                    AddMaterial(), // Embedding ServiceEdit Widget
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
                        backgroundColor: defaultColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      icon: Icon(Icons.add, color: Colors.white), // Add icon
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
            child: Container(
              // Background color
              child: BlocConsumer<ServiceBloc, ServiceState>(
                listener: (context, state) {
                  if(state is RefreshMaterial){
                    context.read<ServiceBloc>().add(
                        FetchMaterial(searchQuery: null));
                  }
                },
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: Loading_Widget());
                  } else if (state is failerror) {
                    return Text(state.error.toString());
                  } else if (state is Materialloaded) {
                    if (state.cloth.isEmpty) {
                      // Return "No data found" if txhe list is empty
                      return Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return SingleChildScrollView(
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
                            _buildColumn('Material Type'),
                            _buildColumn('All Materials'),
                            _buildColumn('Action'),
                          ],

                          rows: List.generate(
                            state.cloth.length,
                            (index) {
                              final cloth = state.cloth[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    (index + 1).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  //DataCell(Text(Cloth_data.All_Materials)),
                                  // DataCell(Text(cloth.material_id.toString())),
                                  DataCell(
                                      Text(cloth.material_type.toString())),
                                  DataCell(
                                      Text(cloth.material_name.toString())),

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
                                                  width: 700,
                                                  height:
                                                      400, // Adjust size as needed
                                                  child:
                                                      EditMaterial(), // Embedding ServiceEdit Widget
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
                                          onPressed: ()  {context.read<ServiceBloc>().add(
                                              DeleteMaterial(
                                                  id: cloth.material_id));},
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
                    );
                  }
                  return SizedBox();
                },
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
