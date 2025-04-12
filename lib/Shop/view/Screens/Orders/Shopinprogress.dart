import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import 'Shopallorderwrapper.dart';

class Shopinprogresswrapper extends StatelessWidget {
  const Shopinprogresswrapper(this.shopid, {super.key});
  final shopid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(Fetchorders(
            searchQuery: null, status: "1", Deliverd: "0", shopid: shopid)),
      child: Shop_Inprogress(),
    );
  }
}

class Shop_Inprogress extends StatefulWidget {
  const Shop_Inprogress({super.key});

  @override
  State<Shop_Inprogress> createState() => _Shop_InprogressState();
}

class _Shop_InprogressState extends State<Shop_Inprogress> {
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
                              child: Text(
                                  order.status == "0"
                                      ? " Pending"
                                      : order.status == "1"
                                          ? "In Progress"
                                          : order.status == "2"
                                              ? "Cancelled Order"
                                              : order.PIckup == "0"
                                                  ? "Waiting for Pick Up"
                                                  : order.PIckup == "1"
                                                      ? "Order Picked"
                                                      : order.workinprogress ==
                                                              "1"
                                                          ? "In  Progress"
                                                          : order.workinprogress ==
                                                                  "2"
                                                              ? "Completed"
                                                              : order.Delivered ==
                                                                      "1"
                                                                  ? "Delivery Completed"
                                                                  : "Completed",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: order.status == "0"
                                          ? Colors.grey
                                          : order.status == "1"
                                              ? Colors.blue
                                              : order.status == "2"
                                                  ? Colors.red
                                                  : order.PIckup == "0"
                                                      ? Colors.orange
                                                      : order.PIckup == "1"
                                                          ? Colors.orange
                                                          : order.PIckup == "2"
                                                              ? Colors
                                                                  .blue.shade900
                                                              : order.workinprogress ==
                                                                      "2"
                                                                  ? Colors.blue
                                                                      .shade900
                                                                  : order.Delivered ==
                                                                          "1"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey)),
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
                                order.status == "1"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          DropdownButton<String>(
                                            value: orderStatus,
                                            items: [
                                              "Working Progress",
                                              "Working Completed"
                                            ].map((String status) {
                                              return DropdownMenuItem(
                                                value: status,
                                                child: Text(
                                                  status,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        status == "In Progress"
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newStatus) {
                                              setState(() {
                                                orderStatus = newStatus!;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                order.PIckup == "1" || order.PIckup == "2"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                if (orderStatus ==
                                                    "Working Progress") {
                                                  context.read<OrderBloc>()
                                                    ..add(Updateworkingprogress(
                                                        pickup: "2",
                                                        orderid: order.orderid,
                                                        Progress: "1"));
                                                }
                                                if (orderStatus ==
                                                    "Working Completed") {
                                                  context.read<OrderBloc>()
                                                    ..add(Updateworkingprogress(
                                                        pickup: "2",
                                                        orderid: order.orderid,
                                                        Progress: "2"));
                                                }
                                              },
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      )
                                    : SizedBox(),

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
