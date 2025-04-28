import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../../Controller/bloc/Orderbloc/order_bloc.dart';




class ViewFeedbackPage extends StatelessWidget {
  final String orderid;
  const ViewFeedbackPage({super.key, required this.orderid});

  @override
  Widget build(BuildContext context) {
    // 📢 Trigger fetch event
    context.read<OrderBloc>().add(FetchUserFeedbackEvent(orderid));

    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is UserFeedbackLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is UserFeedbackLoaded) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.black54,
                  child: Container(
                    width: 300,
                    height: 250,// Set a fixed width for the smaller card
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Review:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.review.isNotEmpty
                              ? state.review
                              : 'No review provided.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Rating:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.rating.isNotEmpty
                              ? state.rating
                              : 'No rating provided.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is UserFeedbackError) {
                return Center(child: Text("Error: ${state.error ?? ""}"));
              }
              return Center(child: Text('No Feedback Available'));
            },
          ),
        ),
      ),
    );
  }
}

// class ViewFeedbackPage extends StatelessWidget {
//   final String orderid;
//   const ViewFeedbackPage({super.key, required this.orderid});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.microtask(() {
//       context.read<OrderBloc>().add(FetchUserFeedbackEvent(orderid));
//     });
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Feedback'),
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(
//         builder: (context, state) {
//           if (state is UserSendreviewandratingloading) {
//             return Center(child: Loading_Widget());
//           } else if (state is FeedbackLoaded) {
//             return state.orders.isEmpty
//                 ? Center(child: Text("No feedbacks available"))
//                 : ListView.builder(
//               itemCount: state.orders.length,
//               itemBuilder: (context, index) {
//                 var order = state.orders[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ExpansionTile(
//                     title: Text("Name: ${order.username}"),
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Total Amount: \$${order.Totalcharge}"),
//                             Text("Delivery Address: ${order.deliveryaddress}"),
//                             Text("Total Items: ${order.items.length}"),
//                             Text("Review: ${order.Review}"),
//                             Text("Rating: ${order.Ratingstatus}"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (state is UserFeedbackError) {
//             return Center(child: Text("Error: ${state.error ?? ''}"));
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
//
// class ViewFeedbackPage extends StatelessWidget {
//   final String orderid;
//   final String shopid;
//
//   ViewFeedbackPage({required this.orderid, required this.shopid});
//
//   @override
//   Widget build(BuildContext context) {
//
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text("Feedback"),
//     //     backgroundColor: Colors.white,
//     //     elevation: 0,
//     //     leading: BackButton(color: Colors.black),
//     //   ),
//     //   body: orderid.isEmpty || shopid.isEmpty
//     //       ? Center(
//     //     child: Text(
//     //       'Invalid Order ID or Shop ID',
//     //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     //     ),
//     //   )
//       //     : BlocProvider(
//       //   create: (_) => OrderBloc()
//       //     ..add(FetchUserFeedbackEvent(orderid: orderid, shopid: shopid)),
//       //   child: BlocBuilder<OrderBloc, OrderState>(
//       //     builder: (context, state) {
//       //       if (state is UserFeedbackLoading) {
//       //         return Center(child: CircularProgressIndicator());
//       //       } else if (state is UserFeedbackError) {
//       //         return Center(
//       //             child: Text(
//       //               'Error: ${state.error}',
//       //               style: TextStyle(
//       //                 fontSize: 16,
//       //                 color: Colors.red,
//       //                 fontWeight: FontWeight.bold,
//       //               ),
//       //             ));
//       //       } else if (state is UserFeedbackLoaded) {
//       //         if (state.rating.isEmpty && state.review.isEmpty) {
//       //           return Center(
//       //             child: Text(
//       //               "No feedback available yet.",
//       //               style: TextStyle(
//       //                   fontSize: 16, fontWeight: FontWeight.bold),
//       //             ),
//       //           );
//       //         }
//       //
//       //         final ratingValue = int.tryParse(state.rating) ?? 0;
//       //
//       //         return Padding(
//       //           padding: const EdgeInsets.all(20.0),
//       //           child: Card(
//       //             elevation: 5,
//       //             shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.circular(16),
//       //             ),
//       //             child: Padding(
//       //               padding: const EdgeInsets.all(20.0),
//       //               child: Column(
//       //                 crossAxisAlignment: CrossAxisAlignment.start,
//       //                 mainAxisSize: MainAxisSize.min,
//       //                 children: [
//       //                   Center(
//       //                     child: Text(
//       //                       "Feedback for Order #$orderid",
//       //                       style: TextStyle(
//       //                         fontSize: 20,
//       //                         fontWeight: FontWeight.bold,
//       //                         color: Colors.blueAccent,
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   SizedBox(height: 20),
//       //                   Row(
//       //                     mainAxisAlignment: MainAxisAlignment.center,
//       //                     children: List.generate(5, (index) {
//       //                       return Icon(
//       //                         index < ratingValue
//       //                             ? Icons.star
//       //                             : Icons.star_border,
//       //                         color: Colors.amber,
//       //                         size: 30,
//       //                       );
//       //                     }),
//       //                   ),
//       //                   SizedBox(height: 16),
//       //                   Text(
//       //                     "Rating: ${state.rating} / 5",
//       //                     style: TextStyle(
//       //                       fontSize: 16,
//       //                       fontWeight: FontWeight.w500,
//       //                     ),
//       //                   ),
//       //                   SizedBox(height: 12),
//       //                   Text(
//       //                     "Review:",
//       //                     style: TextStyle(
//       //                       fontSize: 16,
//       //                       fontWeight: FontWeight.bold,
//       //                     ),
//       //                   ),
//       //                   SizedBox(height: 8),
//       //                   Text(
//       //                     state.review,
//       //                     style: TextStyle(
//       //                       fontSize: 15,
//       //                       color: Colors.black87,
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         );
//       //       }
//       //
//       //       return Container(); // Default fallback
//       //     },
//       //   ),
//       // ),
//         return BlocConsumer<OrderBloc, OrderState>(
//     listener: (context, state) {
//       if (state is orderRefresh) {
//         context.read<OrderBloc>()
//           ..add(Fetchorders(searchQuery: null));
//       }
//     },
//     builder: (context, state) {
//       if (state is UserFeedbackLoading) {
//         return Center(child: CircularProgressIndicator());
//       } else if (state is UserFeedbackLoaded) {
//         return ListView.builder(
//           itemCount: state.orders.length,
//           itemBuilder: (context, index) {
//             var order = state.orders[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               elevation: 2,
//               color: Colors.white,
//               child: ExpansionTile(
//                 title: Row(
//                   children: [
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Name: ${order.username}",
//                               style: const TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4),
//                           Text("Order ID: ${order.orderid}",
//                               style: const TextStyle(
//                                   fontSize: 12, color: Colors.black87)),
//                           Text("Order Date: ${order.Orderdate}",
//                               style: const TextStyle(
//                                   fontSize: 12, color: Colors.black87)),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           children: order.items.map((item) {
//                             return Padding(
//                               padding:
//                               const EdgeInsets.symmetric(vertical: 4.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.asset(item.productimage,
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover),
//                                   const SizedBox(width: 12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(item.productName,
//                                             style: TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold)),
//                                         const SizedBox(height: 4),
//                                         Text("Quantity: ${item.quantity}",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey.shade800)),
//                                         Text("Price: ${item.price}",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey.shade800)),
//                                         Text("Service: ${item.service}",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey.shade800)),
//                                         Text("Category: ${item.catogoty}",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey.shade800)),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//
//
//
//
//
//
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       } else if (state is OrderFailure) {
//         return Center(child: Text("Error: ${state.message ?? ""}"));
//       }
//       return Container();
//     },
//     );
//
//   }
// }
