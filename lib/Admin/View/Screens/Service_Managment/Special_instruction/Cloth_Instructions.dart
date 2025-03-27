
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';
import '../../../../Model/Instructions_Model/Bag_Inst_Model.dart';
import '../../../../Model/Instructions_Model/Cloth_Inst_Model.dart';
import '../../../../Model/Material_Model/Bag_Model.dart';
import '../../../../Model/Material_Model/Cloth_Model.dart';
import '../../../../Model/Service_Model/Service_Model.dart';
import '../../../../Model/Material_Model/Shoe_Model.dart';
import 'Add_cloth_instructions.dart';
import 'Edit_cloth_instructions.dart';

class InstructionWrapper extends StatelessWidget {
  const InstructionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()
        ..add(FetchInstruction(searchQuery: null)),
      child: ClothInstructions(),
    );
  }
}


class ClothInstructions extends StatefulWidget {
  const ClothInstructions({super.key});

  @override
  State<ClothInstructions> createState() => _ClothInstructionsState();
}

class _ClothInstructionsState extends State<ClothInstructions> {
  // List<Cloth_instruction> cloth = [
  //
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Wash Separately"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Machine Wash Cold"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Hand Wash"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Use Mild Detergent"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Do not Bleach"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Do Not Wring"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Do not Tumple Dry"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: "Hang Dry in Shade"),
  //   Cloth_instruction(
  //       Id: "",
  //       All_Materials: " Do not Soak"),
  //
  // ];

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
                        hintText: 'Search Instruction',
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
                  "Cloth Instruction",
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
                            return AlertDialog(backgroundColor: Colors.white,
                              content: SizedBox(
                                width: 700, height: 400,
                                child: ClothInstructionsAdd(),
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
            child: BlocConsumer<ServiceBloc, ServiceState>(
  listener: (context, state) {
    if(state is RefreshInstruction){
      context.read<ServiceBloc>().add(
          FetchInstruction(searchQuery: null));
    }
    // TODO: implement listener
  },
  builder: (context, state) {
    if (state is InstructionLoading) {
      return Center(child: Loading_Widget());
    } else if (state is Instructionfailerror) {
      return Text(state.error.toString());
    } else if (state is Instructionloaded) {
      if (state.instruction.isEmpty) {
        // Return "No data found" if txhe list is empty
        return Center(
          child: Text(
            "No data found",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }

      return Container(
        // Background color
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth:
              MediaQuery
                  .of(context)
                  .size
                  .width, // Ensures full width
            ),
            child: DataTable(

              decoration: BoxDecoration(color: Colors.white),
              columns: [
                _buildColumn('SI/NO'),
                _buildColumn('Instruction Type'),
                _buildColumn('All Instructions'),
                _buildColumn('Action'),
              ],

              rows: List.generate(
                state.instruction.length,
                    (index) {
                  final instruction = state.instruction[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        (index + 1).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),

                      DataCell(Text(instruction.instruction_type.toString())),
                      DataCell(Text(instruction.instruction_name.toString())),

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
                                      height: 400,
                                      // Adjust size as needed
                                      child: ClothInstructionsEdit(instructionid:
                                      instruction.instruction_id,
                                          instructionname:
                                          instruction.instruction_name,
                                          instructiontype: instruction
                                              .instruction_type),  // Embedding ServiceEdit Widget
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
                              onPressed: () {context.read<ServiceBloc>().add(
                                  DeleteInstruction(
                                      id: instruction.instruction_id));},
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
