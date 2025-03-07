import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Admin/View/Screens/Service_Managment/Service_Category/Edit_Category.dart';
import '../../../Widget/constands/colors.dart';
import '../../Testt.dart';
import '../Screens/Dashboard/DasgboardMain.dart';
import '../Screens/Service_Managment/Material_type/Add_bag_material.dart';
import '../Screens/Service_Managment/Material_type/Cloth_material.dart';
import '../Screens/Service_Managment/Material_type/Bag_material.dart';
import '../Screens/Service_Managment/Material_type/Edit_bag_material.dart';
import '../Screens/Service_Managment/Material_type/Shoe_material.dart';
import '../Screens/Service_Managment/Service_Category/Add_Category.dart';
import '../Screens/Service_Managment/Service_Category/View_Category.dart';
import '../Screens/Service_Managment/Servicetype/Edit_Service.dart';
import '../Screens/Service_Managment/Servicetype/Service_Add.dart';
import '../Screens/Service_Managment/Servicetype/Service_type.dart';
import '../Screens/Service_Managment/Special_instruction/Bag_Instructions.dart';
import '../Screens/Service_Managment/Special_instruction/Cloth_Instructions.dart';
import '../Screens/Service_Managment/Special_instruction/Shoe_Instructions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AdminPage());
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget? _selectedPage; // Variable to hold the currently selected page
  String? _selectedTile; // Tracks the selected tile
  String? _expandedTile;

  @override
  void initState() {
    // TODO: implement initState
    _selectedPage = Dasgboardmain();
    _selectedTile = "Dashboard";
    super.initState();
  }

  var mainExpansionSelectedColor = Colors.blue.shade900;
  var SubExpansionSelectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side: Management options
          Container(
            color: Colors.grey[300],
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),

                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/splash_logo.png",
                        width: 60,
                        height: 80,
                      ),
                      //SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to,",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          Row(children: [Text(
                            "Laundry Mate",
                            style: TextStyle(
                                fontSize: 28,
                                color: Secondary,
                                fontWeight: FontWeight.bold),
                          ),],)

                        ],
                      )
                    ],
                  ),
                ),
                // //////////////////////
                _buildMainListTile('Dashboard', const Dasgboardmain(),
                    icon: Icons.dashboard),
                // /////////////////////////

                _buildMainExpansionTile(
                  title: 'Service Management',
                  icon: Icons.person,
                  children: [
                    _buildESubxpansion(title: "Service Types", children: [
                      _buildSubListTile(
                        'View Services',
                        const ServiceType(),
                      ),
                      _buildSubListTile(
                        'Add Services',
                        const ServiceAdd(),
                      ),
                      _buildSubListTile(
                        'Edit Services',
                        const ServiceEdit(),
                      ),
                    ]),
                    _buildESubxpansion(title: " Service Category", children: [
                      _buildSubListTile(
                        'View Category',
                        const ServiceCategory(),
                      ),
                      _buildSubListTile(
                        'Add Category',
                        const CategoryAdd(),
                      ),
                      _buildSubListTile(
                        'Edit Category',
                        const CategoryEdit(),
                      ),
                    ]),
                    _buildESubxpansion(title: "Material Types", children: [
                      _buildSubListTile(
                        'Cloth Material',
                        const ClothMaterial(),
                      ),
                      _buildSubListTile(
                        'Add Cloth Material',
                        const ClothMaterial(),
                      ),
                      _buildSubListTile(
                        'Edit Cloth Material',
                        const ClothMaterial(),
                      ),
                      _buildSubListTile(
                        'Shoes Material',
                        const ShoeMaterial(),
                      ),
                      _buildSubListTile(
                        'Add Shoes Material',
                        const ShoeMaterial(),
                      ),
                      _buildSubListTile(
                        'Edit Shoes Material',
                        const ShoeMaterial(),
                      ),
                      _buildSubListTile(
                        'Bag Material',
                        const BagMaterial(),
                      ),
                      _buildSubListTile(
                        'Add Bag Material',
                        const BagMaterialAdd(),
                      ),
                      _buildSubListTile(
                        'Edit Bag Material',
                        const EditBagMaterial(),
                      ),
                    ]),
                    _buildESubxpansion(
                        title: "Special Instructions",
                        children: [
                          _buildSubListTile(
                            'Cloth Instructions',
                            const ClothInstructions(),
                          ),
                          _buildSubListTile(
                            'Shoe Instructions',
                            const BagInstructions(),
                          ),
                          _buildSubListTile(
                            'Shoe Instructions',
                            const ShoesInstructions(),
                          ),
                        ]),
                  ],
                ),

                _buildMainExpansionTile(
                  title: 'Order Management',
                  icon: Icons.shopping_cart_rounded,
                  children: [
                    SubListTile(
                      'All Orders',
                      const ClothMaterial(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Right side: Display selected page or add role form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: _selectedPage ??
                  Center(
                    child: const Text('Select a management option'),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainExpansionTile({
    required String title,
    IconData? icon, // Made optional
    required List<Widget> children,
    e,
  }) {
    return ExpansionTile(
      textColor: mainExpansionSelectedColor,
      iconColor: mainExpansionSelectedColor,
      leading: Icon(
        icon,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildESubxpansion({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      textColor: SubExpansionSelectedColor,
      iconColor: SubExpansionSelectedColor,
      leading: Icon(
        null,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildMainListTile(String title, Widget page, {IconData? icon}) {
    return Container(
      // decoration: BoxDecoration(
      //   color: _selectedTile == title ? Colors.grey.shade50 : Colors.transparent,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: icon != null
            ? Icon(icon,
                color: _selectedTile == title ? Colors.blue[900] : Colors.black)
            : null,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              color: _selectedTile == title
                  ? Colors.blue[900]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }

  Widget _buildSubListTile(
    String title,
    Widget page,
  ) {
    return Container(
        // decoration: BoxDecoration(
        //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
        //   // borderRadius: BorderRadius.circular(10),
        // ),
        child: InkWell(
      onTap: () {
        setState(() {
          _selectedPage = page; // Set the selected page
          _selectedTile = title; // Set the selected tile
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: _selectedTile == title
                      ? Colors.blue[400]
                      : Colors.black), // Correct fontSize usage
            ),
          ),
        ],
      ),
    ));
  }

  Widget SubListTile(
    String title,
    Widget page,
  ) {
    return Container(
      // decoration: BoxDecoration(
      //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
      //   // borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: SizedBox(
          width: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: _selectedTile == title
                  ? Colors.blue[400]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }
}
