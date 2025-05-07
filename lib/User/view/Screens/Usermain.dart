import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:laundry/Controller/bloc/Shop_Auth_bloc/shop_authbloc_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../Controller/bloc/Authbloc/auth_bloc.dart';
import '../../../Controller/bloc/Orderbloc/order_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Dropdownbloc/dropdownbloc_bloc.dart';
import '../../../Controller/bloc/ServiceManagement/Shopadddproduct/addproduct_bloc.dart';
import '../../../Controller/bloc/Strip/BlocLayer/payment_bloc.dart';
import '../../../Service/Notification_onesignal/onesignal_service.dart';
import '../../../Service/Strip/keys.dart';
import '../../../Service/Strip/payment_repository.dart';
import '../../../firebase_options.dart';
import 'Bottom_navigation/btm_navigation.dart';
import 'auth/Spashview.dart';
import 'auth/user_login.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey = Publishablekey;
//   await Stripe.instance.applySettings();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize("31027e59-8ba5-4e43-b06f-96ecdaac4e90");
//   OneSignal.Notifications.requestPermission(true);
//   await initOneSignal();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  // Initialize Stripe
  try {
    Stripe.publishableKey = Publishablekey;
    await Stripe.instance.applySettings();
  } catch (e) {
    print("//////////////////////////////  Stripe Initialization Error: $e");
  }

  // Initialize OneSignal
  try {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("31027e59-8ba5-4e43-b06f-96ecdaac4e90");
    OneSignal.Notifications.requestPermission(true);
    await initOneSignal();
  } catch (e) {
    print("OneSignal Initialization Error: $e");
  }

  runApp(MyApp());
}

Future<void> initOneSignal() async {
  await Future.delayed(const Duration(seconds: 2));

  final id = OneSignal.User.pushSubscription.id;

  if (id != null) {
    print('✅ OneSignal Player ID: $id');
    OneSignalService().setPlayerId(id); // Store in the service
  } else {
    print("❌ Player ID is null. The user may not be subscribed yet......");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PaymentBloc(paymentRepository: PaymentRepository()),
        ),
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
        BlocProvider(
          create: (context) =>
              PaymentBloc(paymentRepository: PaymentRepository()),
        ),
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
