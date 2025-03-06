import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Bottom_Navigation/Shop_nav.dart';
import '../Home/Shop_home.dart';
import 'Shop_SignUp.dart';

class ShopLogin extends StatefulWidget {
  const ShopLogin({super.key});

  @override
  State<ShopLogin> createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash_logo.png',
                width: 150,
              ),
              Text(
                'Laundry Mate',
                style: TextStyle(
                    color: defaultColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    CustomTextForm(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextForm(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Shop_Navigation()), // Replace with your destination page
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        color: defaultColor,
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
                                // if(isChecked == false){
                                //   isChecked = true;
                                // }else{
                                //   isChecked = false;
                                // }
                              });
                            }),
                        SizedBox(height: 8),
                        Text("Remember Me "),
                        SizedBox(
                          width: 70,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Color(0xFF8E8E93)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New to Laundry Mate?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Shop_Signup()), // Replace with your destination page
                              );
                            },
                            child: Text("Sign Up")),
                      ],
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
