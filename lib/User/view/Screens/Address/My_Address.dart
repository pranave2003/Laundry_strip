import 'package:flutter/material.dart';
import 'package:laundry/Controller/bloc/Authbloc/Userauthmodel/Usermodel.dart';
import 'Add_address.dart';
import 'Edit_address.dart';

class AddressesPage extends StatefulWidget {
  final UserModel user;

  AddressesPage(this.user);

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  int selectedIndex = 0; // Track selected radio button

  void addNewAddress(String newAddress, String tag) {
    setState(() {
      // No changes here since user model address is displayed directly
    });
  }

  void updateAddress(int index, String updatedAddress, String updatedTag) {
    setState(() {
      // No changes here since user model address is displayed directly
    });
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
          "My Address",
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
            Text("Saved Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0, // Since there's only one user address
                            groupValue: selectedIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedIndex = value as int;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          "${widget.user.place.toString()}, ${widget.user.post.toString()}, ${widget.user.pin.toString()}, ${widget.user.District.toString()}",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAddressPage(
                                    initialAddress:
                                        "${widget.user.place.toString()}, ${widget.user.post.toString()}, ${widget.user.pin.toString()}, ${widget.user.District.toString()}",
                                    initialTag: "Home",
                                  ),
                                ),
                              );

                              if (result != null) {
                                updateAddress(
                                    0, result["address"], result["tag"]);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.green),
                            ),
                            child: Text("Edit",
                                style: TextStyle(color: Colors.green)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 400,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAddressPage()),
                  );

                  if (result != null) {
                    addNewAddress(result["address"], result["tag"]);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Add New Address",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
