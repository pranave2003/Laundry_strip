import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Orderbloc/order_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_state.dart';
import '../Bottom_Navigation/Shop_nav.dart';

class AcailableDriverwrapper extends StatelessWidget {
  const AcailableDriverwrapper({super.key, required this.orderid});

  final orderid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DriverblocBloc>(
      create: (context) => DriverblocBloc()
        ..add(
          FetchDrivers(status: true, searchQuery: null),
        ),
      child: AvailableDrivers(orderid),
    );
  }
}

class AvailableDrivers extends StatelessWidget {
  AvailableDrivers(
    this.orderid,
  );

  final orderid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Assign Driver",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Available Drivers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            BlocConsumer<DriverblocBloc, DriverblocState>(
              listener: (context, state) {
                if (state is DriverSuccess) {
                  context
                      .read<DriverblocBloc>()
                      .add(FetchDrivers(status: true, searchQuery: "null"));
                }
              },
              builder: (context, state) {
                if (state is DriverLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DriverFailure) {
                  return Center(child: Text("${state.error}"));
                } else if (state is Driverloaded) {
                  if (state.Drivers.isEmpty) {
                    // Return "No data found" if the list is empty
                    return Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 700),
                        child: ListView.builder(
                          itemCount: state.Drivers.length,
                          itemBuilder: (context, index) {
                            final driver = state.Drivers[index];

                            return state.Drivers.isEmpty
                                ? Center(child: Text("Nodata"))
                                : Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.grey[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            // backgroundImage:
                                            //     ? NetworkImage(driver.image)
                                            //     : null,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(driver.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                Text(
                                                    "Phone No: ${driver.phone}"),
                                                Text(
                                                    "Email Id: ${driver.email}"),
                                                Text(
                                                    "Driver ID: ${driver.driverId}"),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: driver.isActive
                                                        ? Colors.green
                                                        : Colors.red,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  BlocConsumer<OrderBloc,
                                                      OrderState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is orderRefresh) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return ShopBottomNavWrapper();
                                                          },
                                                        ));
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return TextButton(
                                                          onPressed: () {
                                                            context.read<
                                                                OrderBloc>()
                                                              ..add(Assigndriver(
                                                                  orderid:
                                                                      orderid,
                                                                  PIckup: "1",
                                                                  driverid: driver
                                                                      .driverId,
                                                                  drivername:
                                                                      driver
                                                                          .name,
                                                                  drivernumber:
                                                                      driver
                                                                          .phone));
                                                          },
                                                          child: state
                                                                  is ActionLoading
                                                              ? Loading_Widget()
                                                              : Text(
                                                                  "Assign Driver",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ));
                                                    },
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
