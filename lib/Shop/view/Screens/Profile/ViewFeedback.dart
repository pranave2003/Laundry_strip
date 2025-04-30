import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';

class ViewFeedbackPageWrapper extends StatelessWidget {
  const ViewFeedbackPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
        create: (context) => OrderBloc()..add(Fetchorders(searchQuery: '')),
        child: ViewFeedbackPage(

        ));
  }
}

class ViewFeedbackPage extends StatelessWidget {

  const ViewFeedbackPage({super.key, });

  @override
  Widget build(BuildContext context) {
    //  Trigger fetch event
    context.read<OrderBloc>().add(Fetchorders(searchQuery: ''));

    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<OrderBloc, OrderState>(
  listener: (context, state) {
    if (state is UserSendreviewandratingRefresh) {
      context.read<OrderBloc>()
        ..add(Fetchorders(
          searchQuery: null,
        ));
    }
    // TODO: implement listener
  },
  builder: (context, state) {
            if (state is UserFeedbackLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FeedbackLoaded) {
              return state.orders.isEmpty
                  ? Center(
                      child: Text("No data found"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.orders
                          .length, // Use dynamic data count when integrating Firebase
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: ${order.username}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text("Shop Name: ${order.shopname}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87)),
                                      Text("Order ID: ${order.orderid}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87)),

                                      Text("Order Date: ${order.Orderdate}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87)),
                                      Text(
                                          "Delivery Address: ${order.deliveryaddress}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,)),
                                      Text("Review: ${order.Review}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87)),
                                      Text("Rating: ${order.Ratingstatus}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87)),
                                    ],
                                  ),
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
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                        "Quantity: ${item.quantity}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                                .shade800)),
                                                    Text("Price: ${item.price}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                                .shade800)),
                                                    Text(
                                                        "Service: ${item.service}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                                .shade800)),
                                                    Text(
                                                        "Category: ${item.catogoty}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                                .shade800)),
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

                                    Divider(),
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
          }
              // else if (state is UserFeedbackError) {
              //   return Center(child: Text("Error: ${state.error ?? ""}"));
              // }
              //return Center(child: Text('No Feedback Available'));
              //},




),
        ),
      ),

    );
  }
}

