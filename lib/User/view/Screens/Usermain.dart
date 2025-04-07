import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import '../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Dropdownbloc/dropdownbloc_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../firebase_options.dart';
import 'Bottom_navigation/btm_navigation.dart';
import 'auth/Spashview.dart';
import 'auth/user_login.dart';

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
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()
              ..add(
                FetchUserDetailsById(),
              )),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
        BlocProvider<ShopAuthblocBloc>(
          create: (context) =>
              ShopAuthblocBloc()..add(UserFetchShop(searchQuery: null)),
        ),
        BlocProvider<DropdownblocBloc>(
          create: (context) =>
              DropdownblocBloc()..add(Fetchcatogorybydropdown()),
        ),
        BlocProvider<AddproductBloc>(create: (context) => AddproductBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagewrapper(),
          '/home': (context) => BottomNavWrapper(),
          '/login': (context) => User_Loginwrapper(),
        },
      ),
    );
  }
}
