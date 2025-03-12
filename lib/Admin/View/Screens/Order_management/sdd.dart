// import 'package:flutter/material.dart';
//
// class University_main extends StatefulWidget {
//   const University_main({super.key});
//
//   @override
//   State<University_main> createState() => _University_mainState();
// }
//
// class _University_mainState extends State<University_main> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 25),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Welcome ",
//                       style:
//                       TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       "Admin, ",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff0A71CB)),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 400,
//                     decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(18)),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(width: .5),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(18),
//                           borderSide:
//                           BorderSide(color: Theme.of(context).primaryColor),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 5,
//                         ),
//                         hintText: 'Search University',
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                           size: 21,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       backgroundColor: Color(0xffD9D9D9),
//                       child: IconButton(
//                           onPressed: () {}, icon: Icon(Icons.person)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       backgroundColor: Color(0xffD9D9D9),
//                       child: IconButton(
//                           onPressed: () {}, icon: Icon(Icons.notification_add)),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "University Management",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   width: 18,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "ADD University",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                         Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                     height: 50,
//                     width: 280,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xff0A71CB)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               // Background color
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minWidth:
//                     MediaQuery.of(context).size.width, // Ensures full width
//                   ),
//                   child: DataTable(
//                     // border: TableBorder(
//                     //   verticalInside: BorderSide(
//                     //       color: Colors.black,
//                     //       width: 1), // Vertical line between columns
//                     //   horizontalInside: BorderSide(
//                     //       color: Colors.grey, width: 0.5), // Horizontal lines
//                     // ),
//                     decoration: BoxDecoration(color: Colors.white),
//                     columns: [
//                       _buildColumn('University Name'),
//                       _buildColumn('country'),
//                       _buildColumn('Type'),
//                       _buildColumn('Established'),
//                       _buildColumn('Edit/Delete'),
//                     ],
//
//                     rows: List.generate(
//                       students.length,
//                           (index) {
//                         final student = students[index];
//                         return DataRow(
//                           cells: [
//                             DataCell(Text(
//                               student.University_name,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )),
//                             DataCell(Text(student.Country)),
//                             DataCell(Text(student.Type)),
//                             DataCell(Text(student.Established)),
//                             DataCell(Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   iconSize: 40.0,
//                                   onPressed: () {
//                                     print('Delete button pressed');
//                                   },),
//                               ],
//                             )),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   DataColumn _buildColumn(String title) {
//     return DataColumn(
//       label: Text(
//         title,
//         style: TextStyle(
//             color: Colors.grey.shade900,
//             fontWeight: FontWeight.bold,
//             fontSize: 20),
//       ),
//     );
//   }
// }