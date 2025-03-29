import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';

import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';

class Allorderswrapper extends StatelessWidget {
  const Allorderswrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..add(Fetchorders(searchQuery: null)),
      child: AllOrders(),
    );
  }
}

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is orderfetchloading) {
          return Center(child: Loading_Widget());
        }
        if (state is orderloaded) {
          return ListView.builder(
            itemCount: state.order.length, // Replace with actual data length
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                color: Colors.white,
                child: ExpansionTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // Uncomment and use a valid image source
                    // child: Center(
                    //   child: Image.asset("order["icon"]", width: 35, height: 35),
                    // ),
                  ),
                  title: Text("Service",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  subtitle: Text("Order ID: 12345\nOrder Date: 01/01/2024"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer Name: John Doe",
                              style: TextStyle(fontSize: 14)),
                          Text("Total Amount: \$50.00",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("Completed",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
