import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class ProductDetailsScreen extends StatelessWidget {
  final dynamic shop; // Accept shop data

  ProductDetailsScreen({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(" Opening Shop Details for ID: ${shop.shopid}"); // 🐛 Debugging Print

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // 🔙 Go Back
        ),
        title: Text("Shop Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),

            Column(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Rounded corners for image
                  child: CachedNetworkImage(
                    imageUrl: shop.ShopImage.toString(),
                    width: 500, // Adjusted width
                    height: 200, // Adjusted height
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300], // Placeholder background
                      child: Center(
                        child: Loading_Widget(), // Loading indicator
                      ),
                    ),
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        width: 130,
                        height: 100,
                        color: Colors.grey[300], // Placeholder background
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Text("Shop Name: ${shop.shop_name ?? ''}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Laundry Capacity: ${shop.LaundryCapacity ?? ''}Kg ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Owner: ${shop.owner_name ?? ''}"),
            Text(
                "Address:  ${shop.street ?? ''},${shop.city ?? ''},${shop.District ?? ''}, ${shop.post ?? ''}"),
            SizedBox(height: 16),

            // Fetching Products when Screen Loads
            BlocProvider(
              create: (context) {
                return AddproductBloc()
                  ..add(FetchProduct(shopid: shop.shopid, searchQuery: ''));
              },
              child: Expanded(
                child: BlocConsumer<AddproductBloc, AddproductState>(
                  listener: (context, state) {
                    if (state is ProductDelete) {
                      context.read<AddproductBloc>().add(
                          FetchProduct(shopid: shop.shopid, searchQuery: ''));
                    }
                  },
                  builder: (context, state) {
                    if (state is AddproductLoading) {
                      return Center(child: CircularProgressIndicator());
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
                      return ListView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildDetailRow(
                                      "Service", "${product.service ?? ''}"),
                                  buildDetailRow(
                                      "Category", "${product.category ?? ''}"),
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
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          ],
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
