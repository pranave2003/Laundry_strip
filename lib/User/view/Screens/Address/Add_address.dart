import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController houseController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController directionsController = TextEditingController();

  String selectedTag = "Home"; // Default selection

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
          "Add Address",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Address Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),

              _buildTextField(houseController, "House no / Flat no / Floor / Street"),
              _buildTextField(placeController, "Place"),
              _buildTextField(postController, "Post"),

              // Pincode Field (Limited to 6 digits)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6, // Limit input to 6 characters
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allow numbers
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: UnderlineInputBorder(),
                    counterText: "", // Hide character counter
                  ),
                ),
              ),

              _buildTextField(districtController, "District"),
              _buildTextField(stateController, "State"),
              _buildTextField(landmarkController, "Landmark (Optional)"),
              _buildTextField(directionsController, "How to reach (Optional)"),

              SizedBox(height: 20),

              // Location Tag Label
              Text(
                "Tag this location for later",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 10),

              // Radio Buttons for Home, Office, Other
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTagButton("Home"),
                  SizedBox(width: 10),
                  _buildTagButton("Office"),
                  SizedBox(width: 10),
                  _buildTagButton("Other"),
                ],
              ),

              SizedBox(height: 30),

              // Add Address Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (houseController.text.isNotEmpty &&
                        placeController.text.isNotEmpty &&
                        postController.text.isNotEmpty &&
                        pincodeController.text.isNotEmpty &&
                        districtController.text.isNotEmpty &&
                        stateController.text.isNotEmpty) {
                      // Combine all address details into one string
                      String fullAddress =
                          "${houseController.text}, ${placeController.text}, ${postController.text}, ${pincodeController.text}, ${districtController.text}, ${stateController.text}, Landmark: ${landmarkController.text}, Directions: ${directionsController.text} ($selectedTag)";

                      // Return the new address to AddressesPage
                      Navigator.pop(context, fullAddress);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Address",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Text Input Fields
  Widget _buildTextField(TextEditingController controller, String hintText, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  // Widget for Tag Selection
  Widget _buildTagButton(String tag) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTag = tag;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: selectedTag == tag ? Colors.black : Colors.white,
        ),
        child: Text(
          tag,
          style: TextStyle(
            color: selectedTag == tag ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
