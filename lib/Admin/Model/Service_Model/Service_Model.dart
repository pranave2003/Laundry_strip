class Service_type {
  final String All_Materials;

  final String Image;
  final String Id;

  Service_type({
    required this.All_Materials,
    required this.Image,
    required this.Id,
  });

  factory Service_type.fromJson(Map<String, String> json) {
    return Service_type(
        All_Materials: json["trade"] ?? "",
        Image: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



