part of 'shop_authbloc_bloc.dart';

@immutable
sealed class ShopAuthblocEvent {}
class shopcheckloginstateevent extends ShopAuthblocEvent {}

// login

class ShopLoginEvent extends ShopAuthblocEvent {
  final String Email;
  final String Password;

  ShopLoginEvent({required this.Email, required this.Password});
}

// Signup
class ShopSignupEvent extends ShopAuthblocEvent {
  final ShopModel shop;
  ShopSignupEvent({required this.shop});
}

//signout

class ShopSigOutEvent extends ShopAuthblocEvent {}
class FetchShopDetailsById extends ShopAuthblocEvent {}

