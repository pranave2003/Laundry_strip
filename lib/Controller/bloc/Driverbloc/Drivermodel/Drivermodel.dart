class Driver {
  final String name;
  final String phone;
  final String driverId;
  final String email;
  String? password;
  final String image;
  final String proof;
  final String timestamp;
  final bool isActive;

  Driver({
    required this.timestamp,
    required this.name,
    required this.phone,
    required this.driverId,
    required this.email,
    this.password,
    required this.image,
    required this.proof,
    required this.isActive,
  });

  factory Driver.fromMap(Map<String, dynamic> data) {
    return Driver(
      email: data['email'],
      driverId: data['driverId'],
      name: data['name'],
      phone: data['phone'],
      isActive: data['isActive'],
      proof: data['proof'],
      timestamp: data['timestamp'],
      image: data['imageUrl'],
    );
  }
}
