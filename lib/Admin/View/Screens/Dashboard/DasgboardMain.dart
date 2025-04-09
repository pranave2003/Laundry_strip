import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Widget/constands/Loading.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text("Hello !", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Cheers and happy activities", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            const Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                StatCard(
                  title: "Total User",
                  value: "40,689",
                  subtitle: "8.5% Up from yesterday",
                  icon: Icons.person,
                  iconBgColor: Color(0xFFE3D7FF),
                  iconColor: Colors.purple,
                ),
                StatCard(
                  title: "Total Order",
                  value: "10293",
                  subtitle: "1.3% Up from past week",
                  icon: Icons.shopping_bag,
                  iconBgColor: Color(0xFFFFF3C2),
                  iconColor: Colors.orange,
                ),
                StatCard(
                  title: "Total Shops",
                  value: "\$89,000",
                  subtitle: "4.3% Down from yesterday",
                  icon: Icons.house_siding,
                  iconBgColor: Color(0xFFCFFFE0),
                  iconColor: Colors.green,
                ),
                StatCard(
                  title: "Total Pending",
                  value: "2040",
                  subtitle: "1.8% Up from yesterday",
                  icon: Icons.schedule,
                  iconBgColor: Color(0xFFFFE5E5),
                  iconColor: Colors.deepOrange,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text("Order Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            BlocBuilder<OrderBloc, OrderState>(
  builder: (context, state) {
    if (state is orderfetchloading) {
    return Center(child: Loading_Widget());
    } else if (state is OrderLoaded) {
      if (state.orders.isEmpty) {
        return Center(
          child: Text("No Orders"),
        );
      }
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(
                0, 4)),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 70,
            columns: const [
              DataColumn(
                  label: Text("S.No",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              DataColumn(
                  label: Text("Order Id",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              DataColumn(
                  label: Text("Shop Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              DataColumn(
                  label: Text("Customer Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),

              DataColumn(
                  label: Text("Pick Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              DataColumn(
                  label: Text("Delivery",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              DataColumn(
                  label: Text("Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),

              DataColumn(
                  label: Text("Status",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
            ],
    rows: List.generate(state.orders.length, (index) {
    final order = state.orders[index];
    return DataRow(cells: [
    DataCell(Text((index + 1).toString())), // Serial Number
    DataCell(Text(order.orderid.toString())),
    DataCell(Text(order.shopname.toString())),
    DataCell(Text(order.username.toString())),
      DataCell(Text("${order.pickupdate} at ${order.pickupTime}")),
      DataCell(Text("${order.Deliverydate} at ${order.DeliveryTime}")),
      DataCell(Text(
        "₹ ${order.Totalcharge}"
      ),),

    DataCell(Container(
    padding: EdgeInsets.symmetric(
    horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
    color: Colors.green.shade100,
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Text(
    "Delivered", style: TextStyle(color: Colors.green)),
    )),
    ]);

    }).toList(),

          ),
        ),
      );
    }return SizedBox();
  },
),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}