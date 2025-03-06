class Shoe_material {
  //final String Material_Type;

  final String All_Materials;
  final String Id;

  Shoe_material({
    // required this.Material_Type,
    required this.All_Materials,
    required this.Id,
  });

  factory Shoe_material.fromJson(Map<String, String> json) {
    return Shoe_material(
      //Material_Type: json["trade"] ?? "",
        All_Materials: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



