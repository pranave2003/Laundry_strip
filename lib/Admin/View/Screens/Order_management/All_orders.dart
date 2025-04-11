import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../Model/Order_Model/Order_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selectedFilter = "All";

  // final List<Order> orders = [
  //   Order(
  //       orderId: "1A2",
  //       name: "Amal",
  //       orderedDate: "03 Jan 2025",
  //       pickupDate: "03 Jan 2025",
  //       deliveryDate: "03 Jan 2025",
  //       status: "In Progress"),
  //   Order(
  //       orderId: "2V4",
  //       name: "Arun",
  //       orderedDate: "05 Jan 2025",
  //       pickupDate: "05 Jan 2025",
  //       deliveryDate: "05 Jan 2025",
  //       status: "Cancelled"),
  //   Order(
  //       orderId: "3G1",
  //       name: "Pooja",
  //       orderedDate: "08 Jan 2025",
  //       pickupDate: "08 Jan 2025",
  //       deliveryDate: "08 Jan 2025",
  //       status: "Delivered"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello !",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cheers and Happy Activities ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18)),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: .5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          hintText: 'Search Orders',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.person)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notification_add)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            const Text(
              "Orders",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton("All"),
                _buildFilterButton("In Progress"),
                _buildFilterButton("Delivered"),
                _buildFilterButton("Cancelled"),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<OrderBloc, OrderState>(
  builder: (context, state) {
    if (state is orderverLoading) {
    return Center(child: Loading_Widget());
    } else if (state is orderFailure) {
    return Text(state.error.toString());
    } else if (state is OrderLoaded) {
      if (state.orders.isEmpty) {
// Return "No data found" if txhe list is empty
        return Center(
          child: Text(
            "No data found",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width),
              child: DataTable(
                columnSpacing: 10,
                columns: const [
                  DataColumn(
                      label: Text("SI/NO",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Order Id",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("User Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Shop Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Ordered Date",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Pickup Date",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Delivery Date",
                          style: TextStyle(fontWeight: FontWeight.bold))),


                  DataColumn(
                      label: Text("Status",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                // rows: orders
                //     .where((order) =>
                // selectedFilter == "All" ||
                //     order.status == selectedFilter)
                //     .map((order) =>
                //     DataRow(cells: [
                //       DataCell(Text(
                //           (orders.indexOf(order) + 1).toString())),
                rows: List.generate(state.orders.length, (index) {
                  final orders = state.orders[index];

                  return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),

                        DataCell(Text(orders.orderid.toString())),
                        DataCell(Text(orders.username.toString())),
                        DataCell(Text(orders.shopname.toString())),
                        DataCell(Text(orders.Orderdate.toString())),
                        DataCell(Text(orders.pickupdate.toString())),
                        DataCell(Text(orders.Deliverydate.toString())),

                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(orders.status),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              orders.status,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ]);
                })

                    .toList(),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox();
  },
),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedFilter = title;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedFilter == title ? Colors.blue : Colors.grey.shade300,
            foregroundColor:
                selectedFilter == title ? Colors.white : Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green.shade200;
      case "Cancelled":
        return Colors.red.shade200;
      case "In Progress":
        return Colors.orange.shade200;
      default:
        return Colors.grey.shade400;
    }
  }
}
