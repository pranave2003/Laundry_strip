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

// get shop details

class FetchShopDetailsById extends ShopAuthblocEvent {}

class FetchShop extends ShopAuthblocEvent {
  final String? searchQuery;
  FetchShop({required this.searchQuery});
}

class UserFetchShop extends ShopAuthblocEvent {
  final String? searchQuery;
  final String? service;
  UserFetchShop({required this.searchQuery, this.service});
}
