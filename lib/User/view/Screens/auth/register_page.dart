import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  CustomTextForm(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Confirm Password"),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      onPressed: () {},
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
                          onPressed: () {},
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
