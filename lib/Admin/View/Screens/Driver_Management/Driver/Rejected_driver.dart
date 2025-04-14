import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_event.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';

import '../../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class RejectedDriverWrapper extends StatelessWidget {
  const RejectedDriverWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverblocBloc()..add(FetchDriver(searchQuery: null,status: "2")),
      child: RejectedDriverPage(),
    );
  }
}

class RejectedDriverPage extends StatelessWidget {
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
                    .read<DriverblocBloc>()
                    .add(FetchDriver(searchQuery: value,status: "2")); // P
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
                hintText: 'Search Drivers',
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
    return BlocBuilder<DriverblocBloc, DriverblocState>(
      builder: (context, state) {
        if (state is DriverLoading) {
          return Center(child: Loading_Widget());
        } else if (state is DriverFailure) {
          return Center(child: Text(state.error.toString()));
        } else if (state is Driverloaded) {
          if (state.Drivers.isEmpty) {
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

  Widget _buildDataTable(Driverloaded state) {
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
          rows: state.Drivers.asMap().entries
              .map((entry) => _buildRow(entry.key + 1, entry.value))
              .toList(),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(label: Text('S/no', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Driver Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Proof', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  DataRow _buildRow(int index, driver) {
    return DataRow(cells: [
      DataCell(Text(index.toString())), //Fixed index number (S/no)
      DataCell(Text(driver.name.toString())),
      DataCell(Text(driver.email.toString())),
      DataCell(Text(driver.phone.toString())),
      //DataCell(Text(driver.proof.toString())),
    DataCell(Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Container(
    height:80,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(
    5), // Rounded corners for image
    child: CachedNetworkImage(
      imageUrl: "https://static.vecteezy.com/system/resources/previews/016/141/788/original/driver-license-icon-in-comic-style-id-card-cartoon-illustration-on-white-isolated-background-identity-splash-effect-business-concept-vector.jpg",
    width: 100, // Adjusted width
    height: 50, // Adjusted height
    fit: BoxFit.cover,
    placeholder: (context, url) => Container(
    width: 50,
    height: 50,
    color: Colors.grey[300], // Placeholder background
    child: Center(
    child: Loading_Widget(), // Loading indicator
    ),
    ),
    errorWidget: (context, url, error) => Container(
    width: 50,
    height: 50,
    color: Colors.grey[300], // Placeholder background
    child: Icon(
    Icons.image_not_supported,
    size: 50,
    color: Colors.grey[600],
    ),
    ),
    ),
    ),

    ),
    ),
    ),
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
