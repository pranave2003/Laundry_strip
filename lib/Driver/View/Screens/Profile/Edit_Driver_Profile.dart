import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';
import '../../../../Controller/bloc/Driverbloc/Drivermodel/Drivermodel.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class EditDriver_ProfilePage extends StatefulWidget {
  const EditDriver_ProfilePage({
    super.key,
    required this.driverId,
    required this.name,
    required this.phone,
    required this.image,
  });

  final String driverId;
  final String name;
  final String phone;
  final String image;

  @override
  _EditDriver_ProfilePageState createState() => _EditDriver_ProfilePageState();
}

class _EditDriver_ProfilePageState extends State<EditDriver_ProfilePage> {
  TextEditingController drivernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? image;

  @override
  void initState() {
    super.initState();
    drivernameController.text = widget.name;
    phoneController.text = widget.phone;
    image = widget.image;
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
            imageUrl: widget.image.toString(),
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
          BlocBuilder<DriverblocBloc, DriverblocState>(
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
                  context.read<DriverblocBloc>()..add(PickUploadImageEvent());
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
                  controller: drivernameController,
                  prefixIcon: Icon(Icons.house_rounded),
                  hintText: "Name",
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  controller: phoneController,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Mobile Number",
                ),
                SizedBox(height: 70),

                // Update Button
                BlocConsumer<DriverblocBloc, DriverblocState>(
                  listener: (context, state) {
                    if (state is Driverload) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {
                          Driver driver = Driver(
                            driverId: widget.driverId,
                            name: drivernameController.text,
                            phone: phoneController.text,
                            image: image ?? "",
                            email: '', proof: '',
                          );

                          context.read<DriverblocBloc>().add(EditDriverProfile(driver: driver));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state is DriverLoading
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
