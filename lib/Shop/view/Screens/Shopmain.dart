import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';

import '../../../firebase_options.dart';
import 'Auth/ShopSplash.dart';
import 'Auth/shop_login.dart';
import 'Bottom_Navigation/Shop_nav.dart';

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
        BlocProvider<ShopAuthblocBloc>(
          create: (context) => ShopAuthblocBloc()..add(FetchShopDetailsById()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => ShopSplashpagewrapper(),
          '/home': (context) => ShopBottomNavWrapper(),
          '/login': (context) => Shop_Loginwrapper(),
        },
      ),
    );
  }
}
