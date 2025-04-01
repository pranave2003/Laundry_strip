import 'package:flutter/material.dart';

import '../../../../User/view/Screens/Bottom_navigation/btm_navigation.dart';
import '../../../../User/view/Screens/Orders/Order/Allorders.dart';
import '../../../../User/view/Screens/Orders/Order/CancelledOreder.dart';
import '../../../../User/view/Screens/Orders/Order/Deliverd.dart';
import '../../../../User/view/Screens/Orders/Order/inprogress.dart';
import '../Bottom_Navigation/Shop_nav.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}
class _OrdersState extends State<Orders> {
  int selectedIndex = 0;
  List<String> filters = ["All", "In Progress", "Delivered", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(filters.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? Colors.blue
                            : Colors.grey.shade200,
                        foregroundColor: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(filters[index]),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                Allorderswrapper(),
                Inprogresswrapper(),
                Deliverdwrrapper(),
                Cancelorderwrapper(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// class _OrdersState extends State<Orders> {
//   String selectedFilter = "All"; // Default selection
//
//   final List<Map<String, dynamic>> orders = [
//     {
//       "name": "Amal",
//       "phone": "8962147896",
//       "orderId": "8547 9658 2578",
//       "orderDate": "Jan 03, 2025",
//       "amount": "₹ 350.00",
//       "status": "In Progress",
//       "image": "assets/face_img/f1.png",
//     },
//     {
//       "name": "Sandra",
//       "phone": "9652478963",
//       "orderId": "7865 9658 2578",
//       "orderDate": "Jan 05, 2025",
//       "amount": "₹ 550.00",
//       "status": "Delivered",
//       "image": "assets/face_img/f2.png",
//     },
//     {
//       "name": "Pooja",
//       "phone": "8542147896",
//       "orderId": "7865 9658 2578",
//       "orderDate": "Jan 05, 2025",
//       "amount": "₹ 200.00",
//       "status": "Cancelled",
//       "image": "assets/face_img/f3.png",
//     },
//     {
//       "name": "Sachind",
//       "phone": "9652478963",
//       "orderId": "7865 9658 2578",
//       "orderDate": "Jan 05, 2025",
//       "amount": "₹ 550.00",
//       "status": "Delivered",
//       "image": "assets/face_img/f4.png",
//     },
//     {
//       "name": "Sandra",
//       "phone": "9652478963",
//       "orderId": "7865 9658 2578",
//       "orderDate": "Jan 05, 2025",
//       "amount": "₹ 550.00",
//       "status": "Cancelled",
//       "image": "assets/face_img/f5.png",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> filteredOrders = selectedFilter == "All"
//         ? orders
//         : orders.where((order) => order["status"] == selectedFilter).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Orders",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//          automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           // Filter Tabs
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: ["All", "In Progress", "Delivered", "Cancelled"]
//                   .map((status) => _buildFilterButton(status))
//                   .toList(),
//             ),
//           ),
//
//           SizedBox(height: 10),
//
//           // Order List
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredOrders.length,
//               itemBuilder: (context, index) {
//                 return _buildOrderCard(filteredOrders[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // **Filter Buttons**
//   Widget _buildFilterButton(String status) {
//     bool isSelected = selectedFilter == status;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedFilter = status;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Text(
//           status,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // **Order Card**
//   // **Order Card**
//   Widget _buildOrderCard(Map<String, dynamic> order) {
//     return InkWell(
//       onTap: () {
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrderDetailsPage(),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
//           ],
//         ),
//         child: Row(
//           children: [
//             // Profile Image
//             CircleAvatar(
//               radius: 30,
//               backgroundImage: AssetImage(order["image"]),
//             ),
//             SizedBox(width: 10),
//
//             // Order Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(order["name"],
//                       style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 2),
//                   Text("Phone No: ${order["phone"]}",
//                       style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//                   SizedBox(height: 2),
//                   Text("Order ID: ${order["orderId"]}",
//                       style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//                   SizedBox(height: 2),
//                   Text("Order Date: ${order["orderDate"]}",
//                       style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//                   SizedBox(height: 2),
//                   Text("Total Amount: ${order["amount"]}",
//                       style:
//                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//
//             // Status Badge
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: _getStatusColor(order["status"]).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Text(
//                 order["status"],
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: _getStatusColor(order["status"])),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// // **Define _getStatusColor Function**
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case "In Progress":
//         return Colors.orange;
//       case "Delivered":
//         return Colors.green;
//       case "Cancelled":
//         return Colors.red;
//       default:
//         return Colors.black;
//     }
//   }
//   }
