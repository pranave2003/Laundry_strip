import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../Order_tracking.dart';

class Allorderswrapper extends StatelessWidget {
  const Allorderswrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Example: If shopid is stored in user's displayName (change as needed)
    String? userid = user?.uid;
    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(Fetchorders(searchQuery: null, userid: userid, Deliverd: "0")),
      child: AllOrders(),
    );
  }
}

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is orderfetchloading) {
          return Center(child: Loading_Widget());
        } else if (state is OrderLoaded) {
          return state.orders.isEmpty
              ? Center(
                  child: Text("No Orders"),
                )
              : ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    var order = state.orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("shop: ${order.shopname}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text("Order ID: ${order.orderid}",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black87)),
                                  Text("Order Date: ${order.Orderdate}",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black87)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                  order.Delivered == "1"
                                      ? "Delivered"
                                      : order.workinprogress == "1"
                                          ? "In progress"
                                          : order.PIckup == "1"
                                              ? "Assign Driver"
                                              : order.Rejected == "1"
                                                  ? "Rejected by shop"
                                                  : order.status == "2"
                                                      ? "Cancelled"
                                                      : order.status == "1"
                                                          ? "Confirm order"
                                                          : "Pending",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: order.Delivered == "1"
                                          ? Colors.green
                                          : order.workinprogress == "1"
                                              ? Colors.blue.shade900
                                              : order.PIckup == "1"
                                                  ? Colors.orange
                                                  : order.Rejected == "1"
                                                      ? Colors.brown
                                                      : order.status == "2"
                                                          ? Colors.red
                                                          : order.status == "1"
                                                              ? Colors.blue
                                                              : Colors.grey)),
                            ),
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: order.items.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(item.productimage,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.productName,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Text(
                                                    "Quantity: ${item.quantity}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade800)),
                                                Text("Price: ${item.price}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade800)),
                                                Text("Service: ${item.service}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade800)),
                                                Text(
                                                    "Category: ${item.catogoty}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade800)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return OrderTracking(
                                                order: state.orders[index],
                                              );
                                            },
                                          ));
                                        },
                                        child: Text(
                                          "Click to more details",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                Text("Customer Name: ${order.username}",
                                    style: TextStyle(fontSize: 15)),
                                Text("Total Amount: \$${order.Totalcharge}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                                Text(
                                    "Delivery Address: ${order.deliveryaddress}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text("Total Items: ${order.items.length}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Divider(),
                                order.PIckup == "0"
                                    ? Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Confirm Cancellation"),
                                                    content: Text(
                                                        "Are you sure you want to cancel this order?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Perform order cancellation logic here
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                        },
                                                        child:
                                                            Text("Yes, Cancel"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Order Cancel"),
                                          )
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        } else if (state is OrderFailure) {
          return Center(child: Text("Error: ${state.message ?? ""}"));
        }
        return Container();
      },
    );
  }
}
