import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import 'order_details.dart';

class ShopiDeliverdwrapper extends StatelessWidget {
  const ShopiDeliverdwrapper(this.shopid, {super.key});
  final shopid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(Fetchorders(searchQuery: null, Deliverd: "1", shopid: shopid)),
      child: Deliverdshop(),
    );
  }
}

class Deliverdshop extends StatelessWidget {
  const Deliverdshop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is orderfetchloading) {
          return Center(child: Loading_Widget());
        } else if (state is OrderLoaded) {
          return state.orders.isEmpty
              ? Center(
                  child: Text("No data"),
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
                                  Text("Name: ${order.username}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text("Service: ${order.orderid}",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
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
                              // child: Text(
                              //     order.Delivered == "1"
                              //         ? "Delivered"
                              //         : "Progress",
                              //     style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.green)),
                                child:  Text(
                                  order.Delivered == "1"
                                      ? "Delivery Completed"
                                      : order.workinprogress == "2"
                                      ? "Completed"
                                      : order.workinprogress == "1"
                                      ? "In Progress"
                                      : order.PIckup == "2"
                                      ? "In Progress"
                                      : order.PIckup == "1"
                                      ? "Order Picked"
                                      : order.PIckup == "0"
                                      ? "Waiting for Pick Up "
                                      : order.status == "2"
                                      ? "Cancelled Order"
                                      : order.status == "1"
                                      ? "Confirm Order"
                                      : "Pending",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: order.Delivered == "1"
                                        ? Colors.green
                                        : order.workinprogress == "2"
                                        ? Colors.blue.shade900
                                        : order.workinprogress == "1"
                                        ? Colors.blue.shade900
                                        : order.PIckup == "2"
                                        ? Colors.blue.shade900
                                        : order.PIckup == "1"
                                        ? Colors.orange
                                        : order.PIckup == "0"
                                        ? Colors.orange
                                        : order.status == "2"
                                        ? Colors.red
                                        : order.status == "1"
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                )
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
                                          Image.asset(item.productimage,
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
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     TextButton(
                                //         onPressed: () {
                                //           Navigator.push(context,
                                //               MaterialPageRoute(
                                //             builder: (context) {
                                //               return OrderDetailsPage(
                                //                 order: state.orders[index],
                                //               );
                                //             },
                                //           ));
                                //         },
                                //         child: Text(
                                //           "Manage Order",
                                //           style: TextStyle(
                                //               color: Colors.red,
                                //               fontWeight: FontWeight.bold),
                                //         ))
                                //   ],
                                // ),

                                Text("Customer Name: ${order.username}",
                                    style: TextStyle(fontSize: 14)),
                                Text("Total Amount: \$${order.Totalcharge}",
                                    style: TextStyle(fontSize: 14)),
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
