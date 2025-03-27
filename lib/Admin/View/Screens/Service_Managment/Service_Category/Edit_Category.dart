import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/ServiceManagement/Service_Model/Category_Model.dart';
import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({super.key,
    required this.catogoryid,
    required this.Productname,
    required this.productimage,
    required this.service,
    required this.category});

  final catogoryid;
  final Productname;
  final service;
  final category;
  final productimage;

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  String? imagePath;
  String? selectedServiceType;
  String? selectedCategory;

  List<String> serviceTypes = [
    "Wash + Fold",
    "Wash + Iron",
    "Steam Iron",
    "Dry Clean",
    "Bag Service",
    "Shoe Service",
    "Household Service",
    "Stain Removal"
  ];
  List<String> categories = ["Men", "Women", "Kids", "Household"];

  @override
  void initState() {
    super.initState();
    productNameController.text = widget.Productname;
    imagePath = widget.productimage;
    selectedServiceType = widget.service;
    selectedCategory = widget.category;
  }

  // void _updateCategory() {
  //   if (_formKey.currentState!.validate()) {
  //     CategoryModel category = CategoryModel(
  //       category_id: widget.catogoryid,
  //       product_name: productNameController.text,
  //       service: selectedServiceType ?? "",
  //       category: selectedCategory ?? "",
  //       product_image: imagePath ?? "",
  //     );
  //
  //     context.read<ServiceBloc>().add(EditCategory(category: category));
  //   }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Edit Category",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 18),
                  Container(height: 40, width: 400),
                ],
              ),
            ),
            SizedBox(height: 40),

            /// **Service Type Dropdown**
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
                  Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text("Service Type",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedServiceType,
                          items: serviceTypes.map((String type) {
                            return DropdownMenuItem(
                                value: type, child: Text(type));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedServiceType = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null ? "Please select a service type" : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Select Service"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  /// **Category Dropdown**
                  Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text("Category",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          items: categories.map((String category) {
                            return DropdownMenuItem(
                                value: category, child: Text(category));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null ? "Please select a category" : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Select Category"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  /// **Product Name Field**
                  Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text("Product Name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: productNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product Name"),
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? "Product name is required"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  /// **Product Image Selection**
                  Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text("Product Image",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Product Image',
                          ),
                          value: imagePath,
                          onChanged: (String? newValue) {
                            setState(() {
                              imagePath = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null
                              ? "Please select a product image"
                              : null,
                          items: [
                            DropdownMenuItem(
                              value: 'assets/Dress/t-shirt.png',
                              child: Row(
                                children: [
                                  Image.asset('assets/Dress/t-shirt.png',
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'assets/Dress/shirt.png',
                              child: Row(
                                children: [
                                  Image.asset('assets/Dress/shirt.png',
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'assets/Dress/jacket.png',
                              child: Row(
                                children: [
                                  Image.asset('assets/Dress/jacket.png',
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "assets/Dress/flared_frock.png",
                              child: Row(
                                children: [
                                  Image.asset("assets/Dress/flared_frock.png",
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "assets/Dress/frock.png",
                              child: Row(
                                children: [
                                  Image.asset("assets/Dress/frock.png",
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "assets/Dress/wmgown.png",
                              child: Row(
                                children: [
                                  Image.asset("assets/Dress/wmgown.png",
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "assets/Dress/wmtshirt.png",
                              child: Row(
                                children: [
                                  Image.asset("assets/Dress/wmtshirt.png",
                                      width: 30, height: 30),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  /// **Submit Button**
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: BlocConsumer<ServiceBloc, ServiceState>(
                        listener: (context, state) {
                          if (state is CategorySuccess) {
                            Navigator.of(context).pop();
                          }
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            //onPressed: _updateCategory,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                CategoryModel category = CategoryModel(
                                  category_id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  product_name: productNameController.text,
                                  service: selectedServiceType ?? "",
                                  category: selectedCategory ?? "",
                                  product_image: imagePath ?? "",
                                );

                                context.read<ServiceBloc>().add(
                                    EditCategory(category: category));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: state is CategoryLoading
                                ? Loading_Widget()
                                : Text("Update",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
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
