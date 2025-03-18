import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';

class ShopSplashpagewrapper extends StatelessWidget {
  const ShopSplashpagewrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthblocBloc()..add(shopcheckloginstateevent()),
      child: Splashshop(),
    );
  }
}

class Splashshop extends StatefulWidget {
  const Splashshop({super.key});

  @override
  State<Splashshop> createState() => _SplashshopState();
}

class _SplashshopState extends State<Splashshop> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopAuthblocBloc, ShopAuthblocState>(
      listener: (context, state) {
        if (state is ShopAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is ShopUnAuthenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset("assets/splash_logo.png")),
      ),
    );
  }
}
