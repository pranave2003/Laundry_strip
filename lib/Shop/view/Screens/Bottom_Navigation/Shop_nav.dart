import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Driver/delivery.dart';
import 'package:laundry/Shop/view/Screens/Orders/Orders.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import '../../../../User/view/Screens/Home/home_page.dart';
import '../../../../Widget/constands/colors.dart';
import '../Driver/assign_driver.dart';
import '../Driver/assign_order.dart';
import '../Home/Shop_home.dart';
import '../Orders/order_details.dart';
import '../QRscan/Scan_QR.dart';
import '../Shop/Add_shop.dart';




class Shop_Navigation extends StatefulWidget {
  @override
  _Shop_NavigationState createState() => _Shop_NavigationState();
}

class _Shop_NavigationState extends State<Shop_Navigation> {
  int _currentIndex = 0; // Track the selected page

  final List<Widget> _pages = [
    ShopHome(),
    Shop_Add(),
    Orders(),
    ScanQr(), // Change this to OrdersPage
    OrderAssignPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Bottom Navigation Example")),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.white,
        selectedItemColor: defaultColor,  // Selected label color
        unselectedItemColor: Colors.black, // Unselected label color
        showUnselectedLabels: true,// Unselected label color
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected page
          });
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Make selected text bold
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Keep unselected text normal
        items: [
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/home.png"), label: "Home"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/shop_icon.png"), label: "Shop"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/shop_order.png"), label: "Orders"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/shop_qr.png"), label: "QR Scan"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/shop_delivery.png"), label: "Delivery"),



        ],
      ),
    );
  }
}










