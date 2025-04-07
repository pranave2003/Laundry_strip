import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_state.dart';

import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';

class Splashpagedriverwrapper extends StatelessWidget {
  const Splashpagedriverwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverblocBloc()..add(drivercheckloginstateevent()),
      child: DriverSplashview(),
    );
  }
}

class DriverSplashview extends StatefulWidget {
  const DriverSplashview({super.key});

  @override
  State<DriverSplashview> createState() => _DriverSplashviewState();
}

class _DriverSplashviewState extends State<DriverSplashview> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverblocBloc, DriverblocState>(
      listener: (context, state) {
        if (state is DriverAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is DriverUnAuthenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset("assets/splash_logo.png")),
      ),
    );
  }
}
