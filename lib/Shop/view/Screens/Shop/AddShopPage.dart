import 'package:flutter/material.dart';

void main() {
  runApp(LaundryApp());
}

class LaundryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaundryScreen(),
    );
  }
}

class LaundryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shops"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddLaundryShopsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("List of Shops will be displayed here."),
      ),
    );
  }
}

class AddLaundryShopsScreen extends StatefulWidget {
  @override
  _AddLaundryShopsScreenState createState() => _AddLaundryShopsScreenState();
}

class _AddLaundryShopsScreenState extends State<AddLaundryShopsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void _saveShop() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Shop Added Successfully")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Laundry Shop")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Load Image from Assets
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/shop_placeholder.png",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              // Form Fields
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Shop Name"),
                validator: (value) => value!.isEmpty ? "Enter Shop Name" : null,
              ),
              TextFormField(
                controller: ownerController,
                decoration: InputDecoration(labelText: "Owner Name"),
                validator: (value) => value!.isEmpty ? "Enter Owner Name" : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) => value!.isEmpty ? "Enter Address" : null,
              ),
              SizedBox(height: 20),

              // Add Button
              ElevatedButton(
                onPressed: _saveShop,
                child: Text("Add Shop"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
