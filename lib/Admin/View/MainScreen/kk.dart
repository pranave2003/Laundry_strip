// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: AdminPage(),
//     );
//   }
// }
//
// class AdminPage extends StatefulWidget {
//   const AdminPage({super.key});
//
//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }
//
// class _AdminPageState extends State<AdminPage> {
//   Widget? _selectedPage; // Variable to hold the currently selected page
//   String? _selectedTile; // Tracks the selected tile
//   String? _expandedTile;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _selectedPage = Dashboard();
//     _selectedTile = "Dashboard";
//     super.initState();
//   }
//
//   var mainExpansionSelectedColor = Colors.blue;
//   var SubExpansionSelectedColor = Colors.pink;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   title: const Text(
//       //     'Encrypta',
//       //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
//       //   ),
//       //   backgroundColor: Colors.grey[300],
//       //   automaticallyImplyLeading: false,
//       //   actions: [
//       //     IconButton(
//       //       onPressed: () {},
//       //       icon: const Icon(Icons.circle_notifications),
//       //     ),
//       //     IconButton(
//       //       onPressed: () {},
//       //       icon: const Icon(Icons.settings_rounded),
//       //     ),
//       //     CircleAvatar(),
//       //   ],
//       // ),
//       body: Row(
//         children: [
//           // Left side: Management options
//           Container(
//             color: Colors.grey[300],
//             width: 300,
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               children: [
//                 Container(
//                   width: 300,
//                   height: 100,
//                   color: Colors.white,
//                   child: Text(
//                     "Laundry Mate",
//                     style: TextStyle(color: Colors.blue, fontSize: 40),
//                   ),
//                 ),
//                 // //////////////////////
//                 _buildMainListTile('Dashboard', const Dashboard(), 16,
//                     icon: Icons.dashboard),
//                 // /////////////////////////
//
//                 _buildMainExpansionTile(
//                   title: 'Service Management',
//                   icon: Icons.person,
//                   children: [
//                     _buildESubxpansion(title: "Material Types", children: [
//                       _buildSubListTile(
//                         'Cloth Material',
//                         const CloathMeterial(),
//                       ),
//                       _buildSubListTile(
//                         'Shoe Material',
//                         const Test(),
//                       ),
//                       _buildSubListTile(
//                         'Bag Material',
//                         const Test(),
//                       ),
//                     ]),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Right side: Display selected page or add role form
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               child: _selectedPage ??
//                   Center(
//                     child: const Text('Select a management option'),
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMainExpansionTile({
//     required String title,
//     IconData? icon, // Made optional
//     required List<Widget> children,
//     e,
//   }) {
//     return ExpansionTile(
//       textColor: mainExpansionSelectedColor,
//       iconColor: mainExpansionSelectedColor,
//       leading: Icon(
//         icon,
//       ), // Show icon only if it's provided
//       shape: const RoundedRectangleBorder(side: BorderSide.none),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 17),
//       ),
//       childrenPadding: EdgeInsets.zero,
//       initiallyExpanded: _expandedTile == title,
//       onExpansionChanged: (isExpanded) {
//         setState(() {
//           _expandedTile = isExpanded ? title : null; // Collapse other tiles
//         });
//       },
//       children: children,
//     );
//   }
//
//   Widget _buildESubxpansion({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return ExpansionTile(
//       textColor: SubExpansionSelectedColor,
//       iconColor: SubExpansionSelectedColor,
//       leading: Icon(
//         null,
//       ), // Show icon only if it's provided
//       shape: const RoundedRectangleBorder(side: BorderSide.none),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 14),
//       ),
//       childrenPadding: EdgeInsets.zero,
//       initiallyExpanded: _expandedTile == title,
//       onExpansionChanged: (isExpanded) {
//         setState(() {
//           _expandedTile = isExpanded ? title : null; // Collapse other tiles
//         });
//       },
//       children: children,
//     );
//   }
//
//   Widget _buildMainListTile(String title, Widget page, double fontSize,
//       {IconData? icon}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         leading: icon != null
//             ? Icon(icon,
//                 color: _selectedTile == title ? Colors.blue[400] : Colors.black)
//             : null,
//         title: Text(
//           title,
//           style: TextStyle(
//               fontSize: fontSize,
//               color: _selectedTile == title
//                   ? Colors.blue[400]
//                   : Colors.black), // Correct fontSize usage
//         ),
//         onTap: () {
//           setState(() {
//             _selectedPage = page; // Set the selected page
//             _selectedTile = title; // Set the selected tile
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _buildSubListTile(
//     String title,
//     Widget page,
//   ) {
//     return Container(
//       // decoration: BoxDecoration(
//       //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
//       //   // borderRadius: BorderRadius.circular(10),
//       // ),
//       child: ListTile(
//         leading: SizedBox(
//           width: 40,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//               fontSize: 10,
//               color: _selectedTile == title
//                   ? Colors.blue[400]
//                   : Colors.black), // Correct fontSize usage
//         ),
//         onTap: () {
//           setState(() {
//             _selectedPage = page; // Set the selected page
//             _selectedTile = title; // Set the selected tile
//           });
//         },
//       ),
//     );
//   }
// }
//
// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//     );
//   }
// }
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//     );
//   }
// }
//
// class Servicetype extends StatefulWidget {
//   const Servicetype({super.key});
//
//   @override
//   State<Servicetype> createState() => _ServicetypeState();
// }
//
// class _ServicetypeState extends State<Servicetype> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//     );
//   }
// }
//
// class CloathMeterial extends StatefulWidget {
//   const CloathMeterial({super.key});
//
//   @override
//   State<CloathMeterial> createState() => _CloathMeterialState();
// }
//
// class _CloathMeterialState extends State<CloathMeterial> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Cloth material'),
//       ),
//     );
//   }
// }
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
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
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
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
//                         BoxDecoration(borderRadius: BorderRadius.circular(18)),
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
//                               BorderSide(color: Theme.of(context).primaryColor),
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
//                         MediaQuery.of(context).size.width, // Ensures full width
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
//                       (index) {
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
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ElevatedButton(
//                                     style: ButtonStyle(
//                                       backgroundColor: MaterialStatePropertyAll(
//                                           Color(0xff0A71CB)),
//                                       foregroundColor: MaterialStatePropertyAll(
//                                           Colors.white),
//                                       textStyle: MaterialStatePropertyAll(
//                                           TextStyle(fontSize: 16)),
//                                       padding: MaterialStatePropertyAll(
//                                           EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 12)),
//                                       shape: MaterialStatePropertyAll(
//                                           RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8))),
//                                     ),
//                                     onPressed: () {
//                                       // Your button's onPressed logic here
//                                     },
//                                     child: SizedBox(
//                                         width: 70,
//                                         child: Center(child: Text("Edit"))),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ElevatedButton(
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStatePropertyAll(Colors.red),
//                                       foregroundColor: MaterialStatePropertyAll(
//                                           Colors.white),
//                                       textStyle: MaterialStatePropertyAll(
//                                           TextStyle(fontSize: 16)),
//                                       padding: MaterialStatePropertyAll(
//                                           EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 12)),
//                                       shape: MaterialStatePropertyAll(
//                                           RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8))),
//                                     ),
//                                     onPressed: () {
//                                       // Your button's onPressed logic here
//                                       print("Button pressed!");
//                                     },
//                                     child: SizedBox(
//                                         width: 70,
//                                         child: Center(child: Text("Delete"))),
//                                   ),
//                                 ),
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
//
// class Student {
//   final String University_name;
//   final String Country;
//   final String Type;
//   final String Established;
//   final String Image;
//   final String Id;
//
//   Student({
//     required this.University_name,
//     required this.Country,
//     required this.Type,
//     required this.Established,
//     required this.Image,
//     required this.Id,
//   });
//
//   factory Student.fromJson(Map<String, String> json) {
//     return Student(
//         University_name: json["name"] ?? "",
//         Country: json["email"] ?? "",
//         Type: json["trade"] ?? "",
//         Established: json["location"] ?? "",
//         Image: json["linkedin"] ?? "",
//         Id: json["github"] ?? "");
//   }
// }
//
// List<Student> students = [
//   Student(
//       University_name: "Calicut University",
//       Country: "India",
//       Type: "Public",
//       Established: "2003",
//       Image: "png",
//       Id: "342342"),
//   Student(
//       University_name: "Calicut University",
//       Country: "India",
//       Type: "Public",
//       Established: "2003",
//       Image: "png",
//       Id: "342342"),
//   Student(
//       University_name: "Calicut University",
//       Country: "India",
//       Type: "Public",
//       Established: "2003",
//       Image: "png",
//       Id: "342342"),
//   Student(
//       University_name: "Calicut University",
//       Country: "India",
//       Type: "Public",
//       Established: "2003",
//       Image: "png",
//       Id: "342342"),
// ];
