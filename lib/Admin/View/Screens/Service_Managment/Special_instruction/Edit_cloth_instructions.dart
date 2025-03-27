import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/ServiceManagement/Service_Model/Instruction_Model.dart';

import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';

class ClothInstructionsEdit extends StatefulWidget {
  const ClothInstructionsEdit({super.key,
    required this.instructionid,
    required this.instructiontype,
    required this.instructionname});

  final instructionid;
  final instructiontype;
  final instructionname;

  @override
  State<ClothInstructionsEdit> createState() => _ClothInstructionsEditState();
}

class _ClothInstructionsEditState extends State<ClothInstructionsEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceNameController = TextEditingController();
  String? selectCategory;

  @override
  void initState() {
    super.initState();
    serviceNameController.text = widget.instructionname;
    selectCategory = widget.instructiontype;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Edit Cloth Instruction",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 18),
                  Container(
                    height: 40,
                    width: 400,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Material Type Dropdown**
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          "Material Type",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Category',
                          ),
                          value: selectCategory,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectCategory = newValue;
                            });
                          },
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please select a category'
                              : null,
                          items: ['cloth', 'Bag', 'Shoes']
                              .map((String category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        height: 40,
                        child: Text(
                          "Instruction Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: serviceNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Instruction Name",
                          ),
                          validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Instruction name cannot be empty'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            InstructionModel instruction = InstructionModel(
                              instruction_id: widget.instructionid,
                              instruction_name: serviceNameController.text,
                              instruction_type: selectCategory ?? "",
                            );
                            context
                                .read<ServiceBloc>()
                                .add(EditInstruction(instruction: instruction));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
