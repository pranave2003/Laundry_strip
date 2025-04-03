import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Widget/constands/Loading.dart';

import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../Address/My_Address.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'AboutUs.dart';
import 'ContactUs.dart';
import 'Edit_profile.dart';
import 'PrivacyPolicy.dart';
import 'TermsPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(SigOutEvent());
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<AuthBloc>()..add(FetchUserDetailsById());
    super.initState();
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
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Userloading) {
            return const Center(child: Loading_Widget());
          } else if (state is UserByidLoaded) {
            final user = state.Userdata;
            return Column(
              children: [
                // Profile Header inside a Light Grey Container
                Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(
                      //       12), // Rounded corners for image
                      //   child: Image.network(
                      //     user.imageUrl.toString(),
                      //     width: 100, // Adjusted width
                      //     height: 100, // Adjusted height
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return Container(
                      //         width: 130,
                      //         height: 100,
                      //         color: Colors.grey[300], // Placeholder background
                      //         child: Icon(
                      //           Icons.image_not_supported,
                      //           size: 50,
                      //           color: Colors.grey[600],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // Rounded corners for image
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: user.imageUrl.toString(),
                            width: 100, // Adjusted width
                            height: 100, // Adjusted height
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300], // Placeholder background
                              child: Center(
                                child: Loading_Widget(), // Loading indicator
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300], // Placeholder background
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.name ?? ''}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${user.phone ?? ''}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '${user.email ?? ''}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Edit Profile Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                      userid: user.uid ??
                                          "", // Provide a default empty string if null
                                      username: user.name ?? "",
                                      phone: user.phone ?? "",
                                      imagePath: user.imageUrl ?? "",
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
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
                      _buildProfileOption(
                        icon: Icons.location_on,
                        title: "Addresses",
                        context: context,
                        page: AddressesPage(user),
                        //(user),
                      ),
                      _buildProfileOption(
                        icon: Icons.info_outline,
                        title: "About Us",
                        context: context,
                        page: AboutUsPage(),
                      ),
                      _buildProfileOption(
                        icon: Icons.phone,
                        title: "Contact Us",
                        context: context,
                        page: ContactUsPage(),
                      ),
                      _buildProfileOption(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: "Chat With Us",
                        context: context,
                        page: const ChatPage(),
                      ),
                      _buildProfileOption(
                        icon: Icons.rule,
                        title: "Terms & Conditions",
                        context: context,
                        page: TermsAndConditionsPage(),
                      ),
                      _buildProfileOption(
                        icon: Icons.privacy_tip,
                        title: "Privacy Policies",
                        context: context,
                        page: PrivacyPolicyPage(),
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
            );
          }
          return SizedBox();
        },
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

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat With Us")),
      body: const Center(child: Text("Chat Page")),
    );
  }
}
