class InstructionModel {
  String? instruction_id;
  String? instruction_type;
  String? instruction_name;

  InstructionModel({this.instruction_id,
    this.instruction_type,
    this.instruction_name,
  });
  factory InstructionModel.fromMap(Map<String, dynamic> data) {
    return InstructionModel(
      instruction_id: data['instruction_id'],
      instruction_type: data['instruction_type'],
      instruction_name: data['instruction_name'],
    );
  }
}