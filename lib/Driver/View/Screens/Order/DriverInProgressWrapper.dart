import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';

class DriverInProgressWrapper extends StatelessWidget {
  const DriverInProgressWrapper({super.key, required this.driverid});

  final driverid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      OrderBloc()
        ..add(Fetchorders(
          driverId: "uHeKwjOcLldt2gBQeZw51koDesz2",
          searchQuery: null,
        )),
      child: DriverInProgress(),
    );
  }
}

class DriverInProgress extends StatelessWidget {
  const DriverInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is orderRefresh) {
          context.read<OrderBloc>()
            ..add(Fetchorders(
              driverId: "uHeKwjOcLldt2gBQeZw51koDesz2",
              searchQuery: null,
            ));
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is orderfetchloading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrderLoaded) {
          return state.orders.isEmpty
              ? Center(
            child: Text("No data"),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(12),
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
                            order.status == "0" ? "Pending" : "Progress",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber)),
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
                                    Image.network(item.productimage,
                                        width: 50, height: 50, fit: BoxFit.cover),
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }return SizedBox();
      },
    );
  }
}
