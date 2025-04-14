import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/bloc/ServiceManagement/Service_Model/Category_Model.dart';
import '../../../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../../../Widget/constands/Loading.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  List<String> categoriesBag = ["Small", "Medium", "Large"];
  List<String> categoriesShoes = ["Sneakers", "Leather", "Boots"];

  List<String> defaultImages = [
    "assets/Dress/t-shirt.png",
    "assets/Dress/shirt.png",
    "assets/Dress/jacket.png",
    "assets/Dress/mensuit.png",
    "assets/Dress/flared_frock.png",
    "assets/Dress/frock.png",
    "assets/Dress/wmgown.png",
    "assets/Dress/wmtshirt.png",
    "assets/Dress/saree.png",
    "assets/Dress/curtain.png",
    "assets/Dress/carpet.png",
    "assets/Dress/sofacover.png",
    "assets/Household/yogamat.png",
  ];

  List<String> bagImages = [
    "assets/Bag/laptopbag.png",
    "assets/Bag/Schoolbag.png",
    "assets/Bag/travelbag.png",
    "assets/Bag/clgbag.png",
    "assets/Bag/purse.png",
    "assets/Bag/Schoolbag.png",
    "assets/Bag/troley.png",

  ];

  List<String> shoeImages = [
    "assets/Dress/sneaker.jpg",
    "assets/Shoes/flatheel.png",
    "assets/Shoes/football_boot.png",
    "assets/Shoes/rollerscater.png",
    "assets/Dress/sh.jpg",
    "assets/Dress/pointed_heel.jpg",
    "assets/Dress/boot_heels.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = selectedServiceType == "Bag Service"
        ? categoriesBag
        : selectedServiceType == "Shoe Service"
            ? categoriesShoes
            : categories;

    List<String> imageList = selectedServiceType == "Bag Service"
        ? bagImages
        : selectedServiceType == "Shoe Service"
            ? shoeImages
            : defaultImages;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Category",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 18),
                    Container(height: 40, width: 400),
                  ],
                ),
              ),
              SizedBox(height: 40),
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
                    // Service Type Dropdown
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text("Service Type",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
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
                                selectedCategory = null;
                                imagePath = null;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Select a service type' : null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Select Service"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Category Dropdown
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text("Category",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCategory,
                            items: categoryList.map((String category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Select a category' : null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Select Category"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Product Name Text Field
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text("Product Name",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: productNameController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter product name'
                                : null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Product Name"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Product Image Dropdown
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text("Product Image",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
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
                                value == null ? 'Select a product image' : null,
                            items: imageList.map((String imgPath) {
                              return DropdownMenuItem(
                                value: imgPath,
                                child: Row(
                                  children: [
                                    Image.asset(imgPath, width: 30, height: 30),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    // Submit Button
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 40,
                        child: BlocConsumer<ServiceBloc, ServiceState>(
                          listener: (context, state) {
                            if (state is CategorySuccess) {
                              Navigator.of(context).pop();
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
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
                                      CategoryAddEvent(category: category));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: state is CategoryLoading
                                  ? Loading_Widget()
                                  : Text("Submit",
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
      ),
    );
  }
}
