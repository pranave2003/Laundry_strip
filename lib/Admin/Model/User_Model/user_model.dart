class User {
  final String name;
  final String phone;
  final String email;
  final String image;

  User({
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
  });
  factory User.fromJson(Map<String, String> json) {
    return User(
        name: json["trade"] ?? "",
        phone: json["linkedin"] ?? "",
        email: json["linkedin"] ?? "",
        image: json["linkedin"] ?? "");
  }
}
