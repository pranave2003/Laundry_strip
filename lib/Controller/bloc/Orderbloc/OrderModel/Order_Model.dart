// class OrderItem {
//   final String productId;
//   final String productName;
//   final quantity;
//   final String price;
//   final String service;
//   final String catogoty;
//   final String shopid;
//   final String productimage;
//
//   OrderItem({
//     required this.productId,
//     required this.productName,
//     this.quantity,
//     required this.price,
//     required this.service,
//     required this.catogoty,
//     required this.productimage,
//     required this.shopid,
//   });
//
//   Map<String, dynamic> toJson() => {
//         'productId': productId,
//         'productName': productName,
//         'quantity': quantity,
//         'price': price,
//         'shopid': shopid,
//         'service': service,
//         'catogoty': catogoty,
//         'productimage': productimage
//       };
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//       productId: json['productId'],
//       productName: json['productName'],
//       quantity: json['quantity'],
//       price: json['price'],
//       shopid: json['shopid'],
//       service: json['service'],
//       catogoty: json['catogoty'],
//       productimage: json['productimage']);
// }
//
// class OrderModel {
//   final orderid;
//   final List<OrderItem> items;
//   final String userid;
//   final String Totalcharge;
//   final String status;
//
//   final String pickupdate;
//   final String pickupTime;
//   final String Deliverydate;
//   final String DeliveryTime;
//   final String Orderdate;
//   final String username;
//   final shopid;
//   final shopname;
//   final timestamp;
//
//   OrderModel({
//     this.orderid,
//     this.shopid,
//     this.shopname,
//     this.timestamp,
//     required this.items,
//     required this.userid,
//     required this.username,
//     required this.Totalcharge,
//     required this.status,
//     required this.pickupdate,
//     required this.pickupTime,
//     required this.Deliverydate,
//     required this.DeliveryTime,
//     required this.Orderdate,
//   });
//
//   factory OrderModel.fromMap(Map<String, dynamic> json) {
//     return OrderModel(
//         orderid: json['orderId'] ?? '',
//         userid: json['userId'] ?? '',
//         username: json['username'] ?? '',
//         items: (json['items'] as List<dynamic>?)
//                 ?.map(
//                     (item) => OrderItem.fromJson(item as Map<String, dynamic>))
//                 .toList() ??
//             [],
//         Totalcharge: json['totalAmount'] ?? '',
//         status: json['status'] ?? '',
//         Orderdate: json['orderDate'] ?? '',
//         shopid: json['shopid'] ?? '',
//         shopname: json['shopname'] ?? '',
//         pickupdate: json["pickupdate"] ?? '',
//         pickupTime: json["pickupTime"] ?? '',
//         DeliveryTime: json["DeliveryTime"] ?? '',
//         Deliverydate: json["Deliverydate"] ?? '',
//         timestamp: json['timestamp']);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String productId;
  final String productName;
  final dynamic quantity;
  final String price;
  final String service;
  final String catogoty; // Keeping spelling as "catogoty"
  final String shopid;
  final String productimage;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.service,
    required this.catogoty,
    required this.productimage,
    required this.shopid,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity ?? 0, // Ensuring a default value
        'price': price,
        'shopid': shopid,
        'service': service,
        'catogoty': catogoty,
        'productimage': productimage,
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json['productId'] ?? '',
        productName: json['productName'] ?? '',
        quantity: json['quantity'] ?? 0, // Default value for quantity
        price: json['price'] ?? '',
        shopid: json['shopid'] ?? '',
        service: json['service'] ?? '',
        catogoty: json['catogoty'] ?? '',
        productimage: json['productimage'] ?? '',
      );
}

class OrderModel {
  final dynamic orderid;
  final List<OrderItem> items;
  final String userid;
  final String Totalcharge;
  final String status;
  final String pickupdate;
  final String pickupTime;
  final String Deliverydate;
  final String DeliveryTime;
  final String Orderdate;
  final String username;
  final dynamic shopid;
  final dynamic shopname;
  final dynamic deliveryaddress;
  final dynamic Delivered;

  OrderModel({
    required this.orderid,
    required this.shopid,
    required this.shopname,
    required this.items,
    required this.userid,
    required this.username,
    required this.Totalcharge,
    required this.status,
    required this.pickupdate,
    required this.pickupTime,
    required this.Deliverydate,
    required this.DeliveryTime,
    required this.Orderdate,
    this.deliveryaddress,
    this.Delivered,
  });

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
        orderid: json['orderId'] ?? '',
        userid: json['userId'] ?? '',
        username: json['username'] ?? '',
        items: (json['items'] as List<dynamic>?)
                ?.map(
                    (item) => OrderItem.fromJson(item as Map<String, dynamic>))
                .toList() ??
            [],
        Totalcharge: json['totalAmount'] ?? '',
        status: json['status'] ?? '',
        Orderdate: json['orderDate'] ?? '',
        shopid: json['shopid'] ?? '',
        shopname: json['shopname'] ?? '',
        pickupdate: json["pickupdate"] ?? '',
        pickupTime: json["pickupTime"] ?? '',
        DeliveryTime: json["DeliveryTime"] ?? '',
        Deliverydate: json["Deliverydate"] ?? '',
        deliveryaddress: json['deliveryaddress'] ?? "",
        Delivered: json['Delivered'] ?? "");
  }
}
