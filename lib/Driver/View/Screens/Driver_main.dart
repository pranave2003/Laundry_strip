import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Driverbloc/driverbloc_bloc.dart';

import '../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Dropdownbloc/dropdownbloc_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/service_bloc.dart';
import '../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../firebase_options.dart';
import 'Auth/Driver_Login.dart';
import 'Auth/Driver_Splash.dart';
import 'Btm_Nav/Driver_Btm_Nav.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DriverblocBloc>(
          create: (context) => DriverblocBloc()..add(FetchDriverDetailsById()),
        ),
              BlocProvider<OrderBloc>(create: (context) => OrderBloc())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagedriverwrapper(),
          '/home': (context) => DriverBottomNavWrapper(),
          '/login': (context) => Driver_Loginwrapper(),
        },

      ),
    );
  }
}
