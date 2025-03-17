import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import 'user_login.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
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
class _RegisterPageState extends State<RegisterPage> {
  String? selectedDistrict;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash_logo.png",
              width: 150,
            ),
            Text(
              "Laundry Mate",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                   color: defaultColor,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  CustomTextForm(
                      prefixIcon: Icon(Icons.person), hintText: "Username"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.phone), hintText: "Mobile Number"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.email), hintText: "Email"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                      prefixIcon: Icon(Icons.lock), hintText: "Password"),
                  SizedBox(
                    height: 15,
                  ),
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
                      hintText: "Address"),
                  SizedBox(
                    height: 10,
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
                  SizedBox(height: 30,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserLogin()), // Replace with your destination page
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
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20,),
                      Expanded(child: Divider(thickness: 1,color: Colors.black,)),
                      SizedBox(width: 10,),
                      Text("OR"),
                      SizedBox(width: 10,),
                      Expanded(child: Divider(thickness: 1,color: Colors.black,)),
                      SizedBox(width: 20,),
                    ],
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserLogin()), // Replace with your destination page
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
          ],
        ),
      ),
    );
  }
}
