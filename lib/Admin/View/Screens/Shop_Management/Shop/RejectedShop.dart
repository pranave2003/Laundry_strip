import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class RejectedshopWrapper extends StatelessWidget {
  const RejectedshopWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthblocBloc()..add(FetchShop(searchQuery: null,status: "2")),
      child: RejectedShopsPage(),
    );
  }
}

class RejectedShopsPage extends StatelessWidget {
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
                    .add(FetchShop(searchQuery: value,status: "2")); // P
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
      body: _buildShopTable(context),
    );
  }

  Widget _buildShopTable(BuildContext context) {
    return BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
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
          return _buildDataTable(state);
        }
        return SizedBox();
      },
    );
  }

  Widget _buildDataTable(Shoploaded state) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 33,
          headingRowHeight: 45,
          dataRowHeight: 130,
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columns: _buildColumns(),
          rows: state.Shop.asMap().entries
              .map((entry) => _buildRow(entry.key + 1, entry.value))
              .toList(),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(label: Text('S/no', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Owner Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Shop Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Address', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Laundry Capacity', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Services', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  DataRow _buildRow(int index, shop) {
    return DataRow(cells: [
      DataCell(Text(index.toString())), //Fixed index number (S/no)
      DataCell(Text(shop.owner_name.toString())),
      DataCell(Text(shop.shop_name.toString())),
      DataCell(Text(shop.email.toString())),
      DataCell(Text(shop.phone.toString())),
      DataCell(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shop.street.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis),
            Text(shop.city.toString(), overflow: TextOverflow.ellipsis),
            Text(shop.District.toString(), overflow: TextOverflow.ellipsis),
            Text(shop.post.toString(), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
      DataCell(Text('${shop.LaundryCapacity} kg')),
      DataCell(Text(shop.selectServices!.join("\n"))),
      DataCell(
        OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red)),
          child: Text('Rejected', style: TextStyle(color: Colors.red)),
        ),
      ),
    ]);
  }
}
