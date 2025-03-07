
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Model/Instructions_Model/Bag_Inst_Model.dart';
import '../../../../Model/Instructions_Model/Shoe_Inst_Model.dart';


class ShoesInstructions extends StatefulWidget {
  const ShoesInstructions({super.key});

  @override
  State<ShoesInstructions> createState() => _ShoesInstructionsState();
}

class _ShoesInstructionsState extends State<ShoesInstructions> {
  List<Shoes_instruction> bag = [

    Shoes_instruction(
        Id: "",
        All_Materials: "Leather"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Canvas"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Nylon"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Polyster"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Wool"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Jute"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Denim"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Satin"),
    Shoes_instruction(
        Id: "",
        All_Materials: "Synthetic Leather"),

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
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bag Instructions",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 18,
                ),
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
                      hintText: 'Search Instructions',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 21,
                      ),
                    ),
                  ),
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
                      _buildColumn('All Instructions'),
                      _buildColumn('Action'),
                    ],

                    rows: List.generate(
                      bag.length,
                          (index) {
                        final Bag_data = bag[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              (index + 1).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),

                            DataCell(Text(Bag_data.All_Materials)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
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
