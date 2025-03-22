class BagInstructionModel {
  String? bag_instruction_id;
  String? bag_instruction_name;

  BagInstructionModel({this.bag_instruction_id,
    this.bag_instruction_name,
  });
  factory BagInstructionModel.fromMap(Map<String, dynamic> data) {
    return BagInstructionModel(
      bag_instruction_id: data['bagid'],
      bag_instruction_name: data['instructionname'],


    );
  }
}