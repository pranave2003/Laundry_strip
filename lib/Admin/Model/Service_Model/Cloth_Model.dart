class Cloth_material {
  //final String Material_Type;

  final String All_Materials;
  final String Id;

  Cloth_material({
   // required this.Material_Type,
    required this.All_Materials,
    required this.Id,
  });

  factory Cloth_material.fromJson(Map<String, String> json) {
    return Cloth_material(
        //Material_Type: json["trade"] ?? "",
        All_Materials: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



