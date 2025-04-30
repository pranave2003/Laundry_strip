class Driver {
  final String name;
  final String phone;
  final String driverId;
  final String email;
  String? password;
  String? ban;
  late final String image;
  late final String proof;
  final  available;
  final timestamp;
  final aadhar;
  final Availablestatus;


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
    required this.aadhar,
     this.Availablestatus,

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
      aadhar: data['aadhar'],
      Availablestatus: data['Availablestatus'],
    );
  }
}
