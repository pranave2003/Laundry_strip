import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Address/My_Address.dart';
import 'Edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Header inside a Light Grey Container
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/profile_pic.png"), // Update with your image path
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kavya Vijayan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "9856324789",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        "kavyavijayan@gmail.com",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Profile Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          // Profile Options List
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(Icons.location_on, "Addresses", context, AddressesPage()),
                _buildProfileOption(Icons.info_outline, "About Us", context, AboutUsPage()),
                _buildProfileOption(Icons.phone, "Contact Us", context, ContactUsPage()),
                _buildProfileOption(Icons.chat_bubble_outline_rounded, "Chat With Us", context, ChatPage()),
                _buildProfileOption(Icons.rule, "Terms & Conditions", context, TermsPage()),
                _buildProfileOption(Icons.privacy_tip, "Privacy Policies", context, PrivacyPolicyPage()),
                _buildProfileOption(Icons.delete, "Remove Account", context, null, isDestructive: true, showArrow: false),
                _buildProfileOption(Icons.logout, "Logout", context, null, isDestructive: true, showArrow: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile Option Builder with Navigation Support
  Widget _buildProfileOption(IconData icon, String title, BuildContext context, Widget? page,
      {bool isDestructive = false, bool showArrow = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: isDestructive ? Colors.red : Colors.blue),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDestructive ? Colors.red : Colors.black,
            ),
          ),
          trailing: showArrow ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey) : null,
          onTap: () {
            if (page != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            } else {
              print("$title clicked");
            }
          },
        ),
      ),
    );
  }
}

// 🔹 Dummy Edit Profile Page


// Dummy Pages for Navigation


class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: Center(child: Text("About Us Page")),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Center(child: Text("Contact Us Page")),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat With Us")),
      body: Center(child: Text("Chat Page")),
    );
  }
}

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: Center(child: Text("Terms & Conditions Page")),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policies")),
      body: Center(child: Text("Privacy Policy Page")),
    );
  }
}
