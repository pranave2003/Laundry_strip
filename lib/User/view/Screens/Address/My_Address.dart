import 'package:flutter/material.dart';
import 'package:laundry/Controller/bloc/Authbloc/Userauthmodel/Usermodel.dart';
import 'Add_address.dart';
import 'Edit_address.dart';

class AddressesPage extends StatefulWidget {
  final UserModel user; // Store user model

  AddressesPage(this.user);

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  int selectedIndex = 0; // Track selected radio button



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          widget.user.name.toString(), // Display user's name
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Saved Addresses", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),



            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Add New Address", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
