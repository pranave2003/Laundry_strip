import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Auth/shop_login.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      prefixIcon: Icon(Icons.person), hintText: "Username"),
                  SizedBox(height: 15),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.phone), hintText: "Mobile Number"),
                  SizedBox(height: 15),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.email), hintText: "Email"),
                  SizedBox(height: 15),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.lock), hintText: "Password"),
                  SizedBox(height: 15),
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
                      prefixIcon: Icon(Icons.location_city, color: Colors.blue),
                      filled: true,
                      fillColor: primary,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: Text("Select District"),
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
                  ),
                  SizedBox(height: 15),

                  CustomTextForm(
                      prefixIcon: Icon(Icons.access_time),
                      hintText: "Shop Address"),
                  SizedBox(height: 15),

                  // **Time Slots as Radio Buttons**
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primary),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.fact_check_outlined, color: Colors.blue),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Shop Time Slots",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "12 hours",
                              groupValue: selectedTimeSlot,
                              activeColor: Secondary,
                              onChanged: (value) {
                                setState(() {
                                  selectedTimeSlot = value!;
                                });
                              },
                            ),
                            Text("12 hours"),
                            SizedBox(width: 20),
                            Radio<String>(
                              value: "24 hours",
                              groupValue: selectedTimeSlot,
                              activeColor: Secondary,
                              onChanged: (value) {
                                setState(() {
                                  selectedTimeSlot = value!;
                                });
                              },
                            ),
                            Text("24 hours"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.local_laundry_service_outlined),
                      hintText: "Laundry Capacity in Kg"),
                  SizedBox(height: 15),

                  CustomTextForm(
                      prefixIcon: Icon(Icons.add_home_outlined),
                      hintText: "Shop Address"),
                  SizedBox(height: 15),
                  // CustomTextForm(
                  //     prefixIcon: Icon(Icons.access_time),
                  //     hintText: "Shop Time Slots"),
                  // SizedBox(height: 15),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.local_laundry_service_outlined),
                      hintText: "Laundry Capacity in Kg"),
                  SizedBox(height: 15),

                  // **Updated Select Services Field with Icons**
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDropdownOpen = !isDropdownOpen;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 18),
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
                                        selectedServices.add(service["name"]!);
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
                  SizedBox(height: 30),
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
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLogin()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: defaultColor,
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
                        MaterialPageRoute(builder: (context) => ShopLogin()),
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
  }
}
