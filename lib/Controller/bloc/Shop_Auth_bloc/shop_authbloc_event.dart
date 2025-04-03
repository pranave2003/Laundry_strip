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

//edit profile
class EditShopProfile extends ShopAuthblocEvent {
  final ShopModel shop;
  EditShopProfile({required this.shop});
}

// update Profile

class PickAndUploadImageEvent extends ShopAuthblocEvent {}
//signout

class ShopSigOutEvent extends ShopAuthblocEvent {}

// get shop details

class FetchShopDetailsById extends ShopAuthblocEvent {}

class FetchShop extends ShopAuthblocEvent {
  final String? searchQuery;
  final String? status;
  FetchShop({required this.searchQuery,this.status});
}

class UserFetchShop extends ShopAuthblocEvent {
  final String? searchQuery;
  final String? service;
  UserFetchShop({required this.searchQuery, this.service});
}

// accept or reject
class AcceptReject extends ShopAuthblocEvent {
  final String? status;
  final String? shopid;
  AcceptReject({required this.status,required this.shopid});
}

