import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import 'Shopallorderwrapper.dart';
import 'Shopdeliverdwrapper.dart';
import 'Shopinprogress.dart';
import 'Shopordercanlledwrapper.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
      builder: (context, state) {
        if (state is Shoploading) {
          return const Center(child: Loading_Widget());
        } else if (state is ShopByidLoaded) {
          final shop = state.userData;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Orders ${state.userData.shopid}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: "Pending"),
                  Tab(text: "In Progress"),
                  Tab(text: "Delivered"),
                  Tab(text: "Cancelled"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Shopallorderwrapper(shop.shopid),
                Shopinprogresswrapper(shop.shopid),
                ShopiDeliverdwrapper(shop.shopid),
                Shop_orderCancelledwrapper(shop.shopid),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
