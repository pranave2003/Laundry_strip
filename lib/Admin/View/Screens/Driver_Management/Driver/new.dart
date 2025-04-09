import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_event.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';

import '../../../../../Widget/constands/Loading.dart';

class NewDriverWrapper extends StatelessWidget {
  const NewDriverWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DriverblocBloc()..add(FetchDriver(searchQuery: null, status: "0")),
      child: NewDriverPage(),
    );
  }
}

class NewDriverPage extends StatelessWidget {
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
                    .add(FetchDriver(searchQuery: value,status: "0")); // P
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
                hintText: 'Search Driver',
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
    return BlocConsumer<DriverblocBloc, DriverblocState>(
      listener: (context, state) {
        if (state is Refresh) {
          context.read<DriverblocBloc>()
            ..add(FetchDriver(searchQuery: null, status: "0"));
        }
      },
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
                rows: List.generate(state.Drivers.length, (index) {
                  var driver = state.Drivers[index]; // Fetch shop details once

                  return DataRow(cells: [
                    DataCell(Text((index + 1).toString())), // Serial Number
                    DataCell(Text(driver.name.toString())),
                    DataCell(Text(driver.email.toString())),
                    DataCell(Text(driver.phone.toString())),
                    DataCell(Text(driver.proof.toString())),

                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              context.read<DriverblocBloc>().add(
                                AcceptReject(
                                    status: "1",
                                    driverId: driver.driverId.toString()),
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
                              context.read<DriverblocBloc>().add(
                                AcceptReject(
                                    status: "2",
                                    driverId: driver.driverId.toString()),
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
          label: Text('Driver Name',
              style: TextStyle(fontWeight: FontWeight.bold))),

      DataColumn(
          label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),

      DataColumn(
          label: Text('Proof',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }
}
