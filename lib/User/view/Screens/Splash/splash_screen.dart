import 'package:flutter/material.dart';
import '../../../../Widget/constands/colors.dart';
import '../auth/user_login.md';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 3000),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLogin()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash_bg.png"),
                alignment: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(
                children: [
                  Text(
                    "Welcome to,",
                    style: TextStyle(fontSize: 20,color: Colors.black),
                  ),
                  Text(
                    "Laundry Mate",
                    style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold,color: defaultColor),
                  ),
                  // Image(
                  //     image: AssetImage("assets/splash_logo.png"),
                  //     alignment: Alignment.topCenter),
                  Image.asset("assets/splash_logo.png",width: 180,height: 180,),
                ],
              ),
              SizedBox(),

            ],
          ),
        ),
      ),
    );
  }
}
