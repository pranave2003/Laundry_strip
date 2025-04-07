// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../Controller/bloc/Driverbloc/driverbloc_bloc.dart';
// import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
// import '../../../../Controller/bloc/Driverbloc/driverbloc_state.dart';
// import '../../../../Widget/constands/colors.dart';
// import 'Driver_Add.dart';
// import 'edit_driver.dart';
//
// class AllDriversPage extends StatefulWidget {
//   const AllDriversPage({super.key});
//
//   @override
//   State<AllDriversPage> createState() => _AllDriversPageState();
// }
//
// class _AllDriversPageState extends State<AllDriversPage> {
//   String selectedFilter = "Active";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Navigate to the add driver page
//           await Navigator.of(context).push(
//             MaterialPageRoute(builder: (_) => const DriverAdd()),
//           );
//
//           // After returning, refresh the state using LoadDriverEvent()
//           // if (context.mounted) {
//           //   context
//           //       .read<DriverblocBloc>()
//           //       .add(FetchDrivers(status: true, searchQuery: "searchQuery"));
//           // }
//         },
//         child: const Icon(Icons.add),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Hello !",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             context.read<DriverblocBloc>().add(FetchDrivers(
//                                 status: true, searchQuery: "null"));
//                           },
//                           child: Text("refresh")),
//                       Text(
//                         "Cheers and Happy Activities ",
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 400,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(18)),
//                       child: TextField(
//                         onChanged: (value) {
//                           context.read<DriverblocBloc>().add(FetchDrivers(
//                               status: selectedFilter == "Active" ? true : false,
//                               searchQuery: value)); // Pass search query
//                         },
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(width: .5),
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                             borderSide: BorderSide(
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                           ),
//                           hintText: 'Search Driver',
//                           prefixIcon: const Icon(
//                             Icons.search,
//                             color: Colors.grey,
//                             size: 21,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         backgroundColor: Color(0xffD9D9D9),
//                         child: IconButton(
//                             onPressed: () {}, icon: Icon(Icons.person)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         backgroundColor: Color(0xffD9D9D9),
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.notification_add)),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 35,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Driver",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Center(
//             //   child: SizedBox(
//             //     width: 700,
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         Expanded(
//             //           child: DropdownButton<String>(
//             //             value: selectedFilter,
//             //             isExpanded: true,
//             //             underline: Stack(
//             //               children: [
//             //                 Container(
//             //                   height: 2,
//             //                   width: double.infinity,
//             //                   color: Colors.grey,
//             //                 ),
//             //                 Container(
//             //                   height: 2,
//             //                   width: MediaQuery.of(context).size.width * 0.4,
//             //                   color: Colors.blue,
//             //                 ),
//             //               ],
//             //             ),
//             //             onChanged: (String? newValue) {
//             //               setState(() {
//             //                 selectedFilter = newValue!;
//             //                 print(selectedFilter);
//             //               });
//             //             },
//             //             items: [ "Active", "Inactive"]
//             //                 .map<DropdownMenuItem<String>>((String value) {
//             //               return DropdownMenuItem<String>(
//             //                 value: value,
//             //                 child: Text(value),
//             //               );
//             //             }).toList(),
//             //           ),
//             //         ),
//             //         const SizedBox(width: 20),
//             //         ElevatedButton.icon(
//             //           // onPressed: () {
//             //           //   showDialog(
//             //           //     context: context,
//             //           //     builder: (context) {
//             //           //       return AlertDialog(
//             //           //         backgroundColor: Colors.white,
//             //           //         content: SizedBox(
//             //           //           width: 700,
//             //           //           height: 600,
//             //           //           child: DriverAdd(),
//             //           //         ),
//             //           //         actions: [
//             //           //           TextButton(
//             //           //             onPressed: () {
//             //           //               Navigator.of(context).pop();
//             //           //             },
//             //           //             child: Text("Cancel"),
//             //           //           ),
//             //           //         ],
//             //           //       );
//             //           //     },
//             //           //   );
//             //           // },
//             //           onPressed: () async {
//             //             // Navigate to the add driver page
//             //             await Navigator.of(context).push(
//             //               MaterialPageRoute(builder: (_) => const DriverAdd()),
//             //             );
//             //
//             //             // After returning, refresh the state using LoadDriverEvent()
//             //             // if (context.mounted) {
//             //             //   context.read<DriverblocBloc>().add(FetchDrivers(
//             //             //       status: true, searchQuery: "searchQuery"));
//             //             // }
//             //           },
//             //           style: ElevatedButton.styleFrom(
//             //             backgroundColor: defaultColor,
//             //             shape: RoundedRectangleBorder(
//             //               borderRadius: BorderRadius.circular(8),
//             //             ),
//             //           ),
//             //           icon: Icon(Icons.add, color: Colors.white),
//             //           label: Text(
//             //             "Add",
//             //             style: TextStyle(
//             //                 fontWeight: FontWeight.bold, color: Colors.white),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             Center(
//               child: SizedBox(
//                 width: 700,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: DropdownButton<String>(
//                         value: selectedFilter,
//                         isExpanded: true,
//                         underline: Stack(
//                           children: [
//                             Container(
//                               height: 2,
//                               width: double.infinity,
//                               color: Colors.grey,
//                             ),
//                             Container(
//                               height: 2,
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               color: Colors.blue,
//                             ),
//                           ],
//                         ),
//                         onChanged: (String? newValue) {
//                           if (newValue != null) {
//                             setState(() {
//                               selectedFilter = newValue;
//                               print(selectedFilter);
//
//                               // ✅ Fetch drivers based on selected status
//                               context.read<DriverblocBloc>().add(
//                                     FetchDrivers(
//                                       status:
//                                           newValue == "Active" ? true : false,
//                                       searchQuery: null,
//                                     ),
//                                   );
//                             });
//                           }
//                         },
//                         items: ["Active", "Inactive"]
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     ElevatedButton.icon(
//                       onPressed: () async {
//                         await Navigator.of(context).push(
//                           MaterialPageRoute(builder: (_) => const DriverAdd()),
//                         );
//
//                         // ✅ After adding, refresh the state
//                         if (context.mounted) {
//                           context.read<DriverblocBloc>().add(
//                                 FetchDrivers(
//                                   status:
//                                       selectedFilter == "Active" ? true : false,
//                                   searchQuery: null,
//                                 ),
//                               );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: defaultColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       icon: Icon(Icons.add, color: Colors.white),
//                       label: Text(
//                         "Add",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//             BlocConsumer<DriverblocBloc, DriverblocState>(
//               listener: (context, state) {
//                 if (state is DriverSuccess) {
//                   context
//                       .read<DriverblocBloc>()
//                       .add(FetchDrivers(status: true, searchQuery: "null"));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is DriverLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is DriverFailure) {
//                   return Center(child: Text("${state.error}"));
//                 } else if (state is Driverloaded) {
//                   if (state.Drivers.isEmpty) {
//                     // Return "No data found" if the list is empty
//                     return Center(
//                       child: Text(
//                         "No data found",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }
//                   return Expanded(
//                     child: Center(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(maxWidth: 700),
//                         child: ListView.builder(
//                           itemCount: state.Drivers.length,
//                           itemBuilder: (context, index) {
//                             final driver = state.Drivers[index];
//
//                             return state.Drivers.isEmpty
//                                 ? Center(child: Text("Nodata"))
//                                 : Card(
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 4),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     color: Colors.grey[100],
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 30,
//                                             backgroundColor:
//                                                 Colors.grey.shade300,
//                                             // backgroundImage:
//                                             //     ? NetworkImage(driver.image)
//                                             //     : null,
//                                           ),
//                                           const SizedBox(width: 10),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(driver.name,
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 18)),
//                                                 Text(
//                                                     "Phone No: ${driver.phone}"),
//                                                 Text(
//                                                     "Email Id: ${driver.email}"),
//                                                 Text(
//                                                     "Driver ID: ${driver.driverId}"),
//                                               ],
//                                             ),
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.circle,
//                                                     color: driver.isActive
//                                                         ? Colors.green
//                                                         : Colors.red,
//                                                     size: 12,
//                                                   ),
//                                                   const SizedBox(width: 4),
//                                                   Text(
//                                                     driver.isActive
//                                                         ? "Active"
//                                                         : "Inactive",
//                                                     style: TextStyle(
//                                                       color: driver.isActive
//                                                           ? Colors.black
//                                                           : Colors.black,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 15),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   IconButton(
//                                                     onPressed: () {
//                                                       showDialog(
//                                                         context: context,
//                                                         builder: (context) {
//                                                           return AlertDialog(
//                                                             backgroundColor:
//                                                                 Colors.white,
//                                                             //title: Text("Edit Service"),
//                                                             content: SizedBox(
//                                                               width: 700,
//                                                               height:
//                                                                   600, // Adjust size as needed
//                                                               child:
//                                                                   DriverEdit(), // Embedding ServiceEdit Widget
//                                                             ),
//                                                             actions: [
//                                                               TextButton(
//                                                                 onPressed: () {
//                                                                   Navigator.of(
//                                                                           context)
//                                                                       .pop(); // Close dialog
//                                                                 },
//                                                                 child: Text(
//                                                                     "Cancel"),
//                                                               ),
//                                                             ],
//                                                           );
//                                                         },
//                                                       );
//                                                     },
//                                                     icon: Icon(
//                                                       Icons.edit_outlined,
//                                                       color: Colors.lightGreen,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 5),
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         context
//                                                             .read<
//                                                                 DriverblocBloc>()
//                                                             .add(DeleteDriver(
//                                                                 id: driver
//                                                                     .driverId));
//                                                       },
//                                                       icon: Icon(
//                                                         Icons.delete,
//                                                         color: Colors.red,
//                                                       )),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//                 return SizedBox();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
