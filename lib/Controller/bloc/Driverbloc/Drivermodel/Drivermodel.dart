class Driver {
  final String name;
  final String phone;
  final String driverId;
  final String email;
  String? password;
  String? ban;
  final String image;
  final String proof;
  final  available;
  final timestamp;


  Driver({
    this.timestamp,
    required this.name,
    required this.phone,
    required this.driverId,
    required this.email,
    this.password,
    this.available,
    this.ban,
    required this.image,
    required this.proof,

  });

  factory Driver.fromMap(Map<String, dynamic> data) {
    return Driver(
      email: data['email'],
      driverId: data['driverId'],
      name: data['name'],
      phone: data['phone'],
      ban: data['ban'],
      proof: data['proof'],
      image: data['imageUrl'],
    );
  }
}
