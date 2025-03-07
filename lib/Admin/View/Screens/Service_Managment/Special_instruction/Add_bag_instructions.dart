import 'package:flutter/material.dart';

class BagInstructionsAdd extends StatefulWidget {
  const BagInstructionsAdd({super.key});

  @override
  State<BagInstructionsAdd> createState() => _BagInstructionsAddState();
}

class _BagInstructionsAddState extends State<BagInstructionsAdd> {
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
                  "Add Bag Instructions",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 18,
                ),
                Container(
                  height: 40,
                  width: 400,

                ),
              ],
            ),
          ),
          SizedBox(height: 50,),

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

                SizedBox(height: 20),

                /// **Service Name Field (Text & Input in Same Line)**
                Row(
                  children: [
                    /// **Label**
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Instruction Name",
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
                          hintText: "Enter Instruction Name",
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 60),

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
                        "Submit",
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
