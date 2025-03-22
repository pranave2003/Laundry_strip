class MaterialModel {
  String? material_id;
  String? material_type;
  String? material_name;

  MaterialModel({
    this.material_id,
    this.material_type,
    this.material_name,

  });
  factory MaterialModel.fromMap(Map<String, dynamic> data) {
    return MaterialModel(
      material_id: data['materialid'],
      material_type: data['materialtype'],
      material_name: data['materialname'],
    );
  }
}
