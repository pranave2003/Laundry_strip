import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import 'DriverAllOrders.dart';
import 'DriverCompletedWrapper.dart';
import 'DriverDeliverdWrapper.dart';
import 'Driverpikedwrapper.dart';

class DriverOrders extends StatefulWidget {
  const DriverOrders({super.key});

  @override
  State<DriverOrders> createState() => _DriverOrdersState();
}

class _DriverOrdersState extends State<DriverOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverblocBloc, DriverblocState>(
      builder: (context, state) {
        if (state is Driverloading) {
          return const Center(child: Loading_Widget());
        } else if (state is DriverByidLoaded) {
          final driver = state.userData;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Driver Orders",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Picked"),
                  Tab(text: "Delivered"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                DriverAllOrdersWrapper(
                  driverid: driver.driverId,
                ),
                DriverPickedWrapper(driverid: driver.driverId),
                DriverDeliverdWrapper(driverid: driver.driverId),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'DriverAllOrders.dart';
// import 'DriverCompletedWrapper.dart';
// import 'DriverDeliverdWrapper.dart';
// import 'Driverpikedwrapper.dart';
//
// class DriverOrders extends StatefulWidget {
//   final String driverId; // Accept driverId
//
//   const DriverOrders({super.key, required this.driverId});
//
//   @override
//   State<DriverOrders> createState() => _DriverOrdersState();
// }
//
// class _DriverOrdersState extends State<DriverOrders>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Driver Orders ${widget.driverId}",
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         automaticallyImplyLeading: false,
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.blue,
//           unselectedLabelColor: Colors.black,
//           indicatorColor: Colors.blue,
//           tabs: const [
//             Tab(text: "All"),
//             Tab(text: "Pending"),
//             Tab(text: "In Progress"),
//             Tab(text: "Delivered"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           DriverAllOrdersWrapper(driver.driverId),
//           DriverPendingWrapper(widget.driverId),
//           DriverInProgressWrapper(widget.driverId),
//           DriverCompletedWrapper(widget.driverId),
//         ],
//       ),
//     );
//   }
// }

//
//
