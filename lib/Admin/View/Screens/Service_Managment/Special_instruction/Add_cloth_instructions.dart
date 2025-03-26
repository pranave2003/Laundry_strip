import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/ServiceManagement/Service_Model/Instruction_Model.dart';
import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class ClothInstructionsAdd extends StatefulWidget {
  const ClothInstructionsAdd({super.key});

  @override
  State<ClothInstructionsAdd> createState() => _ClothInstructionsAddState();
}

class _ClothInstructionsAddState extends State<ClothInstructionsAdd> {
  TextEditingController serviceNameController = TextEditingController();
  String? selectCategory;
  final _formKey = GlobalKey<FormState>(); // Form Key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey, // Wrap with Form
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Instruction",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 18),
                  Container(height: 40, width: 400),
                ],
              ),
            ),
            SizedBox(height: 50),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  // **Instruction Type Dropdown**
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Instruction Type",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Category',
                          ),
                          value: selectCategory,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectCategory = newValue;
                            });
                          },
                          validator: (value) => value == null ? 'Please select a category' : null, // Validation
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

                  SizedBox(height: 20),

                  // **Instruction Name Field**
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: Text(
                          "Instruction Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: serviceNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Instruction Name",
                          ),
                          validator: (value) =>
                          (value == null || value.isEmpty) ? 'Please enter instruction name' : null, // Validation
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // **Submit Button**
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: BlocConsumer<ServiceBloc, ServiceState>(
                        listener: (context, state) {
                          if (state is InstructionSuccess) {
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                InstructionModel user = InstructionModel(
                                  instruction_name: serviceNameController.text,
                                  instruction_type: selectCategory,
                                );

                                context.read<ServiceBloc>().add(InstructionAddEvent(instruction: user));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: state is InstructionLoading
                                ? Loading_Widget()
                                : Text(
                              "Submit",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
