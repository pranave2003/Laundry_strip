import 'package:cached_network_image/cached_network_image.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: TextField(
              onChanged: (value) {
                context
                    .read<DriverblocBloc>()
                    .add(FetchDriver(searchQuery: value, status: "0")); // P
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
                    DataCell(Text((index + 1).toString())),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              5), // Rounded corners for image
                          child: CachedNetworkImage(
                            imageUrl: driver.image.toString(),
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
                    )),
                    DataCell(Text(driver.name.toString())),
                    DataCell(Text(driver.email.toString())),
                    DataCell(Text(driver.phone.toString())),
                    DataCell(Text(driver.aadhar.toString())),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Show the alert dialog with the proof image
                          _showProofDialog(context, driver.proof.toString());
                        },
                        child: Container(
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                5), // Rounded corners for image
                            child: CachedNetworkImage(
                              imageUrl: driver.proof.toString(),
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
                    )),
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
          label: Text('Image',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Driver Name',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Aadhar Number',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Proof',
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  void _showProofDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('View Proof Image'),
          content: Container(
            width: 600, // Adjust the width
            height: 900, // Adjust the height
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(child: Loading_Widget()),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
