import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';

class AssignOrderPage extends StatefulWidget {
  @override
  _AssignOrderPageState createState() => _AssignOrderPageState();
}

class _AssignOrderPageState extends State<AssignOrderPage> {
  String selectedDriver = ""; // Stores the assigned driver's name

  // Dummy List of Drivers (You can replace it with real data)
  // final List<Map<String, String>> drivers = [
  //   {"name": "Amal", "phone": "8962147896", "image": "assets/driver1.png"},
  //   {"name": "Sachind", "phone": "7845963214", "image": "assets/driver1.png"},
  //   {"name": "Rahul", "phone": "6589741236", "image": "assets/driver1.png"},
  // ];
  // List<Map<String, dynamic>> orders = [
  //   {
  //     "orderId": "ORD001",
  //     "customerName": "John Doe",
  //     "customerPhone": "9876543210",
  //     "customerAddress": "123 Main Street, Downtown",
  //     "orderedDate": "2025-03-10",
  //     "pickupDate": "2025-03-11",
  //     "laundryShops": [
  //       {
  //         "name": "Clean Wash",
  //         "owner": "Michael Johnson",
  //         "location": "Downtown",
  //         "contact": "123-456-7890",
  //         "image": "assets/shop_img/img.png",
  //         "services": ["Wash & Fold", "Steam Iron"],
  //         "products": [
  //           {
  //             "productName": "Shirt",
  //             "price": 5.0,
  //             "image": "assets/Dress/shirt.png",
  //             "serviceName": "Wash & Fold",
  //           },
  //           {
  //             "productName": "Jacket",
  //             "price": 15.0,
  //             "image": "assets/Dress/jacket.png",
  //             "serviceName": "Steam Iron",
  //           }
  //         ],
  //       },
  //       // {
  //       //   "name": "Quick Clean",
  //       //   "owner": "Sarah Lee",
  //       //   "location": "Uptown",
  //       //   "contact": "789-123-4560",
  //       //   "image": "assets/shop_img/img2.png",
  //       //   "services": ["Household", "Dry Clean"],
  //       //   "products": [
  //       //     {
  //       //       "productName": "Carpet",
  //       //       "price": 10.0,
  //       //       "image": "assets/Dress/carpet.png",
  //       //       "serviceName": "Household",
  //       //     },
  //       //     {
  //       //       "productName": "T-shirt",
  //       //       "price": 12.0,
  //       //       "image": "assets/Dress/t-shirt.png",
  //       //       "serviceName": "Dry Clean",
  //       //     }
  //       //   ],
  //       // },
  //       // {
  //       //   "name": "Fresh Laundry",
  //       //   "owner": "Emma Wilson",
  //       //   "location": "Midtown",
  //       //   "contact": "654-987-3210",
  //       //   "image": "assets/shop_img/img3.png",
  //       //   "services": ["Steam Iron", "Dry Clean"],
  //       //   "products": [
  //       //     {
  //       //       "productName": "Frock",
  //       //       "price": 8.0,
  //       //       "image": "assets/Dress/frock.png",
  //       //       "serviceName": "Steam Iron",
  //       //     },
  //       //     {
  //       //       "productName": "Gown",
  //       //       "price": 6.0,
  //       //       "image": "assets/Dress/wmgown.png",
  //       //       "serviceName": "Dry Clean",
  //       //     }
  //       //   ],
  //       // }
  //     ]
  //   },
  //   {
  //     "orderId": "ORD002",
  //     "customerName": "Jane Smith",
  //     "customerPhone": "8765432109",
  //     "customerAddress": "456 Elm Street, Uptown",
  //     "orderedDate": "2025-03-09",
  //     "pickupDate": "2025-03-10",
  //     "laundryShops": [
  //       {
  //         "name": "Quick Clean",
  //         "owner": "Sarah Lee",
  //         "location": "Uptown",
  //         "contact": "789-123-4560",
  //         "image": "assets/shop_img/img2.png",
  //         "services": ["Dry Clean", "Special Care"],
  //         "products": [
  //           {
  //             "productName": "Dress",
  //             "price": 12.0,
  //             "image": "assets/Dress/frock.png",
  //             "serviceName": "Dry Clean",
  //           },
  //           {
  //             "productName": "T-Shirt",
  //             "price": 8.0,
  //             "image": "assets/Dress/t-shirt.png",
  //             "serviceName": "Special Care",
  //           }
  //         ],
  //       }
  //     ]
  //   },
  //   {
  //     "orderId": "ORD003",
  //     "customerName": "John Doe",
  //     "customerPhone": "9876543210",
  //     "customerAddress": "123 Main Street, Downtown",
  //     "orderedDate": "2025-03-10",
  //     "pickupDate": "2025-03-11",
  //     "laundryShops": [
  //       {
  //         "name": "Clean Wash",
  //         "owner": "Michael Johnson",
  //         "location": "Downtown",
  //         "contact": "123-456-7890",
  //         "image": "assets/shop_img/img.png",
  //         "services": ["Wash & Fold", "Steam Iron"],
  //         "products": [
  //           {
  //             "productName": "Shirt",
  //             "price": 5.0,
  //             "image": "assets/Dress/shirt.png",
  //             "serviceName": "Wash & Fold",
  //           },
  //           {
  //             "productName": "Jacket",
  //             "price": 15.0,
  //             "image": "assets/Dress/jacket.png",
  //             "serviceName": "Steam Iron",
  //           }
  //         ],
  //       },
  //       // {
  //       //   "name": "Quick Clean",
  //       //   "owner": "Sarah Lee",
  //       //   "location": "Uptown",
  //       //   "contact": "789-123-4560",
  //       //   "image": "assets/shop_img/img2.png",
  //       //   "services": ["Household", "Dry Clean"],
  //       //   "products": [
  //       //     {
  //       //       "productName": "Carpet",
  //       //       "price": 10.0,
  //       //       "image": "assets/Dress/carpet.png",
  //       //       "serviceName": "Household",
  //       //     },
  //       //     {
  //       //       "productName": "T-shirt",
  //       //       "price": 12.0,
  //       //       "image": "assets/Dress/t-shirt.png",
  //       //       "serviceName": "Dry Clean",
  //       //     }
  //       //   ],
  //       // },
  //       // {
  //       //   "name": "Fresh Laundry",
  //       //   "owner": "Emma Wilson",
  //       //   "location": "Midtown",
  //       //   "contact": "654-987-3210",
  //       //   "image": "assets/shop_img/img3.png",
  //       //   "services": ["Steam Iron", "Dry Clean"],
  //       //   "products": [
  //       //     {
  //       //       "productName": "Frock",
  //       //       "price": 8.0,
  //       //       "image": "assets/Dress/frock.png",
  //       //       "serviceName": "Steam Iron",
  //       //     },
  //       //     {
  //       //       "productName": "Gown",
  //       //       "price": 6.0,
  //       //       "image": "assets/Dress/wmgown.png",
  //       //       "serviceName": "Dry Clean",
  //       //     }
  //       //   ],
  //       // }
  //     ]
  //   },
  //   {
  //     "orderId": "ORD004",
  //     "customerName": "Jane Smith",
  //     "customerPhone": "8765432109",
  //     "customerAddress": "456 Elm Street, Uptown",
  //     "orderedDate": "2025-03-09",
  //     "pickupDate": "2025-03-10",
  //     "laundryShops": [
  //       {
  //         "name": "Quick Clean",
  //         "owner": "Sarah Lee",
  //         "location": "Uptown",
  //         "contact": "789-123-4560",
  //         "image": "assets/shop_img/img2.png",
  //         "services": ["Dry Clean", "Special Care"],
  //         "products": [
  //           {
  //             "productName": "Dress",
  //             "price": 12.0,
  //             "image": "assets/Dress/frock.png",
  //             "serviceName": "Dry Clean",
  //           },
  //           {
  //             "productName": "T-Shirt",
  //             "price": 8.0,
  //             "image": "assets/Dress/t-shirt.png",
  //             "serviceName": "Special Care",
  //           }
  //         ],
  //       }
  //     ]
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Greeting & Admin Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
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
                            onChanged: (value) {
                              context
                                  .read<OrderBloc>()
                                  .add(Fetchorders(searchQuery: value)); // P
                            },
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
                              hintText: 'Search orders',
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
              ),

              SizedBox(height: 35),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Assign Order",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              SizedBox(height: 20),
              //appBar: AppBar(title: Text("Assign Order")),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 600, // Set appropriate height
                  child: BlocConsumer<OrderBloc, OrderState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is orderRefresh) {
                        context.read<OrderBloc>()
                          ..add(Fetchorders(searchQuery: null));
                      }
                    },
                    builder: (context, state) {
                      if (state is orderfetchloading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is OrderLoaded) {
                        return ListView.builder(
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            double totalOrderAmount = 0;
                            var order = state.orders[index];

                            return Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ExpansionTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order ID: ${order.orderid}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Text("Customer: ${order.username}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    // Text("Phone: ${order['customerPhone']}",
                                    //   style: TextStyle(color: Colors.grey[700])),
                                    Text("Address: ${order.deliveryaddress}",
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ordered Date: ${order.Orderdate}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600])),
                                    Text("Pickup Date: ${order.pickupdate}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600])),
                                    Text("Delivery Date: ${order.Deliverydate}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600])),
                                    SizedBox(height: 10,),
                                    Text("Shop Id: ${order.shopid}",
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text("Shop Name: ${order.shopname}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            )),
                                  ],
                                ),

                                children: [
                                  Divider(),
                                      Column(

                                        children: order.items.map((item) {
                                          return Padding(
                                            padding:
                                            const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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



                                  // BlocConsumer<OrderBloc, OrderState>(
                                  //   listener: (context, state) {
                                  //     // TODO: implement listener
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is orderfetchloading) {
                                  //       return Center(
                                  //           child: CircularProgressIndicator());
                                  //     } else if (state is OrderLoaded) {
                                  //       return ListView.builder(
                                  //         shrinkWrap: true,
                                  //         physics:
                                  //             NeverScrollableScrollPhysics(),
                                  //         itemCount: state.orders.length,
                                  //         itemBuilder: (context, index) {
                                  //           var order = state.orders[index];
                                  //           // double shopTotal = shop["products"]
                                  //           //     .fold(0.0, (sum, item) => sum + item["price"]);
                                  //           // totalOrderAmount += shopTotal;
                                  //
                                  //           return Column(
                                  //             children: [
                                  //               ListTile(
                                  //                 // leading: ClipRRect(
                                  //                 //   borderRadius: BorderRadius.circular(8),
                                  //                 //   child: Image.asset(Shop['image'],
                                  //                 //       width: 50, height: 50, fit: BoxFit.cover),
                                  //                 // ),
                                  //                 title: Text(
                                  //                     order.shopname.toString(),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold)),
                                  //                 subtitle: Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .start,
                                  //                   children: [
                                  //                     Padding(
                                  //                       padding:
                                  //                           const EdgeInsets
                                  //                               .symmetric(
                                  //                               horizontal:
                                  //                                   16.0,
                                  //                               vertical: 8.0),
                                  //                       child: Column(
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Column(
                                  //                             children: order
                                  //                                 .items
                                  //                                 .map((item) {
                                  //                               return Padding(
                                  //                                 padding: const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         4.0),
                                  //                                 child: Row(
                                  //                                   crossAxisAlignment:
                                  //                                       CrossAxisAlignment
                                  //                                           .start,
                                  //                                   children: [
                                  //                                     Image.network(
                                  //                                         item
                                  //                                             .productimage,
                                  //                                         width:
                                  //                                             50,
                                  //                                         height:
                                  //                                             50,
                                  //                                         fit: BoxFit
                                  //                                             .cover),
                                  //                                     const SizedBox(
                                  //                                         width:
                                  //                                             12),
                                  //                                     Expanded(
                                  //                                       child:
                                  //                                           Column(
                                  //                                         crossAxisAlignment:
                                  //                                             CrossAxisAlignment.start,
                                  //                                         children: [
                                  //                                           Text(item.productName,
                                  //                                               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  //                                           const SizedBox(height: 4),
                                  //                                           Text("Quantity: ${item.quantity}",
                                  //                                               style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                                  //                                           Text("Price: ${item.price}",
                                  //                                               style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                                  //                                           Text("Service: ${item.service}",
                                  //                                               style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                                  //                                           Text("Category: ${item.catogoty}",
                                  //                                               style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
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
                                  //                           // Row(
                                  //                           //   mainAxisAlignment: MainAxisAlignment.end,
                                  //                           //   children: [
                                  //                           //     TextButton(
                                  //                           //         onPressed: () {
                                  //                           //           Navigator.push(context, MaterialPageRoute(
                                  //                           //             builder: (context) {
                                  //                           //               return OrderTracking(
                                  //                           //                 order: state.orders[index],
                                  //                           //               );
                                  //                           //             },
                                  //                           //           ));
                                  //                           //         },
                                  //                           //         child: Text(
                                  //                           //           "Open",
                                  //                           //           style: TextStyle(
                                  //                           //               color: Colors.blue,
                                  //                           //               fontWeight: FontWeight.bold),
                                  //                           //         ))
                                  //                           //   ],
                                  //                           // ),
                                  //                           // Text("Customer Name: ${order.username}",
                                  //                           //     style: TextStyle(fontSize: 14)),
                                  //                           Text(
                                  //                               "Total Amount: \$${order.Totalcharge}",
                                  //                               style: TextStyle(
                                  //                                   fontSize:
                                  //                                       14)),
                                  //                           Text(
                                  //                               "Delivery Address: ${order.deliveryaddress}",
                                  //                               style: TextStyle(
                                  //                                   fontSize:
                                  //                                       14,
                                  //                                   color: Colors
                                  //                                       .grey
                                  //                                       .shade900,
                                  //                                   fontWeight:
                                  //                                       FontWeight
                                  //                                           .bold)),
                                  //                           const SizedBox(
                                  //                               height: 8),
                                  //                           Text(
                                  //                               "Total Items: ${order.items.length}",
                                  //                               style: TextStyle(
                                  //                                   fontSize:
                                  //                                       14,
                                  //                                   fontWeight:
                                  //                                       FontWeight
                                  //                                           .bold)),
                                  //                           Divider(),
                                  //                           // Row(
                                  //                           //   children: [
                                  //                           //     TextButton(
                                  //                           //       onPressed: () {
                                  //                           //         showDialog(
                                  //                           //           context: context,
                                  //                           //           builder: (BuildContext context) {
                                  //                           //             return AlertDialog(
                                  //                           //               title: Text("Confirm Cancellation"),
                                  //                           //               content: Text(
                                  //                           //                   "Are you sure you want to cancel this order?"),
                                  //                           //               actions: [
                                  //                           //                 TextButton(
                                  //                           //                   onPressed: () {
                                  //                           //                     Navigator.of(context)
                                  //                           //                         .pop(); // Close dialog
                                  //                           //                   },
                                  //                           //                   child: Text("No"),
                                  //                           //                 ),
                                  //                           //                 TextButton(
                                  //                           //                   onPressed: () {
                                  //                           //                     // Perform order cancellation logic here
                                  //                           //                     Navigator.of(context)
                                  //                           //                         .pop(); // Close dialog
                                  //                           //                   },
                                  //                           //                   child: Text("Yes, Cancel"),
                                  //                           //                 ),
                                  //                           //               ],
                                  //                           //             );
                                  //                           //           },
                                  //                           //         );
                                  //                           //       },
                                  //                           //       child: Text("Order Cancel"),
                                  //                           //     )
                                  //                           //   ],
                                  //                           // )
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               Divider(),
                                  //               // ListView.builder(
                                  //               //   shrinkWrap: true,
                                  //               //   physics: NeverScrollableScrollPhysics(),
                                  //               //   itemCount: shop["products"].length,
                                  //               //   itemBuilder: (context, productIndex) {
                                  //               //     var product = shop["products"][productIndex];
                                  //               //     return ListTile(
                                  //               //       leading: Image.asset(product["image"],
                                  //               //           width: 50, height: 50, fit: BoxFit.cover),
                                  //               //       title: Text(product["productName"],
                                  //               //           style: TextStyle(
                                  //               //               fontWeight: FontWeight.bold)),
                                  //               //       subtitle: Text(
                                  //               //           "Service: ${product["serviceName"]}",
                                  //               //           style: TextStyle(
                                  //               //               color: Colors.blueAccent)),
                                  //               //       trailing: Text(
                                  //               //           "\$${product["price"].toStringAsFixed(
                                  //               //               2)}",
                                  //               //           style: TextStyle(
                                  //               //               fontWeight: FontWeight.bold)),
                                  //               //     );
                                  //               //   },
                                  //               // ),
                                  //               // Padding(
                                  //               //   padding: const EdgeInsets.all(8.0),
                                  //               //   child: Align(
                                  //               //     alignment: Alignment.centerRight,
                                  //               //     child: Text(
                                  //               //         "Total: \$${shopTotal.toStringAsFixed(2)}",
                                  //               //         style: TextStyle(
                                  //               //             fontWeight: FontWeight.bold,
                                  //               //             fontSize: 16,
                                  //               //             color: Colors.green)),
                                  //               //   ),
                                  //               // ),
                                  //               Divider(),
                                  //             ],
                                  //           );
                                  //         },
                                  //       );
                                  //     }
                                  //     return SizedBox();
                                  //   },
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Grand Total: ₹ ${order.Totalcharge}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 16.0, vertical: 10.0),
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       showAvailableDrivers(context);
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: defaultColor, // Use defaultColor
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(8),
                                  //       ),
                                  //     ),
                                  //     child: Text(
                                  //       selectedDriver.isNotEmpty
                                  //           ? selectedDriver
                                  //           : "Assign Driver",
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // ),
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
              )
            ],
          ),
        ));
  }

  // Method to Show Available Drivers in a Dialog
  // void showAvailableDrivers(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Available Drivers"),
  //         content: SizedBox(
  //           width: 400,
  //           height: 300,
  //           child: ListView(
  //             children: drivers.map((driver) {
  //               return ListTile(
  //                 leading: CircleAvatar(
  //                   backgroundImage: AssetImage(driver["image"]!),
  //                 ),
  //                 title: Text(driver["name"]!),
  //                 subtitle: Text(driver["phone"]!),
  //                 trailing: ElevatedButton(
  //                   onPressed: () {
  //                     // Set Selected Driver
  //                     setState(() {
  //                       selectedDriver = driver["name"]!;
  //                     });
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text("Select"),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Close"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

/////////
