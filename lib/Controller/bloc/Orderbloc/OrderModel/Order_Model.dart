

class OrderItem {
  final String productId;
  final String productName;
  final quantity;
  final String price;
  final String service;
  final String catogoty;
  final String shopid;
  final String productimage;

  OrderItem({
    required this.productId,
    required this.productName,
    this.quantity,
    required this.price,
    required this.service,
    required this.catogoty,
    required this.productimage,
    required this.shopid,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'price': price,
        'shopid': shopid,
        'service': service,
        'catogoty': catogoty,
        'productimage': productimage
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
      shopid: json['shopid'],
      service: json['service'],
      catogoty: json['catogory'],
      productimage: json['productimage']);
}

class OrderModel {
  final orderid;
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
  final shopid;
  final shopname;

  OrderModel({
    this.orderid,
    this.shopid,
    this.shopname,
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
  });

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        orderid: json['orderId'],
        userid: json['userId'],
        username: json['username'],
        items: (json['items'] as List)
            .map((item) => OrderItem.fromJson(item))
            .toList(),
        Totalcharge: json['totalAmount'],
        status: json['status'],
        Orderdate: json['orderDate'],
        shopid: json['shopid'],
        shopname: json['shopname'],
        pickupdate: json["pickupdate"],
        pickupTime: json["pickupTime"],
        DeliveryTime: json["DeliveryTime"],
        Deliverydate: json["Deliverydate"],
      );

  // factory OrderModel.fromMap(Map<String, dynamic> data) {
  //   return OrderModel(
  //     userphone: data["userphone"],
  //     Totalcharge: data["Totalcharge"],
  //     orderid: data['orderid'],
  //     service: data['service'],
  //     category: data['category'],
  //     product: data['product'],
  //     userid: data['userid'],
  //     shopid: data['shopid'],
  //     pickup_date: data['pickup_date'],
  //     pickup_time: data['pickup_time'],
  //     delivery_date: data['delivery_date'],
  //     delivery_time: data['delivery_time'],
  //     payment: data['payment'],
  //     transactionid: data['transactionid'],
  //     qrid: data['qrid'],
  //     status: data['status'],
  //     driverid: data['driverid'],
  //   );
  // }
}
