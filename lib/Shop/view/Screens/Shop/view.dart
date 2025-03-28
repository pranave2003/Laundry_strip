import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import 'Add_shop.dart';

class LaundryView extends StatelessWidget {
  final List<Map<String, String>> serviceTypes = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
  ];

  final List<String> categories = ["Men"];

  final List<Map<String, String>> products = [
    {"icon": "assets/Dress/shirt.png", "name": "Shirt", "price": "₹50"},
  ];
  String? shopid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shop_Add()),
              );

              if (result == true) {
                // Refresh the product list
                context
                    .read<AddproductBloc>()
                    .add(FetchProduct(searchQuery: null));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
          builder: (context, state) {
            if (state is Shoploading) {
              return const Center(child: Loading_Widget());
            } else if (state is ShopByidLoaded) {
              final shop = state.userData;
              shopid = shop.shopid;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('${shop.shop_name ?? ''}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text("Laundry Capacity: ${shop.LaundryCapacity ?? ''} ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Owner:${shop.owner_name ?? ''}"),
                  Text(
                      "Address:  ${shop.District ?? ''}, ${shop.city ?? ''},${shop.post ?? ''}"),
                  SizedBox(height: 16),
                  BlocConsumer<AddproductBloc, AddproductState>(
                    listener: (context, state) {
                      if (state is ProductDelete) {
                        context
                            .read<AddproductBloc>()
                            .add(FetchProduct(searchQuery: null));
                      }
                    },
                    builder: (context, state) {
                      if (state is AddproductLoading) {
                        return Center(child: Loading_Widget());
                      } else if (state is addproductfail) {
                        return Text(state.error.toString());
                      } else if (state is AddproductLoaded) {
                        if (state.product.isEmpty) {
                          // Return "No data found" if txhe list is empty
                          return Center(
                            child: Text(
                              "No data found",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.product.length,
                            itemBuilder: (context, index) {
                              final product = state.product[index];
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildDetailRow("Service",
                                          "${product.service ?? ''}"),
                                      buildDetailRow("Category",
                                          "${product.category ?? ''}"),
                                      SizedBox(height: 10),
                                      Text("Products & Prices",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Image.asset(
                                              '${product.product_image ?? ''}',
                                              height: 50),
                                          SizedBox(width: 10),
                                          Text('${product.product_name ?? ''}',
                                              style: TextStyle(fontSize: 16)),
                                          Spacer(),
                                          Text('${product.Productprice ?? ''}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<AddproductBloc>()
                                                  .add(DeleteProduct(
                                                      productid:
                                                          product.productid));
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
