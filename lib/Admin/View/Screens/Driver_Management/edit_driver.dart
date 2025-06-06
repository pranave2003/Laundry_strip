import 'package:flutter/material.dart';

class DriverEdit extends StatefulWidget {
  const DriverEdit({super.key});

  @override
  State<DriverEdit> createState() => _DriverEditState();
}

class _DriverEditState extends State<DriverEdit> {
  TextEditingController serviceNameController = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Driver",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 18,
                ),
                Container(
                  height: 40,
                  width: 400,
                  //decoration:
                  //BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  // child: TextField(
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     enabledBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(width: .5),
                  //       borderRadius: BorderRadius.circular(18),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18),
                  //       borderSide:
                  //       BorderSide(color: Theme.of(context).primaryColor),
                  //     ),
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       vertical: 5,
                  //     ),
                  //     hintText: 'Search Services',
                  //     prefixIcon: const Icon(
                  //       Icons.search,
                  //       color: Colors.grey,
                  //       size: 21,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 40,),
                /// **Service Image Field (Text & Input in Same Line)**
                Row(
                  children: [
                    /// **Label**
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Driver Image",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),

                    /// **Image Upload Field (With Icon & Browse Button Inside)**
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: imagePath ?? "Driver Image",
                          prefixIcon: Icon(Icons.image, color: Colors.grey), // Image Icon
                          suffixIcon: TextButton(
                            onPressed: () {
                              // TODO: Implement file picker
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            child: Text(
                              "Browse",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                /// **Service Name Field (Text & Input in Same Line)**
                Row(
                  children: [
                    /// **Label**
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Driver Name",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),

                    /// **Input Field**
                    Expanded(
                      child: TextField(
                        controller: serviceNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Driver Name",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    /// **Label**
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),

                    /// **Input Field**
                    Expanded(
                      child: TextField(
                        controller: serviceNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Phone Number",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    /// **Label**
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Email",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),

                    /// **Input Field**
                    Expanded(
                      child: TextField(
                        controller: serviceNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Email Id",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                /// **Submit Button (Styled as per Image)**
                Center(
                  child: SizedBox(
                    width: 120, // Match image size
                    height: 40, // Match image height
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement submit logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Green color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Small rounded corners
                        ),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

      ),

    );
    ();
  }
}
