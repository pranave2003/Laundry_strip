import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import 'order_details.dart';

class Shopallorderwrapper extends StatelessWidget {
  const Shopallorderwrapper(this.shopid, {super.key});
  final shopid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(Fetchorders(searchQuery: null, shopid: shopid, status: "0")),
      child: Shop_Allorders(shop: shopid),
    );
  }
}

class Shop_Allorders extends StatefulWidget {
  const Shop_Allorders({super.key, required this.shop});
  final shop;

  @override
  State<Shop_Allorders> createState() => _Shop_AllordersState();
}

String orderStatus = "Working Progress";

class _Shop_AllordersState extends State<Shop_Allorders> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is orderRefresh) {
          context.read<OrderBloc>()
            ..add(Fetchorders(searchQuery: null, shopid: widget.shop));
        }
      },
      builder: (context, state) {
        if (state is orderfetchloading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrderLoaded) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              var order = state.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 4),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: Text(
                      //       order.PIckup == "1"
                      //           ? "Picked"
                      //           : order.status == "0"
                      //               ? "Pending"
                      //               : order.status == "1"
                      //                   ? "Accept the order"
                      //                   : "Rejected",
                      //       style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //           color: order.PIckup == "1"
                      //               ? Colors.orange
                      //               : order.status == "0"
                      //                   ? Colors.grey
                      //                   : order.status == "1"
                      //                       ? Colors.green
                      //                       : Colors.red)),
                      // ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                              // : order.PIckup == "0"
                              // ? "Waiting for Pick Up "
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text("Quantity: ${item.quantity}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade800)),
                                          Text("Price: ${item.price}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade800)),
                                          Text("Service: ${item.service}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade800)),
                                          Text("Category: ${item.catogoty}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade800)),
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
                          order.status == "1"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DropdownButton<String>(
                                      value: orderStatus,
                                      items: [
                                        "Working Progress",
                                        "Work_completed",
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
                          order.status == "1"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          // Navigator.push(context, MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return OrderDetailsPage(
                                          //       order: state.orders[index],
                                          //     );
                                          //   },
                                          // ));
                                          if (orderStatus ==
                                              "Working Progress") {
                                            context.read<OrderBloc>()
                                              ..add(Updateworkingprogress(
                                                  orderid: order.orderid,
                                                  pickup: "1",
                                                  Progress: "1"));
                                          } else if (orderStatus ==
                                              "Work_completed") {
                                            context.read<OrderBloc>()
                                              ..add(Updateworkingprogress(
                                                  orderid: order.orderid,
                                                  pickup: "1",
                                                  Progress: "2"));
                                          }
                                        },
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )
                              : SizedBox(),
                          Text("Customer Name: ${order.username}",
                              style: TextStyle(fontSize: 14)),
                          Text("Total Amount: \$${order.Totalcharge}",
                              style: TextStyle(fontSize: 14)),
                          Text("Delivery Address: ${order.deliveryaddress}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text("Total Items: ${order.items.length}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Divider(),
                          order.status == "0"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .green, // Green color for Accept
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8), // Box shape
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                        ),
                                        onPressed: () {
                                          context.read<OrderBloc>()
                                            ..add(Acceptorderevent(
                                                status: "1",
                                                orderid: order.orderid));
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .red, // Red color for Reject
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8), // Box shape
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                        ),
                                        onPressed: () {
                                          context.read<OrderBloc>()
                                            ..add(Acceptorderevent(
                                                status: "2",
                                                orderid: order.orderid));
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
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

// class Shop_Allorders extends StatelessWidget {
//   const Shop_Allorders({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<OrderBloc, OrderState>(
//       listener: (context, state) {
//         if (state is orderRefresh) {
//           context.read<OrderBloc>()..add(Fetchorders(searchQuery: null));
//         }
//       },
//       builder: (context, state) {
//         if (state is orderfetchloading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is OrderLoaded) {
//           return ListView.builder(
//             itemCount: state.orders.length,
//             itemBuilder: (context, index) {
//               var order = state.orders[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 color: Colors.white,
//                 child: ExpansionTile(
//                   title: Row(
//                     children: [
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Service: ${order.orderid}",
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.grey)),
//                             const SizedBox(height: 4),
//                             Text("Order ID: ${order.orderid}",
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.black87)),
//                             Text("Order Date: ${order.Orderdate}",
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.black87)),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                             order.status == "0"
//                                 ? "Pending"
//                                 : order.status == "1"
//                                     ? "Accept the order"
//                                     : "Rejected",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: order.status == "0"
//                                     ? Colors.grey
//                                     : order.status == "1"
//                                         ? Colors.green
//                                         : Colors.red)),
//                       ),
//                     ],
//                   ),
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0, vertical: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: order.items.map((item) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 4.0),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Image.network(item.productimage,
//                                         width: 50,
//                                         height: 50,
//                                         fit: BoxFit.cover),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(item.productName,
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold)),
//                                           const SizedBox(height: 4),
//                                           Text("Quantity: ${item.quantity}",
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey.shade800)),
//                                           Text("Price: ${item.price}",
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey.shade800)),
//                                           Text("Service: ${item.service}",
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey.shade800)),
//                                           Text("Category: ${item.catogoty}",
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey.shade800)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) {
//                                         return OrderDetailsPage(
//                                           order: state.orders[index],
//                                         );
//                                       },
//                                     ));
//                                   },
//                                   child: Text(
//                                     "Manage Order",
//                                     style: TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold),
//                                   ))
//                             ],
//                           ),
//                           Text("Customer Name: ${order.username}",
//                               style: TextStyle(fontSize: 14)),
//                           Text("Total Amount: \$${order.Totalcharge}",
//                               style: TextStyle(fontSize: 14)),
//                           Text("Delivery Address: ${order.deliveryaddress}",
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.shade900,
//                                   fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 8),
//                           Text("Total Items: ${order.items.length}",
//                               style: TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.bold)),
//                           Divider(),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Colors.green, // Green color for Accept
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(8), // Box shape
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 12),
//                                   ),
//                                   onPressed: () {
//                                     context.read<OrderBloc>()
//                                       ..add(Acceptorderevent(
//                                           status: "1", orderid: order.orderid));
//                                   },
//                                   child: Text(
//                                     "Accept",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 SizedBox(width: 20),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Colors.red, // Red color for Reject
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(8), // Box shape
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 12),
//                                   ),
//                                   onPressed: () {
//                                     context.read<OrderBloc>()
//                                       ..add(Acceptorderevent(
//                                           status: "2", orderid: order.orderid));
//                                   },
//                                   child: Text(
//                                     "Reject",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         } else if (state is OrderFailure) {
//           return Center(child: Text("Error: ${state.message ?? ""}"));
//         }
//         return Container();
//       },
//     );
//   }
// }
