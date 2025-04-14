// import 'package:flutter/material.dart';
// import 'package:laundry/User/view/Screens/Orders/payment_successful.dart';
// import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/Addproductmodel/Addproductmodel.dart';
// import '../../../../Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
// import '../../../../Widget/constands/colors.dart';
//
// class OrderSummaryPage extends StatelessWidget {
//   OrderSummaryPage(this.selectedItems, {super.key, required this.shop});
//   final ShopModel shop;
//   Set<Addproductmodel> selectedItems;
//   void updateSelectedItems(Addproductmodel item, {bool remove = false}) {
//     if (remove) {
//       selectedItems.remove(item);
//     } else {
//       if (!selectedItems.contains(item)) {
//         selectedItems.add(item);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Order Summary",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Laundry Shop Info
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     "assets/shop_img/img.png", // Change this to your actual image path
//                     width: 80,
//                     height: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         shop.shop_name.toString(),
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.local_laundry_service,
//                               size: 16, color: Colors.blue),
//                           const SizedBox(width: 4),
//                           const Text("Laundry",
//                               style: TextStyle(color: Colors.black)),
//                           const SizedBox(width: 10),
//                           const Icon(Icons.star,
//                               color: Colors.yellow, size: 16),
//                           const Text(" 4.8",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on,
//                               size: 16, color: Colors.blue),
//                           const Text(" 0.8 km"),
//                           const SizedBox(width: 10),
//                           const Icon(Icons.timer, size: 16, color: Colors.blue),
//                           const Text(" 5 Mins"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Booking and Delivery Dates
//             _buildDateRow("Booking Date", "Jan 03, 2025 | 09:10 AM"),
//             _buildDateRow("Pickup Date & Time", "Jan 08, 2025 | 10:00 AM"),
//             _buildDateRow("Delivery Date & Time", "Jan 14, 2025 | 09:00 AM"),
//             const Divider(height: 20, thickness: 1),
//             // Added Items
//
//             _buildAddedItemsSection(),
//             _buildAddedItem("Dry Clean", "₹ 200.00"),
//             _buildAddedItem("Dry Clean", "₹ 200.00"),
//             const Divider(height: 20, thickness: 1),
//             // Total Charges
//             const Text("Total Charges",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             _buildChargeRow("Wash + Fold", "₹ 150.00"),
//             _buildChargeRow("Dry Clean (2)", "₹ 200.00"),
//             _buildChargeRow("Delivery Charges", "₹ 30.00"),
//             _buildChargeRow("Tax & Fees", "₹ 10.00"),
//             const Divider(height: 20, thickness: 1),
//             _buildChargeRow("Total", "₹ 360.00", isBold: true),
//             const SizedBox(height: 80),
//             // Complete Payment Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             PaymentSuccessful()), // Replace with your destination page
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: defaultColor,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Text(
//                   "Complete Payment",
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget for booking/delivery details
//   Widget _buildDateRow(String title, String date) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: const TextStyle(color: Colors.black87, fontSize: 14)),
//           Text(date,
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddedItemsSection() {
//     return ExpansionTile(
//       title: Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
//       initiallyExpanded: true, // This keeps the ExpansionTile open by default
//       children: selectedItems.map((item) {
//         return ListTile(
//           leading: Image.asset(item.product_image, width: 40, height: 40),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(item.product_name),
//               Text(item.Productprice),
//             ],
//           ),
//           trailing: IconButton(
//             icon: Icon(Icons.remove_circle_outline, color: Colors.red),
//             onPressed: () => updateSelectedItems(item, remove: true),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   // Widget for added items
//   Widget _buildAddedItem(String name, String price) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(name, style: const TextStyle(fontSize: 14)),
//           Row(
//             children: [
//               Text(price,
//                   style: const TextStyle(
//                       fontSize: 14, fontWeight: FontWeight.bold)),
//               const SizedBox(width: 10),
//               GestureDetector(
//                 onTap: () {
//                   // Handle delete action
//                 },
//                 child: const Icon(Icons.delete, color: Colors.red),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget for total charges row
//   Widget _buildChargeRow(String label, String amount, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
//           ),
//           Text(
//             amount,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../Controller/bloc/Orderbloc/OrderModel/Order_Model.dart';
import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../../Controller/bloc/ServiceManagement/Shopadddproduct/Addproductmodel/Addproductmodel.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
import '../../../../Widget/constands/Loading.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage(this.selectedItems,
      {super.key,
      required this.shop,
      required this.pickupdate,
      required this.deliveryDate,
      this.selectedDeliveryTimeSlot,
      this.selectedTimeSlot,
      required this.Userid,
      required this.username,
      required this.address});
  final ShopModel shop;
  final pickupdate;
  final deliveryDate;
  final selectedDeliveryTimeSlot;
  final selectedTimeSlot;
  final Userid;
  final username;
  final address;
  final Set<Addproductmodel> selectedItems;

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Set<Addproductmodel> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = Set.from(widget.selectedItems);
  }

  void updateSelectedItems(Addproductmodel item, {bool remove = false}) {
    setState(() {
      if (remove) {
        selectedItems.remove(item);
      } else {
        if (!selectedItems.contains(item)) {
          selectedItems.add(item);
        }
      }
    });
  }

  double calculateTotalPrice() {
    return selectedItems.fold(
        0, (sum, item) => sum + double.parse(item.Productprice));
  }

  String formattedDate = DateFormat("dd/MM/yyyy").format(DateTime.now());

  void placeOrder(BuildContext context) {
    final order = OrderModel(
      deliveryaddress: widget.address,
      orderid: "",
      userid: widget.Userid, // You should replace this with the actual user ID
      username: widget.username,
      items: selectedItems.map((item) {
        return OrderItem(
            productimage: item.product_image,
            productId:
                item.productid, // Ensure 'id' is available in Addproductmodel
            productName: item.product_name,
            quantity: 1, // If you have a quantity field, update accordingly
            price: item.Productprice,
            service: item.service,
            shopid: item.shopid,
            catogoty: item.category,
            instruction: "",
            meterialtype: "");
      }).toList(),
      Totalcharge: calculateTotalPrice().toString(),
      status: '1',

      shopid: widget.shop.shopid,
      shopname: widget.shop.shop_name,
      Orderdate: formattedDate,
      Deliverydate: widget.deliveryDate,
      DeliveryTime: widget.selectedDeliveryTimeSlot,
      pickupdate: widget.pickupdate,
      pickupTime: widget.selectedTimeSlot,
    );

    context.read<OrderBloc>().add(placeorder(order));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Order Summary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopInfo(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDateRow("Pickup Date", "${widget.pickupdate}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDateRow("Pickup Time", "${widget.selectedTimeSlot}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDateRow("Delivery Date ", "${widget.deliveryDate}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDateRow("Time",
                  "${widget.deliveryDate}| ${widget.selectedDeliveryTimeSlot}"),
            ),
            const Divider(height: 20, thickness: 1),
            _buildAddedItemsSection(),
            const Divider(height: 20, thickness: 1),
            _buildTotalCharges(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => placeOrder(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Place Order",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          )),
    );
  }

  Widget _buildDateRow(String title, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(date, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildShopInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(10),
        //   child: Image.asset(
        //     "assets/shop_img/img.png",
        //     width: 80,
        //     height: 80,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12), // Rounded corners for image
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.shop.ShopImage.toString(),
              width: 100, // Adjusted width
              height: 100, // Adjusted height
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[300], // Placeholder background
                child: Center(
                  child: Loading_Widget(), // Loading indicator
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 100,
                height: 100,
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
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.shop.shop_name.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.local_laundry_service,
                      size: 16, color: Colors.blue),
                  SizedBox(width: 4),
                  Text("Laundry Capacity: ${widget.shop.LaundryCapacity} kg",
                      style: TextStyle(color: Colors.black)),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(" 4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.blue),
                  Text(" ${widget.shop.District} "),
                  SizedBox(width: 10),
                  Icon(Icons.timer, size: 16, color: Colors.blue),
                  Text(" 5 Mins"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddedItemsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      child: ExpansionTile(
        title: Text("Added Items", style: TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: true, // This keeps the ExpansionTile open by default
        children: selectedItems.map((item) {
          return ListTile(
            leading: Image.asset(item.product_image, width: 40, height: 40),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product_name),
                Text(item.Productprice),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => updateSelectedItems(item, remove: true),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTotalCharges() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Charges",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("₹${calculateTotalPrice().toStringAsFixed(2)}",
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(height: 20, thickness: 1),
            ],
          ),
        ],
      ),
    );
  }
}
