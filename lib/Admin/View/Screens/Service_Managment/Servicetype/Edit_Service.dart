import 'package:flutter/material.dart';

class ServiceEdit extends StatefulWidget {
  const ServiceEdit({super.key});

  @override
  State<ServiceEdit> createState() => _ServiceEditState();
}

class _ServiceEditState extends State<ServiceEdit> {
  TextEditingController serviceNameController = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello !",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Cheers and Happy Activities ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Admin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffD9D9D9),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Service",
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
                        "Service Image",
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
                          hintText: imagePath ?? "Service Image",
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
                        "Service Name",
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
                          hintText: "Enter Service Name",
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
