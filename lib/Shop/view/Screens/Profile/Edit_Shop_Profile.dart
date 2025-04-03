import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/Shopmodel/Shopmodel.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class EditShop_ProfilePage extends StatefulWidget {
  const EditShop_ProfilePage({
    super.key,
    required this.shopid,
    required this.shopname,
    required this.phone,
    required this.imagePath,
  });

  final String shopid;
  final String shopname;
  final String phone;
  final String imagePath;

  @override
  _EditShop_ProfilePageState createState() => _EditShop_ProfilePageState();
}

class _EditShop_ProfilePageState extends State<EditShop_ProfilePage> {
  TextEditingController shopnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    shopnameController.text = widget.shopname;
    phoneController.text = widget.phone;
    imagePath = widget.imagePath;
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
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50), // Added space from the top

          // Profile Picture (Network Image Support)
          CachedNetworkImage(
            imageUrl: widget.imagePath.toString(),
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
          SizedBox(height: 8),

          // "Change Picture" Button
          BlocBuilder<ShopAuthblocBloc, ShopAuthblocState>(
            builder: (context, state) {
              if (state is ProfileImageSuccess) {
                // setState(() {
                //   Navigator.pushReplacement(context, MaterialPageRoute(
                //     builder: (context) {
                //       return BottomNavWrapper();
                //     },
                //   ));
                // });
              }
              return TextButton(
                onPressed: () {
                  context.read<ShopAuthblocBloc>()..add(PickAndUploadImageEvent());
                },
                child: state is ProfileImageLoading
                    ? Loading_Widget()
                    : state is ProfileImageSuccess
                    ? Text(
                  "Profile Updated",
                  style: TextStyle(color: Colors.green),
                )
                    : Text(
                  "Change Picture",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 30), // Added space before form fields

          // Form Fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                CustomTextForm(
                  controller: shopnameController,
                  prefixIcon: Icon(Icons.house_rounded),
                  hintText: "Shop Name",
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  controller: phoneController,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Mobile Number",
                ),
                SizedBox(height: 70),

                // Update Button
                BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
                  listener: (context, state) {
                    if (state is Shopload) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {
                          ShopModel shop = ShopModel(
                            shopid: widget.shopid,
                            shop_name: shopnameController.text,
                            phone: phoneController.text,
                            ShopImage: imagePath ?? "",
                          );

                          context.read<ShopAuthblocBloc>().add(EditShopProfile(shop: shop));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state is ShopLoading
                            ? Loading_Widget()
                            : Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        color: defaultColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
