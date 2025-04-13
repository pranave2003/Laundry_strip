import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import 'AssignFeesPage.dart';
import 'available_drivers.dart';

class Assignorderwrapper extends StatelessWidget {
  const Assignorderwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Example: If shopid is stored in user's displayName (change as needed)
    String? shopid = user?.uid;

    return BlocProvider(
      create: (context) => OrderBloc()
        ..add(Fetchorders(searchQuery: null, status: "1", shopid: shopid)),
      child: OrderAssignPage(),
    );
  }
}

class OrderAssignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Assign Driver",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("All Orders",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 260,),
                //ElevatedButton(
                  //onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AssignFeesPage(),
                    //   ),
                    // );
                    // // Add your Assign Fees logic here
                    // print("Assign Fees button tapped");
                 // },
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: defaultColor,
                  //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  // ),
                  // child: const Text(
                  //   "Assign Fees",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
               // ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
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
                              final order = state.orders[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(order.username!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text("Shop Name:  ${order.shopname}"),
                                    Text("Order ID:  ${order.orderid}"),
                                    Text("Order Date:  ${order.Orderdate}"),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Total Amount: ₹ ${order.Totalcharge}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        order.PIckup == "1"
                                            ? Text(
                                                "Driver Assigned",
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              )

                                            : ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AcailableDriverwrapper(
                                                                orderid: order
                                                                    .orderid)),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                                ),
                                                child: const Text(
                                                    "Assign Driver",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                      ],
                                    ),
                                  ],
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
    );
  }
}
