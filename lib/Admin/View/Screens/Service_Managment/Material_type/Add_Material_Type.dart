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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Cloth Material",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 18,
                ),
                Container(
                  height: 40,
                  width: 400,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
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
                /// **Service Name Field (Text & Input in Same Line)**
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
                        value: selectCategory, // The currently selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectCategory = newValue;
                          });
                        },
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
                Row(
                  children: [
                    /// **Label**
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

                    /// **Input Field**
                    Expanded(
                      child: TextField(
                        controller: serviceNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Material Name",
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                /// **Submit Button (Styled as per Image)**
                Center(
                  child: SizedBox(
                    width: 120, // Match image size
                    height: 40, // Match image height
                    child: BlocConsumer<ServiceBloc, ServiceState>(
                      listener: (context, state) {
                        if (state is meterialSuccess) {}
                        Navigator.of(context).pop();
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            MaterialModel user = MaterialModel(
                                material_name: serviceNameController.text,
                                material_type: selectCategory);
                            // Trigger the sign-up event
                            context
                                .read<ServiceBloc>()
                                .add(MaterialAddevent(cloth: user));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Green color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Small rounded corners
                            ),
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
                SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
    ();
  }
}
