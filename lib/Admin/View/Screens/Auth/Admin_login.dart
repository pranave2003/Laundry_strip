import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Widget/constands/widgets.dart';

class Admin_LoginPage extends StatefulWidget {
  @override
  _Admin_LoginPageState createState() => _Admin_LoginPageState();
}

class _Admin_LoginPageState extends State<Admin_LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Image
          Expanded(
            child: Image.asset(
              'assets/am_login.png',
              fit: BoxFit.cover,
            ),
          ),
          // Right Side - Login Form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/splash_logo.png', height: 200),
                        SizedBox(height: 5),
                        Text(
                          'Laundry Mate',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        SizedBox(height: 20),
                        Text('Login as an Admin',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18)),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                  CustomTextForm(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Username",
                  ),
                  SizedBox(height: 20),
                  CustomTextForm(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.blueAccent,
                          value: isChecked,
                          onChanged: (val) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }),
                      Text("Remember Me"),
                      Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color(0xFF8E8E93)),
                          )),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: defaultColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
