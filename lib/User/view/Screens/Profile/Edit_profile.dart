import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Authbloc/Userauthmodel/Usermodel.dart';
import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../../Widget/constands/Loading.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.userid,
    required this.username,
    required this.phone,
    required this.imagePath,
  });

  final String userid;
  final String username;
  final String phone;
  final String imagePath;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    usernameController.text=widget.username;
    phoneController.text=widget.phone;
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
          CircleAvatar(
            radius: 45,
            backgroundImage: imagePath != null && imagePath!.isNotEmpty
                ? NetworkImage(imagePath!)
                : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4ZqivCNC7yvJqthqZOVvxSjDLyDxtai-cbQ&s"),
          ),
          SizedBox(height: 8),

          // "Change Picture" Button
          TextButton(
            onPressed: () {
              print("Change Picture Clicked"); // Add image picker logic here
            },
            child: Text(
              "Change Picture",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 30), // Added space before form fields

          // Form Fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                CustomTextForm(
                  controller: usernameController,
                  prefixIcon: Icon(Icons.person),
                  hintText: "Username",
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  controller: phoneController,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Mobile Number",
                ),
                SizedBox(height: 70),

                // Update Button
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Userload) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {
                          UserModel user = UserModel(
                            uid: widget.userid,
                            name: usernameController.text,
                            phone: phoneController.text,
                            imageUrl: imagePath ?? "",
                          );

                          context.read<AuthBloc>().add(EditProfile(user: user));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state is UsersLoading
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
