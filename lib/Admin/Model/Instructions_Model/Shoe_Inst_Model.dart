class Shoes_instruction {
  //final String Material_Type;

  final String All_Materials;
  final String Id;

  Shoes_instruction({
    // required this.Material_Type,
    required this.All_Materials,
    required this.Id,
  });

  factory Shoes_instruction.fromJson(Map<String, String> json) {
    return Shoes_instruction(
      //Material_Type: json["trade"] ?? "",
        All_Materials: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



