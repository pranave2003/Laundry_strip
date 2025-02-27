import 'package:flutter/material.dart';
import 'colors.dart';
import 'dart:ui';

class CustomTextForm extends StatelessWidget {
  String hintText;
  Widget prefixIcon;
  TextEditingController? controller;

  CustomTextForm({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIconColor: formIconColor,
          prefixIcon: prefixIcon,
          fillColor: formColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

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

