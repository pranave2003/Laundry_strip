class ShopModel {
  String? shopid;
  String? owner_name;
  String? shop_name;
  String? phone;
  String? email;
  String? password;
  String? District;
  String? shopAddress;
  String? LaundryCapacity;
  List<String>? selectServices;
  String? ShopImage;
  String? ShopProof;
  String? status;
  String? ban;

  ShopModel(
      {this.shopid,
      this.owner_name,
        this.shop_name,
      this.phone,
      this.email,
      this.password,
      this.District,
      this.shopAddress,
      this.LaundryCapacity,
      this.selectServices,
      this.ShopImage,
      this.ShopProof,
      this.status,
      this.ban});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "selectServices": selectServices, // Store as a list
    };
  }

  // Convert from JSON
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      selectServices:
          List<String>.from(json["selectServices"] ?? []), // Ensure it's a list
    );
  }
  factory ShopModel.fromMap(Map<String, dynamic> data) {
    return ShopModel(
      shopid: data['shopId'],
      owner_name: data['owner_name'],
      shop_name: data['Shop_Name'],
      email: data['email'],
      phone: data['phone'],
      status: data['status'],
      ban: data['ban'],
      District: data['District'],
      shopAddress: data["Address"],
      ShopImage: data['imageUrl'],
      LaundryCapacity: data['Laundry_Capacity'],
    );
  }
}
