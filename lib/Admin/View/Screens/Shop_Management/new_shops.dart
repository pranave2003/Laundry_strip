import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';

class LaundryShopsPage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Laundry Shops", style: TextStyle(fontWeight: FontWeight.bold)),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: false,
      //   titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
      //   iconTheme: IconThemeData(color: Colors.black),
      // ),
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
                            borderRadius: BorderRadius.circular(18)),
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

            const SizedBox(height: 20),

            // PAGE TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Laundry Shops",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TABS AND SHOP TABLE
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: Colors.blue,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      tabs: [
                        Tab(text: 'New Shops'),
                        Tab(text: 'Accepted Shops'),
                        Tab(text: 'Rejected Shops'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildShopTable(context, 'new'),
                          _buildShopTable(context, 'accepted'),
                          _buildShopTable(context, 'rejected'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopTable(BuildContext context, String type) {
    return BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 33,
              headingRowHeight: 45,
              dataRowHeight: 100,
              border: TableBorder(
                horizontalInside:
                    BorderSide(width: 1, color: Colors.grey.shade300),
              ),
              columns: [
                _buildHeaderCell('S/no'),
                _buildHeaderCell('Owner Name'),
                _buildHeaderCell('Shop Name'),
                _buildHeaderCell('Email'),
                _buildHeaderCell('Phone'),
                _buildHeaderCell('Address'),
                _buildHeaderCell('Laundry Capacity'),
                _buildHeaderCell('Action'),
                _buildHeaderCell('Services'),
                _buildHeaderCell('Action'),

              ],
              rows: List.generate(state.Shop.length, (index) {
                final shop = state.Shop[index];

                return DataRow(
                  cells: [
                    DataCell(Text((index + 1).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(shop.owner_name.toString(), style: TextStyle(fontSize: 14))),
                    DataCell(Text(shop.shop_name.toString(),style: TextStyle(fontSize: 14))),
                    DataCell(
                        Text(shop.email.toString(), style: TextStyle(fontSize: 14))),
                    DataCell(Text(shop.phone.toString(),  style: TextStyle(fontSize: 14))),
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
                    DataCell(_buildViewButton(context)),
                    DataCell(Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Colors.green, width: 2), // Green border
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Accept',
                              style: TextStyle(color: Colors.green)),
                        ),
                        SizedBox(height: 8,),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Colors.red, width: 2), // Green border
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Reject',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          );
        };
        return SizedBox();
      },
    );
  }

  DataColumn _buildHeaderCell(String text) {
    return DataColumn(
      label: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildViewButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showServicesDialog(context);
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text('View'),
    );
  }

  void _showServicesDialog(BuildContext context) {
    List<Map<String, String>> services = [
      {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
      {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
      {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
      {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
      {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
      {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
      {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
      {
        "icon": "assets/icon/household_service.png",
        "name": "Household Service"
      },
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text("Services", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            width: 300, // **Set a fixed width**
            constraints: BoxConstraints(maxHeight: 300), // **Limit max height**
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(services[index]["icon"]!,
                      width: 30, height: 30),
                  title: Text(services[index]["name"]!),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBoldText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}
