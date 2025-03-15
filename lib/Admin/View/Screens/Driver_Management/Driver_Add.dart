import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Driverbloc/Drivermodel/Drivermodel.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_state.dart';

class DriverAdd extends StatefulWidget {
  const DriverAdd({super.key});

  @override
  State<DriverAdd> createState() => _DriverAddState();
}

class _DriverAddState extends State<DriverAdd> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController driverNameCtrl = TextEditingController();
  TextEditingController driverNumberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  String? imagePath;

  final driverBloc = DriverblocBloc();

  Future<void> addDriver() async {
    if (_formKey.currentState!.validate()) {
      final driver = Driver(
        timestamp: DateTime.now().toString(),
        name: driverNameCtrl.text.trim(),
        phone: driverNumberCtrl.text.trim(),
        driverId: '',
        email: emailCtrl.text.trim(),
        image: imagePath ?? 'https://example.com/image.png',
        isActive: true,
      );

      driverBloc.add(AddDriverEvent(driver));

      // Clear fields after submission
      driverNameCtrl.clear();
      driverNumberCtrl.clear();
      emailCtrl.clear();
      setState(() {
        imagePath = null;
      });

      context
          .read<DriverblocBloc>()
          .add(FetchDrivers(status: true, searchQuery: null));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey, // Wrap with Form
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Driver",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Driver Image Field**
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          "Driver Image",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: imagePath ?? "Driver Image",
                            prefixIcon:
                                const Icon(Icons.image, color: Colors.grey),
                            suffixIcon: TextButton(
                              onPressed: () {
                                // TODO: Implement file picker
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: const Text(
                                "Browse",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// **Driver Name Field**
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          "Driver Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: driverNameCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Driver Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter driver name';
                            }
                            if (value.length < 3) {
                              return 'Name must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// **Phone Number Field**
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: driverNumberCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Phone Number",
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Please enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// **Email Field**
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Email Id",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  /// **Submit Button**
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => addDriver(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
