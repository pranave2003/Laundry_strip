import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/User/view/Screens/auth/user_login.dart';

import '../../../../Controller/bloc/Authbloc/Userauthmodel/Usermodel.dart';
import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Profile/TermsPage.dart';

class Usersignupwrapper extends StatelessWidget {
  const Usersignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: RegisterPage(),
    );
  }
}

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
  final _formKey = GlobalKey<FormState>();

  String? selectedDistrict;
  bool isChecked = false;

  void _registerUser() {
    if (_formKey.currentState!.validate() && isChecked) {
      UserModel user = UserModel(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        District: selectedDistrict,
        place: _placeController.text,
        post: _postController.text,
        pin: _pinController.text,
        state: _stateController.text,
      );
      // Trigger the sign-up event
      context.read<AuthBloc>().add(SignupEvent(user: user));
    }
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController stateController = TextEditingController(text: "Kerala");


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is AuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey, //  Attach FormKey here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    "assets/splash_logo.png",
                    width: 150,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Laundry Mate",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // USERNAME FIELD
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

                  // PHONE NUMBER FIELD
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

                  // EMAIL FIELD
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

                  // PASSWORD FIELD
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

                  // DISTRICT DROPDOWN


                  // ADDRESS FIELD
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.business),
                    hintText: "Place",
                    controller: _placeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Place is required";
                      }
                      if (value.length < 5) {
                        return "Place must be at least 5 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomTextForm(
                    prefixIcon: const Icon(Icons.location_on),
                    hintText: "Post",
                    controller: _postController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return " Post is required";
                      }
                      if (value.length < 5) {
                        return "Post must be at least 5 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  CustomTextForm(
                    prefixIcon: const Icon(Icons.local_post_office),
                    hintText: "Pincode",
                    controller: _pinController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Pincode is required";
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return "Enter a valid 6-digit pincode";
                      }
                      return null;
                    },


                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      prefixIcon:
                      const Icon(Icons.location_city, color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
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
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.maps_home_work_outlined),
                    hintText: "State",
                    controller: _stateController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "State is required";
                      }
                      if (value.length < 5) {
                        return "State must be at least 5 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // TERMS & CONDITIONS CHECKBOX
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Secondary,
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                      const Text("I Agree to the "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return TermsAndConditionsPage();
                              },
                            ));
                          },
                          child: Text("Terms and Conditions "))
                    ],
                  ),
                  if (!isChecked)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "You must agree to the terms and conditions",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        if (state is Authloading) ...[
                          const Loading_Widget(),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SIGN-UP BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: _registerUser,
                      color: state is Authloading
                          ? defaultLightColor
                          : defaultColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SIGN-IN LINK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLogin()),
                          );
                        },
                        child: const Text("Sign In",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
