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
      material_id: data['material_id'],
      material_type: data['material_type'],
      material_name: data['material_name'],
    );
  }
}
