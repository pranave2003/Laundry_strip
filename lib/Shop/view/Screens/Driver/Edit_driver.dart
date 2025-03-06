import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Shop/view/Screens/Driver/delivery.dart';

import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class Edit_Driver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Edit Driver",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50), // Added space from the top

          // Profile Picture (At the Top)
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage("assets/driver1.png"), // Update with your image path
          ),
          SizedBox(height: 8),

          // "Change Picture" Button
          TextButton(
            onPressed: () {
              print("Change Picture Clicked"); // Add image picker logic here
            },
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 30), // Added space before form fields

          // Form Fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                CustomTextForm(
                    prefixIcon: Icon(Icons.person), hintText: "Username"),
                SizedBox(height: 10),
                CustomTextForm(
                    prefixIcon: Icon(Icons.phone), hintText: "Mobile Number"),
                SizedBox(height: 10),
                CustomTextForm(
                    prefixIcon: Icon(Icons.email), hintText: "Email"),
                SizedBox(height: 20), // Adjusted space before button

                // Update Button
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeliveryPage()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Update ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
