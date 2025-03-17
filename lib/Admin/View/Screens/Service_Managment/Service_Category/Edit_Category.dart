import 'package:flutter/material.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({super.key});

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  TextEditingController productNameController = TextEditingController();
  String? imagePath;

  // Dropdown values
  String? selectedServiceType;
  String? selectedCategory;

  List<String> serviceTypes = ["Wash +\nFold",
    "Wash +\nIron",
    "Steam\nIron",
    "Dry\nClean",
    "Bag\nServices",
    "Shoe Service",
    "Household Services",
    "Stain Removal"];
  List<String> categories = ["Men", "Women", "Kids","Household"];

  @override
  Widget build(BuildContext context) {
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
                  "Edit Category",
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
          SizedBox(height: 40,),
          /// **Add Service Form**
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
                /// **Service Type Dropdown**
                Row(
                  children: [
                    SizedBox(width: 120, child: Text("Service Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedServiceType,
                        items: serviceTypes.map((String type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedServiceType = newValue;
                          });
                        },
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Select Service"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                /// **Category Dropdown**
                Row(
                  children: [
                    SizedBox(width: 120, child: Text("Category", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem(value: category, child: Text(category));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Select Category"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                /// **Product Name Field**
                Row(
                  children: [
                    SizedBox(width: 120, child: Text("Product Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: productNameController,
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Enter Product Name"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                /// **Product Image Upload Field**
                // Row(
                //   children: [
                //     SizedBox(width: 120, child: Text("Product Image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                //     SizedBox(width: 10),
                //     Expanded(
                //       child: TextField(
                //         readOnly: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           hintText: imagePath ?? "Product Image",
                //           prefixIcon: Icon(Icons.image, color: Colors.grey),
                //           suffixIcon: TextButton(
                //             onPressed: () {
                //               // TODO: Implement file picker
                //             },
                //             style: TextButton.styleFrom(backgroundColor: Colors.grey.shade300, padding: EdgeInsets.symmetric(horizontal: 20)),
                //             child: Text("Browse", style: TextStyle(color: Colors.black)),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text("Product Image",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Product Image',
                        ),
                        value: imagePath, // The current selected value (you'll need to define `imagePath` somewhere)
                        onChanged: (String? newValue) {
                          // Handle the image change here
                          setState(() {
                            imagePath = newValue;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'assets/Dress/t-shirt.png',
                            child: Row(
                              children: [
                                Image.asset('assets/Dress/t-shirt.png', width: 30, height: 30),
                                SizedBox(width: 20),
                                //Text('T-Shirt'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'assets/Dress/shirt.png',
                            child: Row(
                              children: [
                                Image.asset('assets/Dress/shirt.png', width: 30, height: 30),
                                SizedBox(width: 20),
                                //Text('Shirt'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'assets/Dress/jacket.png',
                            child: Row(
                              children: [
                                Image.asset('assets/Dress/jacket.png', width: 30, height: 30),
                                SizedBox(width: 20),
                                //Text('Jacket'),
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
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement submit logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Update", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
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