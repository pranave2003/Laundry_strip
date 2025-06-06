import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';

class MyRevenuePage extends StatefulWidget {
  const MyRevenuePage({super.key});

  @override
  State<MyRevenuePage> createState() => _MyRevenuePageState();
}

class _MyRevenuePageState extends State<MyRevenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), // Greeting, Search Bar & Icons
            const SizedBox(height: 20),
            _buildRevenueHeading(), // New Revenue Heading
            const SizedBox(height: 15),
            _buildRevenueSummary(),
            const SizedBox(height: 20),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  // 🟢 Header Section (Greeting, Search Bar, & Icons)
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Section (Greeting)
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Cheers and Happy Activities",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        // Right Section (Search Bar & Icons)
        Row(
          children: [
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: .5),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  hintText: 'Search ',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 21),
                ),
              ),
            ),
            const SizedBox(width: 10),
            _iconButton(Icons.person), // Profile Icon
            _iconButton(Icons.notifications), // Notification Icon
          ],
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: const Color(0xffD9D9D9),
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }

  // 🟢 Revenue Heading
  Widget _buildRevenueHeading() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "Revenue",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🟢 Revenue Summary Section
  Widget _buildRevenueSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryCard("Total Revenue", "₹ 50,000", Colors.green),
        _summaryCard("Pending Payments", "₹ 8,000", Colors.orange),
        _summaryCard("Completed Payments", "₹ 42,000", Colors.blue),
      ],
    );
  }

  Widget _summaryCard(String title, String amount, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 Recent Transactions Section
  Widget _buildRecentTransactions() {
    return Expanded(
      child: Card(color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 5),
//               Expanded(
//                 child: BlocBuilder<OrderBloc, OrderState>(
//   builder: (context, state) {
//     if (state is orderfetchloading) {
//     return Center(child: Loading_Widget());
//     } else if (state is OrderLoaded) {
//       return state.orders.isEmpty
//           ? Center(
//         child: Text("No Orders"),
//       )
//       return ListView(
//         children: [
//           _transactionTile("Order #1234", "Completed", "₹ 1,500", Colors.green),
//           _transactionTile("Order #1235", "Pending", "₹ 800", Colors.orange),
//           _transactionTile("Order #1236", "Completed", "₹ 2,200", Colors.green),
//           _transactionTile("Order #1237", "Completed", "₹ 3,000", Colors.green),
//         ],
//       );
//     }
//     return SizedBox();
//   },
// ),
//               ),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is orderfetchloading) {
                      return Center(child: Loading_Widget());
                    } else if (state is OrderLoaded) {
                      if (state.orders.isEmpty) {
                        return Center(
                          child: Text("No Orders"),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];

                          // Determine the status text and color
                          String statusText = "Pending";
                          Color statusColor = Colors.orange;

                          if (order.Delivered == "1") {
                            statusText = "Delivered";
                            statusColor = Colors.green;
                          } else if (order.workinprogress == "1") {
                            statusText = "Work In Progress";
                            statusColor = Colors.orange;
                          } else if (order.PIckup == "1") {
                            statusText = "Picked Up";
                            statusColor = Colors.purple;
                          }
                          return Card( color: Colors.white,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: statusColor,
                                    child: const Icon(Icons.local_laundry_service, color: Colors.white),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Order #${order.orderid}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text("Shop: ${order.shopname}"),
                                        Text("Username: ${order.username}"),
                                        Text("Pickup: ${order.pickupdate} at ${order.pickupTime}"),
                                        Text("Delivery: ${order.Deliverydate} at ${order.DeliveryTime}"),
                                        Text(
                                          statusText,
                                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("Total", style: TextStyle(fontSize: 15, color: Colors.grey)),
                                      Text(
                                        "₹ ${order.Totalcharge}",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );


                    }

                    return SizedBox();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Widget _transactionTile(String orderId, String status, String amount, Color color) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 6),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 5,
  //           spreadRadius: 1,
  //         ),
  //       ],
  //     ),
  //     child: ListTile(
  //       contentPadding: EdgeInsets.zero,
  //       title: Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
  //       subtitle: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
  //       trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  //     ),
  //   );
  // }
}
