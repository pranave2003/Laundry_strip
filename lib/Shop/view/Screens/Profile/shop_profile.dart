import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Shop/view/Screens/Profile/shopTerms.dart';
import 'package:laundry/Widget/constands/Loading.dart';

import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import 'ContactUs.dart';

class ShopProfilePage extends StatefulWidget {
  const ShopProfilePage({super.key});

  @override
  State<ShopProfilePage> createState() => _ShopProfilePageState();
}

class _ShopProfilePageState extends State<ShopProfilePage> {
  void _logout() {
    final authBloc = BlocProvider.of<ShopAuthblocBloc>(context);
    authBloc.add(ShopSigOutEvent());
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
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
          BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
            builder: (context, state) {
              if (state is Shoploading) {
                return const Center(child: Loading_Widget());
              } else if (state is ShopByidLoaded) {
                final shop = state.userData;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12), // Slightly rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // Rounded corners for image
                        child: Image.asset(
                          "assets/shop_img/img.png",
                          width: 130, // Adjusted width
                          height: 100, // Adjusted height
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16), // More spacing
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${shop.shop_name ?? ''}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${shop.email ?? ''}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${shop.phone ?? ''}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10), // Space before the button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Edit Profile Page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent, // Better color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Less rounded for a modern look
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),

          // Profile Options List
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(
                  icon: Icons.info_outline,
                  title: "About Us",
                  context: context,
                  page: const About(),
                ),
                _buildProfileOption(
                  icon: Icons.phone,
                  title: "Contact Us",
                  context: context,
                  page:  ContactUs(),
                ),
                _buildProfileOption(
                  icon: Icons.rule,
                  title: "Terms & Conditions",
                  context: context,
                  page:  LaundryShopTermsPage(),
                ),
                _buildProfileOption(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policies",
                  context: context,
                  page: const PrivacyPolicy(),
                ),
                _buildProfileOption(
                  icon: Icons.delete,
                  title: "Remove Account",
                  context: context,
                  isDestructive: true,
                  showArrow: false,
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: "Logout",
                  context: context,
                  onTap: _logout,
                  isDestructive: true,
                  showArrow: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile Option Builder with Navigation Support
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required BuildContext context,
    Widget? page,
    Function()? onTap,
    bool isDestructive = false,
    bool showArrow = true,
  }) {
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
          trailing: showArrow
              ? const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey)
              : null,
          onTap: onTap ??
              () {
                if (page != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  );
                }
              },
        ),
      ),
    );
  }
}


//PrivacyPolicy
class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Conditions")),
      body: const Center(child: Text("Terms Page")),
    );
  }
}

//About
class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Conditions")),
      body: const Center(child: Text("Terms Page")),
    );
  }
}
