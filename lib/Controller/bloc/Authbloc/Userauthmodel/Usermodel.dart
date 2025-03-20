class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? District;
  String? Address;
  String? phone;
  String? status;
  String? imageUrl;
  String? ban;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.uid,
    this.District,
    this.Address,
    this.phone,
    this.status,
    this.ban,
    this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      uid: data['userId'],
      name: data['name'],
      phone: data['phone'],
      status: data['status'],
      ban: data['ban'],
      District: data['District'],
      Address: data["Address"],
      imageUrl: data['imageUrl'],
    );
  }
}
