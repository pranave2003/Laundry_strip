import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/ServiceManagement/Service_Model/Material_Model.dart';
import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';

class EdittingMaterial extends StatefulWidget {
  const EdittingMaterial({
    super.key,
    required this.materialid,
    required this.materialname,
    required this.materialtype,
  });

  final materialid;
  final materialname;
  final materialtype;

  @override
  State<EdittingMaterial> createState() => _EdittingMaterialState();
}

class _EdittingMaterialState extends State<EdittingMaterial> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceNameController = TextEditingController();
  String? selectCategory;

  @override
  void initState() {
    super.initState();
    serviceNameController.text = widget.materialname;
    selectCategory = widget.materialtype;
  }

  void _updateMaterial() {
    if (_formKey.currentState!.validate()) {
      MaterialModel cloth = MaterialModel(
        material_id: widget.materialid,
        material_name: serviceNameController.text,
        material_type: selectCategory ?? "",
      );

      context.read<ServiceBloc>().add(EditMaterial(cloth: cloth));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Cloth Material",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 18),
                  Container(height: 40, width: 400),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                  /// Material Type Field
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Material Type",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          validator: (value) =>
                          value == null ? "Please select a material type" : null,
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

                  /// Material Name Field
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: Text(
                          "Material Name",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          validator: (value) =>
                          value == null || value.isEmpty ? "Material name is required" : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  /// Submit Button
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _updateMaterial,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
