class Order {
  final String orderId;
  final String name;
  final String orderedDate;
  final String pickupDate;
  final String deliveryDate;
  final String status;

  Order({
    required this.orderId,
    required this.name,
    required this.orderedDate,
    required this.pickupDate,
    required this.deliveryDate,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json["orderId"] ?? "",
      name: json["name"] ?? "",
      orderedDate: json["orderedDate"] ?? "",
      pickupDate: json["pickupDate"] ?? "",
      deliveryDate: json["deliveryDate"] ?? "",
      status: json["status"] ?? "",
    );
  }
}
