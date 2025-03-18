import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../../Widget/constands/colors.dart';
import '../../../../Widget/constands/widgets.dart';
import '../Bottom_Navigation/Shop_nav.dart';
import '../Home/Shop_home.dart';
import 'ResetPswdShop.dart';
import 'Shop_SignUp.dart';

class Shop_Loginwrapper extends StatelessWidget {
  const Shop_Loginwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthblocBloc(),
      child: ShopLogin(),
    );
  }
}

class ShopLogin extends StatefulWidget {
  const ShopLogin({super.key});

  @override
  State<ShopLogin> createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ShopAuthblocBloc>(context).add(
        ShopLoginEvent(
          Email: _emailController.text.trim(),
          Password: _passwordController.text.trim(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAuthblocBloc, ShopAuthblocState>(
      listener: (context, state) {
        if (state is ShopAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          });
        }
        if (state is ShopAuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
    builder: (context, state) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/splash_logo.png',
                    width: 150,
                  ),
                  Text(
                    'Laundry Mate',
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ElevatedButton(
                            onPressed: () => _onLoginPressed(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: defaultColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                activeColor: Secondary,
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                    //isChecked = !isChecked;
                                    // if(isChecked == false){
                                    //   isChecked = true;
                                    // }else{
                                    //   isChecked = false;
                                    // }
                                  });
                                },),
                            SizedBox(height: 8),
                            Text("Remember Me "),
                            SizedBox(
                              width: 70,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordShop(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Color(0xFF8E8E93)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New to Laundry Mate?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Shopsignupwrapper();
                                  },));
                                },
                                child: Text("Sign Up")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }
}
