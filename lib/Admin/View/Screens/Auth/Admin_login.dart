import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Widget/constands/colors.dart';

import '../../../../Widget/constands/widgets.dart';
import '../../MainScreen/Admin_main.dart';

class Admin_LoginPage extends StatefulWidget {
  @override
  _Admin_LoginPageState createState() => _Admin_LoginPageState();
}

class _Admin_LoginPageState extends State<Admin_LoginPage> {
  //bool isChecked = false;
  String email = 'admin@gmail.com';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    emailController.text = email;
    super.initState();
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      try {
        // Attempt to sign in with email and password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful")),
        );

        // Navigate to AdminPage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
              (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'Invalid email address.';
            break;
          default:
            errorMessage = 'Login failed. ${e.message}';
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),);
      }
    }
  }


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
              child: Form(
                key: formKey,
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
                      controller: emailController,
                      readOnly: true,
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!value.contains('@') || !value.contains('.')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextForm(
                      isObscure: true, // This makes the text show as dots
                      controller: passwordController,
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),


                    Row(
                      children: [
                        // Checkbox(
                        //     activeColor: Colors.blueAccent,
                        //     value: isChecked,
                        //     onChanged: (val) {
                        //       setState(() {
                        //         isChecked = !isChecked;
                        //       });
                        //     }),
                        // Text("Remember Me"),
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
                        onPressed: _login,
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
          ),
        ],
      ),
    );
  }
}
