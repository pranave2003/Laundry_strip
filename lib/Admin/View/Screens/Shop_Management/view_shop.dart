import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import 'Shop_Details.dart';

class ViewShopsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello !",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cheers and happy activities",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Search Bar
                      Container(
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: 'Search Laundry Shops',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Text("View Shops",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // TABLE SECTION
            Expanded(
              child: BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
                builder: (context, state) {
                  if (state is ShopLoading) {
                    return Center(child: Loading_Widget());
                  } else if (state is Shopfailerror) {
                    return Text(state.error.toString());
                  } else if (state is Shoploaded) {
                    if (state.Shop.isEmpty) {
// Return "No data found" if txhe list is empty
                      return Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 38.0,
                        dataRowHeight: 100,
                        // Increased row spacing
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey[50]!),
                        columns: const [
                          DataColumn(
                              label: Text("S.No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Owner Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Shop Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Phone",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Laundry Capacity",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                          DataColumn(
                              label: Text("Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                        ],
                        rows: List.generate(state.Shop.length, (index) {
                          final shop = state.Shop[index];

                          return DataRow(cells: [
                            DataCell(Text((index + 1).toString(),
                                style: TextStyle(fontWeight: FontWeight.bold))),

                            // Text(User.phone.toString(),

                            DataCell(Text(shop.owner_name.toString())),
                            DataCell(Text(shop.shop_name.toString())),
                            DataCell(Text(shop.email.toString())),
                            DataCell(Text(shop.phone.toString())),
                            DataCell(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.street.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(shop.city.toString(),
                                      overflow: TextOverflow.ellipsis),
                                  Text(shop.District.toString(),
                                      overflow: TextOverflow.ellipsis),
                                  Text(shop.post.toString(),
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            DataCell(Text(shop.LaundryCapacity.toString())),
                            DataCell(Text(shop.selectServices.toString())),
                            // DataCell(Text(shop['shopName']!)),
                            // DataCell(Text(shop['email']!)),
                            // DataCell(Text(shop['phone']!)),
                            // DataCell(
                            //   SizedBox(
                            //     width: 150, // Adjust width based on your UI design
                            //     child: Text(
                            //       shop['address']!,
                            //       maxLines: 3,
                            //       overflow: TextOverflow.ellipsis,
                            //       softWrap: true,
                            //     ),
                            //   ),
                            // ),
                            // DataCell(Text(shop['capacity']!)),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: shop.status == '1'
                                      ? Colors.green[50]
                                      : Colors.orange[50],
                                ),
                                // child: Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     Icon(
                                //       shop['status'] == 'Accepted'
                                //           ? Icons.check_circle
                                //           : Icons.access_time,
                                //       color: shop['status'] == 'Accepted'
                                //           ? Colors.green
                                //           : Colors.orange,
                                //       size: 16,
                                //     ),
                                //     const SizedBox(width: 5),
                                //     Text(
                                //       shop['status']!,
                                //       style: TextStyle(color: shop['status'] == 'Accepted'
                                //           ? Colors.green
                                //           : Colors.orange),
                                //     ),
                                //   ],
                                // ),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.visibility,
                                    color: Colors.blueGrey),
                                onPressed: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return ShopDetailsDialog(
                                  //       shopName: shop["shopName"] ?? "N/A",
                                  //       laundryCapacity: shop['capacity'] ?? "N/A",
                                  //       address: shop['address'] ?? "N/A",
                                  //       email: shop["email"] ?? "N/A",
                                  //       phone: shop["phone"] ?? "N/A",
                                  //     );
                                  //   },
                                  // );
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
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
// if (state is ShopLoading) {
// return Center(child: Loading_Widget());
// } else if (state is Shopfailerror) {
// return Text(state.error.toString());
// } else if (state is Shoploaded) {
// if (state.Shop.isEmpty) {
// // Return "No data found" if txhe list is empty
// return Center(
// child: Text(
// "No data found",
// style: TextStyle(
// fontSize: 16, fontWeight: FontWeight.bold),
// ),
// );
// }
