import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';
import '../../../../Controller/bloc/Driverbloc/Drivermodel/Drivermodel.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Profile/Driver_Terms_page.dart';
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
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _aadharController = TextEditingController();

  bool isChecked = false;
  Uint8List? _profileImage;
  Uint8List? _licenseProof;
  final picker = ImagePicker();

  Future<void> _pickImage(bool isProfile) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final imageBytes = await picked.readAsBytes();
      setState(() {
        if (isProfile) {
          _profileImage = imageBytes;
        } else {
          _licenseProof = imageBytes;
        }
      });
    }
  }

  Future<String> _uploadImageToFirebase(Uint8List imageData, String folderName) async {
    try {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref().child('$folderName/$fileName');
      final uploadTask = storageRef.putData(imageData);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  void _registerUser() async {
    if (!_formKey.currentState!.validate() || !isChecked) {
      if (!isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please agree to the terms and conditions")),
        );
      }
      return;
    }

    if (_profileImage == null || _licenseProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload both profile image and license proof")),
      );
      return;
    }

    final profileImageUrl = await _uploadImageToFirebase(_profileImage!, 'driver_profile');
    final licenseProofUrl = await _uploadImageToFirebase(_licenseProof!, 'driver_license');

    if (profileImageUrl.isEmpty || licenseProofUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload images")),
      );
      return;
    }

    final driver = Driver(
      name: _usernameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      driverId: const Uuid().v4(),
      image: profileImageUrl,
      proof: licenseProofUrl,
      aadhar: _aadharController.text,
      timestamp: DateTime.now().toIso8601String(),
    );

    context.read<DriverblocBloc>().add(DriverSignupEvent(driver: driver));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverblocBloc, DriverblocState>(
      listener: (context, state) {
        if (state is Registerdone) {
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
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: defaultColor)),
                  const SizedBox(height: 20),

                  // Form Fields
                  CustomTextForm(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Username",
                    controller: _usernameController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Username is required"
                        : value.length < 3
                        ? "At least 3 characters"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextForm(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: "Mobile Number",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Mobile number is required"
                        : !RegExp(r'^[0-9]{10}$').hasMatch(value)
                        ? "Enter a valid 10-digit number"
                        : null,
                  ),
                  const SizedBox(height: 15),

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

                  CustomTextForm(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Password",
                    controller: _passwordController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Password is required"
                        : value.length < 6
                        ? "Min. 6 characters"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextForm(
                    prefixIcon: const Icon(Icons.verified_user_outlined),
                    hintText: "Aadhar Number",
                    controller: _aadharController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Aadhar number is required"
                        : !RegExp(r'^[0-9]{12}$').hasMatch(value)
                        ? "Enter valid 12-digit Aadhar number"
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Profile Image Upload
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: _buildFileUploadTile("Upload Profile Image", _profileImage != null),
                  ),
                  if (_profileImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.memory(_profileImage!, height: 100, width: 100),
                    ),

                  // License Proof Upload
                  GestureDetector(
                    onTap: () => _pickImage(false),
                    child: _buildFileUploadTile("Upload License Proof", _licenseProof != null),
                  ),
                  if (_licenseProof != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.memory(_licenseProof!, height: 100, width: 100),
                    ),

                  // Terms and Conditions
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
                      Text("I Agree to the"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DriverTermsPage();
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

                  // const SizedBox(height: 20),
                  //
                  // // Loading Indicator or Sign Up Button
                  // if (state is DriverAuthloading) const Loading_Widget(),

                  SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        if (state is DriverAuthloading) ...[
                          const Text("Logging in..."),
                          const Loading_Widget(),
                        ],
                      ],
                    ),
                  ),

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

                  // Redirect to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const DriverLogin()));
                        },
                        child: const Text("Sign In", style: TextStyle(color: Colors.blue)),
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

  Widget _buildFileUploadTile(String text, bool uploaded) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.upload_file, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              uploaded ? "$text Selected" : text,
              style: TextStyle(color: uploaded ? Colors.black : Colors.grey),
            ),
          ),
          if (uploaded) const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }
}
