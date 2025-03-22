import 'package:flutter/material.dart';
import 'colors.dart';
import 'dart:ui';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType; // ✅ Added keyboardType

  const CustomTextForm({
    super.key,
    required this.hintText,
    this.controller,
    this.isObscure = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType, // ✅ Added keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType, // ✅ Applied keyboardType
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
// Custom Dropdown Widget (New)



class WashFold extends StatelessWidget {
  String icon;
  String title;
  WashFold({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(icon),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Service Item List with "Add" Button
