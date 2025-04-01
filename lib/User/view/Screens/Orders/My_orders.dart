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

