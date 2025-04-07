import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';

import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Widget/constands/colors.dart';
import '../Driver_ScanQr/Driver_QRScan.dart';
import '../Home/Driver_home.dart';
import '../Order/All_Orders.dart';



class DriverBottomNavWrapper extends StatelessWidget {
  const DriverBottomNavWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverblocBloc()..add(FetchDriverDetailsById()),
      child: Driver_Navigation(),
    );
  }
}

class Driver_Navigation extends StatefulWidget {
  @override
  _Driver_NavigationState createState() => _Driver_NavigationState();
}

class _Driver_NavigationState extends State<Driver_Navigation> {
  int _currentIndex = 0; // Track the selected page

  final List<Widget> _pages = [
    DriverHome(),
    DriverScanQr(),
    DriverOrders(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Bottom Navigation Example")),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: defaultColor, // Selected label color
        unselectedItemColor: Colors.black, // Unselected label color
        showUnselectedLabels: true, // Unselected label color
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected page
          });
        },
        selectedLabelStyle:
        TextStyle(fontWeight: FontWeight.bold), // Make selected text bold
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal), // Keep unselected text normal
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/navigation_icon/home.png"),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/navigation_icon/shop_qr.png"),
              label: "QR Scan"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/navigation_icon/order.png"),
              label: "Orders"),
        ],
      ),
    );
  }
}
