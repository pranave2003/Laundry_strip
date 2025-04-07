import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';
import 'package:laundry/Shop/view/Screens/Profile/shopTerms.dart';
import 'package:laundry/Widget/constands/Loading.dart';

import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Shop/view/Screens/Profile/ContactUs.dart';

class DriverProfilewrapper extends StatefulWidget {
  const DriverProfilewrapper({super.key});

  @override
  State<DriverProfilewrapper> createState() => _DriverProfilewrapperState();
}

class _DriverProfilewrapperState extends State<DriverProfilewrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DriverblocBloc>(
      create: (context) => DriverblocBloc()..add(FetchDriverDetailsById()),
      child: DriverProfilePage(),
    );
  }
}

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => DriverProfilePageState();
}

class DriverProfilePageState extends State<DriverProfilePage> {
  void _logout() {
    final authBloc = BlocProvider.of<DriverblocBloc>(context);
    authBloc.add(DriverSigOutEvent());
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
          BlocBuilder<DriverblocBloc, DriverblocState>(
            builder: (context, state) {
              if (state is Driverloading) {
                return const Center(child: Loading_Widget());
              } else if (state is DriverByidLoaded) {
                final driver = state.userData;
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
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                12), // Rounded corners for image
                            child: CachedNetworkImage(
                              imageUrl: driver.image.toString(),
                              width: 130, // Adjusted width
                              height: 100, // Adjusted height
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 100,
                                height: 100,
                                color:
                                Colors.grey[300], // Placeholder background
                                child: Center(
                                  child: Loading_Widget(), // Loading indicator
                                ),
                              ),
                              errorWidget: (context, error, stackTrace) {
                                return Container(
                                  width: 130,
                                  height: 100,
                                  color: Colors
                                      .grey[300], // Placeholder background
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 16), // More spacing
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${driver.name ?? ''}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${driver.email ?? ''}',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              '${driver.phone ?? ''}',
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => EditShop_ProfilePage(
                          //         shopid: shop.shopid ??
                          //             "", // Provide a default empty string if null
                          //         shopname: shop.shop_name ?? "",
                          //         phone: shop.phone ?? "",
                          //         imagePath: shop.ShopImage ?? "",
                          //       )),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          // Better color
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
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    context
                        .read<DriverblocBloc>()
                        .add(PickUploadImageEvent());
                  },
                  child: Text("Edit Profile")),
            ],
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
                  page: ContactUs(),
                ),
                _buildProfileOption(
                  icon: Icons.rule,
                  title: "Terms & Conditions",
                  context: context,
                  page: LaundryShopTermsPage(),
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
