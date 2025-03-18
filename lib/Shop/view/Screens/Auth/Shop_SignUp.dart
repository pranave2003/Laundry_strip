import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Shop/view/Screens/Auth/shop_login.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class Shopsignupwrapper extends StatelessWidget {
  const Shopsignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthblocBloc(),
      child: Shop_Signup(),
    );
  }
}

class Shop_Signup extends StatefulWidget {
  const Shop_Signup({super.key});

  @override
  State<Shop_Signup> createState() => _Shop_SignupState();
}

final List<String> districts = [
  "Kazharkode",
  "Kannur",
  "Wayanad",
  "Kozhikode",
  "Malappuram",
  "Palakkad",
  "Thrissur",
  "Eranamkulam",
  "Idukki",
  "Kottayam",
  "Kollam",
  "Pathanamthitta",
  "Thiruvananthapuram",
];

class _Shop_SignupState extends State<Shop_Signup> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isDropdownOpen = false;
  String selectedTimeSlot = "12 hours";
  String? selectedDistrict;

  final List<Map<String, String>> services = [
    {"icon": "assets/icon/wash_fold.png", "name": "Wash + Fold"},
    {"icon": "assets/icon/wash_iron.png", "name": "Wash + Iron"},
    {"icon": "assets/icon/steam_iron.png", "name": "Steam Iron"},
    {"icon": "assets/icon/dry_clean.png", "name": "Dry Clean"},
    {"icon": "assets/icon/bag_service.png", "name": "Bag Service"},
    {"icon": "assets/icon/shoe_service.png", "name": "Shoe Service"},
    {"icon": "assets/icon/stain_removal.png", "name": "Stain Removal"},
    {"icon": "assets/icon/household_service.png", "name": "Household Service"},
  ];

  List<String> selectedServices = [];
  void _registerShop() {
    if (_formKey.currentState!.validate() && isChecked) {
      ShopModel user = ShopModel(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        District: selectedDistrict,
        shopAddress: _shopAddressController.text,
        LaundryCapacity: _laundryCapacityController.text,
      );
      // Trigger the sign-up event
      context.read<ShopAuthblocBloc>().add(ShopSignupEvent(shop: user));
    }
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();
  final TextEditingController _laundryCapacityController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
      listener: (context, state) {
        if (state is ShopAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is ShopAuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey, // Attach FormKey here
            child: ListView(
              children: [
                SizedBox(height: 25),
                Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/splash_logo.png", width: 150),
                ),
                Center(
                  child: Text(
                    "Laundry Mate",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      CustomTextForm(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Username",
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Username is required";
                          }
                          if (value.length < 3) {
                            return "Username should be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextForm(
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Mobile Number",
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Mobile number is required";
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return "Enter a valid 10-digit mobile number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextForm(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextForm(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password",
                        controller: _passwordController,
                        // obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // CustomTextForm(
                      //     prefixIcon: Icon(Icons.lock),
                      //     hintText: "Confirm Password"),
                      //SizedBox(height: 15),
                      // CustomTextForm(
                      //     prefixIcon: Icon(Icons.how_to_reg), hintText: "ID Proof"),
                      // SizedBox(height: 15),
                      // **District Dropdown Below Password**
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_city,
                              color: Colors.blue),
                          filled: true,
                          fillColor: primary,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        hint: const Text("Select District"),
                        value: selectedDistrict,
                        items: districts.map((district) {
                          return DropdownMenuItem(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDistrict = newValue;
                          });
                        },
                        validator: (value) =>
                            value == null ? "Please select a district" : null,
                      ),
                      const SizedBox(height: 15),

                      // CustomTextForm(
                      //     prefixIcon: Icon(Icons.access_time),
                      //     hintText: "Shop Address"),
                      // SizedBox(height: 15),

                      // **Time Slots as Radio Buttons**
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      //   decoration: BoxDecoration(
                      //     color: primary,
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(color: primary),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Icon(Icons.fact_check_outlined, color: Colors.blue),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           Text(
                      //             "Shop Time Slots",
                      //             style: TextStyle(fontSize: 15),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Radio<String>(
                      //             value: "12 hours",
                      //             groupValue: selectedTimeSlot,
                      //             activeColor: Secondary,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedTimeSlot = value!;
                      //               });
                      //             },
                      //           ),
                      //           Text("12 hours"),
                      //           SizedBox(width: 20),
                      //           Radio<String>(
                      //             value: "24 hours",
                      //             groupValue: selectedTimeSlot,
                      //             activeColor: Secondary,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 selectedTimeSlot = value!;
                      //               });
                      //             },
                      //           ),
                      //           Text("24 hours"),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 15),

                      CustomTextForm(
                        prefixIcon: const Icon(Icons.home),
                        hintText: "Shop Address",
                        controller: _shopAddressController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return " Shop Address is required";
                          }
                          if (value.length < 5) {
                            return " Shop Address must be at least 5 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      CustomTextForm(
                        prefixIcon:
                            const Icon(Icons.local_laundry_service_outlined),
                        hintText: "Laundry Capacity in Kg",
                        controller: _laundryCapacityController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Laundry Capacity is required";
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return "Enter a valid positive number";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15),
                      // CustomTextForm(
                      //     prefixIcon: Icon(Icons.access_time),
                      //     hintText: "Shop Time Slots"),
                      // SizedBox(height: 15),

                      // **Updated Select Services Field with Icons**
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDropdownOpen = !isDropdownOpen;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 18),
                          decoration: BoxDecoration(
                            color: primary,
                            border: Border.all(color: primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.fact_check_outlined,
                                      color: Colors.blue),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      selectedServices.isEmpty
                                          ? "Select Services"
                                          : selectedServices.join(", "),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                              if (isDropdownOpen)
                                Column(
                                  children: services.map((service) {
                                    return CheckboxListTile(
                                      title: Row(
                                        children: [
                                          Image.asset(service["icon"]!,
                                              height: 24, width: 24),
                                          SizedBox(width: 10),
                                          Text(service["name"]!),
                                        ],
                                      ),
                                      value: selectedServices
                                          .contains(service["name"]),
                                      onChanged: (bool? selected) {
                                        setState(() {
                                          if (selected == true) {
                                            selectedServices
                                                .add(service["name"]!);
                                          } else {
                                            selectedServices
                                                .remove(service["name"]!);
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      CustomTextForm(
                          prefixIcon: Icon(Icons.image_rounded),
                          hintText: "Upload Shop Image"),
                      SizedBox(height: 15),
                      CustomTextForm(
                          prefixIcon: Icon(Icons.how_to_reg),
                          hintText: "Shop Registration Proof"),
                      // SizedBox(height: 15),
                      // CustomTextForm(
                      //     prefixIcon: Icon(Icons.food_bank_outlined),
                      //     hintText: "Bank Details (Optional)"),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Secondary,
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        }),
                    SizedBox(height: 8),
                    Text("I Agree to the Terms and Conditions ")
                  ],
                ),
                if (state is ShopAuthloading) ...[
                  const Text("Logging in..."),
                  const Loading_Widget(),
                ],
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: _registerShop,
                    color: state is ShopAuthloading
                        ? defaultLightColor
                        : defaultColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Divider(thickness: 1, color: Colors.black)),
                    SizedBox(width: 10),
                    Text("OR"),
                    SizedBox(width: 10),
                    Expanded(child: Divider(thickness: 1, color: Colors.black)),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopLogin()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xFF479CC9)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
