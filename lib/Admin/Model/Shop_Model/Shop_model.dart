class ShopDetailsModel {
  final String shopName;
  final String laundryCapacity;
  final String address;
  final String email;
  final String phone;
  final String status;
  final String imagePath; // Added field for shop image

  ShopDetailsModel({
    required this.shopName,
    required this.laundryCapacity,
    required this.address,
    required this.email,
    required this.phone,
    required this.status,
    required this.imagePath, // Add this field
  });

  // Factory method to create an object from a JSON Map
  factory ShopDetailsModel.fromJson(Map<String, String> json) {
    return ShopDetailsModel(
      shopName: json["ShopName"] ?? "",
      laundryCapacity: json["LaundryCapacity"] ?? "",
      address: json["Address"] ?? "",
      email: json["Email"] ?? "",
      phone: json["Phone"] ?? "",
      status: json["Status"] ?? "",
      imagePath: json["ImagePath"] ?? "assets/shop_img/img2.png", // Default image
    );
  }
}
