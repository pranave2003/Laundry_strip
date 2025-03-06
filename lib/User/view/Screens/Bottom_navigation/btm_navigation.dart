import 'package:flutter/material.dart';
import 'package:laundry/User/view/Screens/Services/select_service.dart';
import '../../../../Widget/constands/colors.dart';
import '../Home/home_page.dart';
import '../Orders/My_orders.dart';
import '../Profile/profilepage.dart';
import '../Services/service.dart';



class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0; // Track the selected page

  final List<Widget> _pages = [
    HomePage(),
    Service(),
    MyOrdersPage(), // Change this to OrdersPage
    ProfilePage(), // Corrected this to be ProfileScreen instead of HomePage
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
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/service.png"), label: "Service"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/order.png"), label: "Orders"),
          BottomNavigationBarItem(icon: Image.asset("assets/navigation_icon/profile.png"), label: "Profile"),



        ],
      ),
    );
  }
}



// class HomePagedemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Shop Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }
//
// class ServicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Scan Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }
// class OrdersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Orders Page', style: TextStyle(fontSize: 24)),
//     );
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }