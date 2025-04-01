import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../Services/service.dart';
import 'Order/Allorders.dart';
import 'Order/CancelledOreder.dart';
import 'Order/Deliverd.dart';
import 'Order/inprogress.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int selectedIndex = 0;
  List<String> filters = ["All", "In Progress", "Delivered", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(filters.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? Colors.blue
                            : Colors.grey.shade200,
                        foregroundColor: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(filters[index]),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                Allorderswrapper(),
                Inprogresswrapper(),
                Deliverdwrrapper(),
                Cancelorderwrapper(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Myallorder extends StatefulWidget {
  const Myallorder({super.key});

  @override
  State<Myallorder> createState() => _MyallorderState();
}

class _MyallorderState extends State<Myallorder> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      if (state is ShopLoading) {
        return Center(child: Loading_Widget());
      } else if (state is Shopfailerror) {
        return Text(state.error.toString());
      } else if (state is Shoploaded) {
        if (state.Shop.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }
        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: state.Shop.length,
            itemBuilder: (context, index) {
              final Shop = state.Shop[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/shop_img/img.png",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Shop.shop_name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                Shop.shopid.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "${Shop.District}, ${Shop.city}, ${Shop.post}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Shop.selectServices != null &&
                                        Shop.selectServices!.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          Shop.selectServices!.length,
                                          (index) => Text(
                                            Shop.selectServices![index],
                                            style:
                                                TextStyle(color: Colors.green),
                                          ), // Display each service
                                        ),
                                      )
                                    : Text(
                                        "No Services Available"), // Show message if list is empty
                              ),
                            ],
                          ),
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
    });
  }
}
