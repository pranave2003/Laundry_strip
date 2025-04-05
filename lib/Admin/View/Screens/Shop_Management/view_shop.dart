import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import 'Shop/ShopDetails_Dialog.dart';

class ViewShopsScreen extends StatelessWidget {
  void showProductDetailsDialog(BuildContext context, dynamic shop) {
    showDialog(
      context: context,
      builder: (context) =>
          ProductDetailsScreen(shop: shop), // Corrected passing of 'shop'
    );
  }

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
                          onChanged: (value) {
                            context
                                .read<ShopAuthblocBloc>()
                                .add(FetchShop(searchQuery: value,status: "1")); // P
                          },
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
            const Text("View Accepted Shops",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // TABLE SECTION
            Expanded(
              child: BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
                builder: (context, state) {
                  if (state is ShopLoading) {
                    return Center(child: Loading_Widget());
                  } else if (state is Shopfailerror) {
                    return Center(
                      child: Text(
                        "Error: ${state.error}",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  } else if (state is Shoploaded) {
                    // Filter only accepted shops
                    final acceptedShops =
                        state.Shop.where((shop) => shop.status == "1").toList();

                    if (acceptedShops.isEmpty) {
                      return Center(
                        child: Text(
                          "No accepted shops found",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 38.0,
                          dataRowHeight: 130, // Increased row spacing
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
                                label: Text("Services",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                            DataColumn(
                                label: Text("Action",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                            DataColumn(
                                label: Text("View",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                          ],
                          rows: List.generate(acceptedShops.length, (index) {
                            final shop = acceptedShops[index];

                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
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
                              DataCell(Text(shop.selectServices!.join("\n"))),
                              DataCell(
                                OutlinedButton(
                                  onPressed: null,
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.green)),
                                  child: Text('Accepted',
                                      style: TextStyle(color: Colors.green)),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: Colors.blueGrey),
                                  onPressed: () {
                                    showProductDetailsDialog(
                                        context, shop); // ✅ Pass only 'shop'
                                  },
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
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
