class Bag_material {
  //final String Material_Type;

  final String All_Materials;
  final String Id;

  Bag_material({
    // required this.Material_Type,
    required this.All_Materials,
    required this.Id,
  });

  factory Bag_material.fromJson(Map<String, String> json) {
    return Bag_material(
      //Material_Type: json["trade"] ?? "",
        All_Materials: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



