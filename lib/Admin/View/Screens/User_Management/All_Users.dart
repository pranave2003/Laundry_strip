import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Authbloc/auth_bloc.dart';

import '../../../../Widget/constands/Loading.dart';
import '../../../Model/User_Model/user_model.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18)),
                      child: TextField(
                        onChanged: (value) {
                          context
                              .read<AuthBloc>()
                              .add(FetchUsers(searchQuery: value)); // P
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: .5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          hintText: 'Search Users',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.person)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notification_add)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Users",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "All Users",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 700, // Adjust width as needed
                      height: 2.5,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is UsersLoading) {
                      return Center(child: Loading_Widget());
                    } else if (state is Usersfailerror) {
                      return Text(state.error.toString());
                    } else if (state is Usersloaded) {
                      if (state.Users.isEmpty) {
                        // Return "No data found" if txhe list is empty
                        return Center(
                          child: Text(
                            "No data found",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      }

                      return ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: ListView.builder(
                          itemCount: state.Users.length,
                          itemBuilder: (context, index) {
                            final user = state.Users[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.grey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey.shade300,
                                        backgroundImage: NetworkImage(
                                            user.imageUrl.toString())),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(user.name.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          Text("Phone No: ${user.phone}"),
                                          Text("Email Id: ${user.email}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
