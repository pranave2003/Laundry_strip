class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? place;
  String? post;
  String? pin;
  String? District;
  String? state;
  String? phone;
  String? status;
  String? imageUrl;
  String? ban;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.uid,
    this.place,
    this.post,
    this.pin,
    this.District,
    this.state,
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
      place: data['place'],
      post: data['post'],
      pin: data['pin'],
      District: data['District'],
      state: data["state"],
      imageUrl: data['imageUrl'],
    );
  }
}
