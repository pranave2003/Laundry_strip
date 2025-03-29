class OrderModel {
  final orderid;
  final String service;
  final String category;
  final String product;
  final String userid;
  final String shopid;
  final String pickup_date;
  final String pickup_time;
  final String delivery_date;
  final String delivery_time;
  final String payment;
  final String transactionid;
  final String qrid;
  final String status;
  final String driverid;



  OrderModel({
    this.orderid,
    required this.service,
    required this.category,
    required this.product,
    required this.userid,
    required this.shopid,
    required this.pickup_date,
    required this.pickup_time,
    required this.delivery_date,
    required this.delivery_time,
    required this.payment,
    required this.transactionid,
    required this.qrid,
    required this.status,
    required this.driverid,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderid: data['orderid'],
      service: data['service'],
      category: data['category'],
      product: data['product'],
      userid: data['userid'],
      shopid: data['shopid'],
      pickup_date: data['pickup_date'],
      pickup_time: data['pickup_time'],
      delivery_date: data['delivery_date'],
      delivery_time: data['delivery_time'],
      payment: data['payment'],
      transactionid: data['transactionid'],
      qrid: data['qrid'],
      status: data['status'],
      driverid: data['driverid'],
    );
  }
}