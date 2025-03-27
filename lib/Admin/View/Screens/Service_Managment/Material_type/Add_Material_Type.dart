import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/ServiceManagement/service_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';

import '../../../../../Controller/bloc/ServiceManagement/Service_Model/Material_Model.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({super.key});

  @override
  State<AddMaterial> createState() => _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {
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
                    "Add Cloth Material",
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
                  /// **Material Type Dropdown**
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Material Type",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
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
                          validator: (value) => value == null
                              ? 'Please select a category'
                              : null, // Validation
                          items: ['cloth', 'Bag', 'Shoes']
                              .map(
                                  (String category) => DropdownMenuItem<String>(
                                        value: category,
                                        child: Text(category),
                                      ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  /// **Material Name Field**
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40, // Match image height
                        child: Text(
                          "Material Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: serviceNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Material Name",
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter material name'
                              : null, // Validation
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  /// **Submit Button**
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: BlocConsumer<ServiceBloc, ServiceState>(
                        listener: (context, state) {
                          if (state is meterialSuccess) {
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                MaterialModel user = MaterialModel(
                                  material_name: serviceNameController.text,
                                  material_type: selectCategory,
                                );

                                context
                                    .read<ServiceBloc>()
                                    .add(MaterialAddevent(cloth: user));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: state is Loading
                                ? Loading_Widget()
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
