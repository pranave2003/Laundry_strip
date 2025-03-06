import 'package:flutter/material.dart';
import '../../../../Widget/constands/colors.dart';
import '../Auth/shop_login.dart';

class Shop_Splash extends StatefulWidget {
  const Shop_Splash({super.key});

  @override
  State<Shop_Splash> createState() => _Shop_SplashState();
}

class _Shop_SplashState extends State<Shop_Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 3000),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopLogin()));
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
