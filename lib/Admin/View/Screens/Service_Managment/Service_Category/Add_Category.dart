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

  // Image lists without product names
  List<String> defaultImages = [
    "assets/Dress/t-shirt.png",
    "assets/Dress/shirt.png",
    "assets/Dress/jacket.png",
  ];

  List<String> bagImages = [
    "assets/Dress/carpet.png",
    "assets/Dress/carpet.png",
    "assets/Dress/carpet.png",
  ];

  List<String> shoeImages = [
    "assets/Dress/sneaker.jpg",
    "assets/Dress/sh.jpg",
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
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Category",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                            selectedCategory = null;
                            imagePath = null;
                          });
                        },
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
                                fontSize: 16, fontWeight: FontWeight.bold))),
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Select Category"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Product Name Text Field (Kept)
                Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text("Product Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: productNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Product Name"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Product Image Dropdown (Without Names)
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
                        if (state is CategorySuccess) {}
                        Navigator.of(context).pop();
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            CategoryModel category = CategoryModel(
                                category_id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate unique ID
                                product_name: productNameController.text,
                                service: selectedServiceType ??"",
                                category: selectedCategory ??"",
                                product_image: imagePath ??"") ;

                                // material_name: serviceNameController.text,
                                // material_type: selectCategory);
                            // Trigger the sign-up event
                            context
                                .read<ServiceBloc>()
                                .add(CategoryAddEvent(category: category));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),

                            child: state is Loading
                            ? Loading_Widget()
                        :Text("Submit",
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
    );
  }
}


// import 'package:flutter/material.dart';
//
// class CategoryAdd extends StatefulWidget {
//   const CategoryAdd({super.key});
//
//   @override
//   State<CategoryAdd> createState() => _CategoryAddState();
// }
//
// class _CategoryAddState extends State<CategoryAdd> {
//   TextEditingController productNameController = TextEditingController();
//   String? imagePath;
//
//   // Dropdown values
//   String? selectedServiceType;
//   String? selectedCategory;
//
//   List<String> serviceTypes = [
//     "Wash + Fold",
//     "Wash + Iron",
//     "Steam Iron",
//     "Dry Clean",
//     "Bag Service",
//     "Shoe Service",
//     "Household Service",
//     "Stain Removal"
//   ];
//   List<String> categories = ["Men", "Women", "Kids", "Household"];
//   List<String> categoriesbag = ["Small", "Medium", "Large"];
//   List<String> categoriesshoes = ["Sneakers", "Leather", "Boots"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//
//           SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.only(left: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Add Category",
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   width: 18,
//                 ),
//                 Container(
//                   height: 40,
//                   width: 400,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//
//           /// **Add Service Form**
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// **Service Type Dropdown**
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Service Type",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedServiceType,
//                         items: serviceTypes.map((String type) {
//                           return DropdownMenuItem(
//                               value: type, child: Text(type));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedServiceType = newValue;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Service"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//
//                 /// **Category Dropdown**
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Category",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedCategory,
//                         items: categories.map((String category) {
//                           return DropdownMenuItem(
//                               value: category, child: Text(category));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedCategory = newValue;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Category"),
//                       ),
//                     ),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedCategory,
//                         items: categoriesbag.map((String category) {
//                           return DropdownMenuItem(
//                               value: category, child: Text(category));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedCategory = newValue;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Category"),
//                       ),
//                     ),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedCategory,
//                         items: categoriesshoes.map((String category) {
//                           return DropdownMenuItem(
//                               value: category, child: Text(category));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedCategory = newValue;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Category"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//
//                 /// **Product Name Field**
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Product Name",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         controller: productNameController,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Enter Product Name"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Product Image",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Select Product Image',
//                         ),
//                         value:
//                             imagePath, // The current selected value (you'll need to define `imagePath` somewhere)
//                         onChanged: (String? newValue) {
//                           // Handle the image change here
//                           setState(() {
//                             imagePath = newValue;
//                           });
//                         },
//                         items: [
//                           DropdownMenuItem(
//                             value: 'assets/Dress/t-shirt.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/t-shirt.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                                 //Text('T-Shirt'),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'assets/Dress/shirt.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/shirt.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                                 //Text('Shirt'),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'assets/Dress/jacket.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/jacket.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                                 //Text('Jacket'),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 40),
//
//                 /// **Submit Button**
//                 Center(
//                   child: SizedBox(
//                     width: 120,
//                     height: 40,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // TODO: Implement submit logic
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: Text("Submit",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//////////////////////////////////

//
// import 'package:flutter/material.dart';
//
// class CategoryAdd extends StatefulWidget {
//   const CategoryAdd({super.key});
//
//   @override
//   State<CategoryAdd> createState() => _CategoryAddState();
// }
//
// class _CategoryAddState extends State<CategoryAdd> {
//   TextEditingController productNameController = TextEditingController();
//   String? imagePath;
//   String? selectedServiceType;
//   String? selectedCategory;
//
//   List<String> serviceTypes = [
//     "Wash + Fold",
//     "Wash + Iron",
//     "Steam Iron",
//     "Dry Clean",
//     "Bag Service",
//     "Shoe Service",
//     "Household Service",
//     "Stain Removal"
//   ];
//   List<String> categories = ["Men", "Women", "Kids", "Household"];
//   List<String> categoriesbag = ["Small", "Medium", "Large"];
//   List<String> categoriesshoes = ["Sneakers", "Leather", "Boots"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.only(left: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Add Category",
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 18),
//                 Container(height: 40, width: 400),
//               ],
//             ),
//           ),
//           SizedBox(height: 40),
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Service Type",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedServiceType,
//                         items: serviceTypes.map((String type) {
//                           return DropdownMenuItem(
//                               value: type, child: Text(type));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedServiceType = newValue;
//                             selectedCategory = null;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Service"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Category",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         value: selectedCategory,
//                         items: (selectedServiceType == "Bag Service"
//                                 ? categoriesbag
//                                 : selectedServiceType == "Shoe Service"
//                                     ? categoriesshoes
//                                     : categories)
//                             .map((String category) {
//                           return DropdownMenuItem(
//                               value: category, child: Text(category));
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedCategory = newValue;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Select Category"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Product Name",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         controller: productNameController,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Enter Product Name"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     SizedBox(
//                         width: 120,
//                         child: Text("Product Image",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Select Product Image',
//                         ),
//                         value: imagePath,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             imagePath = newValue;
//                           });
//                         },
//                         items: [
//                           DropdownMenuItem(
//                             value: 'assets/Dress/t-shirt.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/t-shirt.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'assets/Dress/shirt.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/shirt.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'assets/Dress/jacket.png',
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/Dress/jacket.png',
//                                     width: 30, height: 30),
//                                 SizedBox(width: 20),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40),
//                 Center(
//                   child: SizedBox(
//                     width: 120,
//                     height: 40,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: Text("Submit",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

