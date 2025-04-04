import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class NewshopWrapper extends StatelessWidget {
  const NewshopWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopAuthblocBloc()..add(FetchShop(searchQuery: null, status: "0")),
      child: NewShopsPage(),
    );
  }
}

class NewShopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        actions: [
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: TextField(
              onChanged: (value) {
                context
                    .read<ShopAuthblocBloc>()
                    .add(FetchShop(searchQuery: value,status: "0")); // P
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
        ],
      ),
      backgroundColor: Colors.white,
      body: _buildShopTable(context, 'new'),
    );
  }

  Widget _buildShopTable(BuildContext context, String type) {
    return BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
      listener: (context, state) {
        if (state is Refresh) {
          context.read<ShopAuthblocBloc>()
            ..add(FetchShop(searchQuery: null, status: "0"));
        }
      },
      builder: (context, state) {
        if (state is ShopLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Shopfailerror) {
          return Center(child: Text(state.error.toString()));
        } else if (state is Shoploaded) {
          if (state.Shop.isEmpty) {
            return Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 33,
                headingRowHeight: 45,
                dataRowHeight: 130,
                border: TableBorder(
                  horizontalInside:
                      BorderSide(width: 1, color: Colors.grey.shade300),
                ),
                columns: _buildColumns(),
                rows: List.generate(state.Shop.length, (index) {
                  var shop = state.Shop[index]; // Fetch shop details once

                  return DataRow(cells: [
                    DataCell(Text((index + 1).toString())), // Serial Number
                    DataCell(Text(shop.owner_name.toString())),
                    DataCell(Text(shop.shop_name.toString())),
                    DataCell(Text(shop.email.toString())),
                    DataCell(Text(shop.phone.toString())),
                    DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(shop.street.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis),
                        Text(shop.city.toString(),
                            overflow: TextOverflow.ellipsis),
                        Text(shop.District.toString(),
                            overflow: TextOverflow.ellipsis),
                        Text(shop.post.toString(),
                            overflow: TextOverflow.ellipsis),
                      ],
                    )),
                    DataCell(Text('${shop.LaundryCapacity} kg')),
                    DataCell(Text(shop.selectServices!.join("\n"))),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              context.read<ShopAuthblocBloc>().add(
                                    AcceptReject(
                                        status: "1",
                                        shopid: shop.shopid.toString()),
                                  );
                            }, // Accept action
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.green)),
                            child: Text('Accept',
                                style: TextStyle(color: Colors.green)),
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              context.read<ShopAuthblocBloc>().add(
                                    AcceptReject(
                                        status: "2",
                                        shopid: shop.shopid.toString()),
                                  );
                            }, // Reject action
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red)),
                            child: Text('Reject',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(
          label: Text('S/no', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Owner Name',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Shop Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Address', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Laundry Capacity',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Services', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }
}
