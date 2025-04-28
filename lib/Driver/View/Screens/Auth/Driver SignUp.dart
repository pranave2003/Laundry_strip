//driver signup



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';
import '../../../../Controller/bloc/Driverbloc/Drivermodel/Drivermodel.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import 'Driver_Login.dart';

class Driversignupwrapper extends StatelessWidget {
  const Driversignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverblocBloc(),
      child: const DriverSignupPage(),
    );
  }
}

class DriverSignupPage extends StatefulWidget {
  const DriverSignupPage({super.key});

  @override
  State<DriverSignupPage> createState() => _DriverSignupPageState();
}

class _DriverSignupPageState extends State<DriverSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isChecked = false;
  File? _profileImage;
  File? _licenseProof;

  final picker = ImagePicker();

  Future<void> _pickImage(bool isProfile) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(picked.path);
        } else {
          _licenseProof = File(picked.path);
        }
      });
    }
  }

  void _registerUser() {
    if (_formKey.currentState!.validate() && isChecked) {
      if (_profileImage == null || _licenseProof == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload both image and license")),
        );
        return;
      }

      final driver = Driver(
        name: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        driverId: const Uuid().v4(), // Unique ID
        image: _profileImage!.path,
        proof: _licenseProof!.path,

        timestamp: DateTime.now().toIso8601String(),
      );

      context.read<DriverblocBloc>().add(DriverSignupEvent(driver: driver));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverblocBloc, DriverblocState>(
      listener: (context, state) {
        if (state is DriverAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is DriverAuthenticatedError) {
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
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset("assets/splash_logo.png", width: 150),
                  const SizedBox(height: 20),
                  Text("Laundry Mate",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: defaultColor)),
                  const SizedBox(height: 20),

                  // Username
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Username",
                    controller: _usernameController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Username is required"
                        : value.length < 3
                        ? "Username should be at least 3 characters"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Phone
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: "Mobile Number",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Mobile number is required"
                        : !RegExp(r'^[0-9]{10}$').hasMatch(value)
                        ? "Enter a valid 10-digit mobile number"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Email
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.email),
                    hintText: "Email",
                    controller: _emailController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Email is required"
                        : !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())
                        ? "Enter a valid email"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Password
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Password",
                    controller: _passwordController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Password is required"
                        : value.length < 6
                        ? "Password must be at least 6 characters"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Upload Profile Image
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _profileImage != null
                                  ? "Profile Image Selected"
                                  : "Upload Profile Image",
                              style: TextStyle(
                                color: _profileImage != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Icon(
                            _profileImage != null
                                ? Icons.check_circle
                                : Icons.upload_file,
                            color: _profileImage != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Upload License Proof
                  GestureDetector(
                    onTap: () => _pickImage(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.file_copy, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _licenseProof != null
                                  ? "License Proof Selected"
                                  : "Upload License Proof",
                              style: TextStyle(
                                color: _licenseProof != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Icon(
                            _licenseProof != null
                                ? Icons.check_circle
                                : Icons.upload_file,
                            color: _licenseProof != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Terms checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (val) =>
                            setState(() => isChecked = val ?? false),
                      ),
                      const Text("I agree to the terms & conditions"),
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

                  const SizedBox(height: 20),

                  if (state is DriverAuthloading) const Loading_Widget(),

                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed:
                      state is DriverAuthloading ? null : _registerUser,
                      color: defaultColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Sign Up",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DriverLogin()),
                        ),
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