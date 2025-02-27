import 'package:flutter/material.dart';

class EditAddressPage extends StatefulWidget {
  final String initialAddress;
  final String initialTag;

  EditAddressPage({required this.initialAddress, required this.initialTag});

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
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
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() {
    List<String> parts = widget.initialAddress.split(", ");

    if (parts.length >= 6) {
      houseController.text = parts[0];
      placeController.text = parts[1];
      postController.text = parts[2];
      pincodeController.text = parts[3];
      districtController.text = parts[4];
      stateController.text = parts[5];
    }
    selectedTag = widget.initialTag;
  }

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
          "Edit Address",
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
                "Update Address Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),

              _buildTextField(houseController, "House no / Flat no / Floor / Street"),
              _buildTextField(placeController, "Place"),
              _buildTextField(postController, "Post"),
              _buildTextField(pincodeController, "Pincode", isNumber: true),
              _buildTextField(districtController, "District"),
              _buildTextField(stateController, "State"),
              _buildTextField(landmarkController, "Landmark (Optional)"),
              _buildTextField(directionsController, "How to reach (Optional)"),

              SizedBox(height: 20),

              // Location Tag Label
              Text(
                "Tag this location",
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

              // Save Address Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String updatedAddress =
                        "${houseController.text}, ${placeController.text}, ${postController.text}, ${pincodeController.text}, ${districtController.text}, ${stateController.text}, Landmark: ${landmarkController.text}, Directions: ${directionsController.text} ($selectedTag)";

                    Navigator.pop(context, updatedAddress);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Save Address",
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
