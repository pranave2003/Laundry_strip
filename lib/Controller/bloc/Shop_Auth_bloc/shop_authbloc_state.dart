part of 'shop_authbloc_bloc.dart';

@immutable
sealed class ShopAuthblocState {}

final class ShopAuthblocInitial extends ShopAuthblocState {}

class ShopAuthloading extends ShopAuthblocState {}

class ShopAuthenticated extends ShopAuthblocState {
  User? user;
  ShopAuthenticated(this.user);
}

class ShopUnAuthenticated extends ShopAuthblocState {}

class ShopAuthenticatedError extends ShopAuthblocState {
  final String message;

  ShopAuthenticatedError({required this.message});
}

// final class ShopByidLoaded extends ShopAuthblocState {
//   final ShopModel Userdata;
//   ShopByidLoaded(this.Userdata);
// }
//
// class Shoploading extends ShopAuthblocState {}
//
// class ShopError extends ShopAuthblocState {
//   String error;
//   ShopError({required this.error});
// }


//
final class ShopByidLoaded extends ShopAuthblocState {
  final ShopModel userData;
  ShopByidLoaded(this.userData);
}

class Shoploading extends ShopAuthblocState {}

class ShopError extends ShopAuthblocState {
  String error;
  ShopError({required this.error});
}

////
final class ShopLoading extends ShopAuthblocState {}

final class ShopGetSuccess extends ShopAuthblocState {}

final class Shopfailerror extends ShopAuthblocState {
  final String error;

  Shopfailerror(this.error);
}

class Shoploaded extends ShopAuthblocState {
  final List<ShopModel> Shop;

  Shoploaded(
      this.Shop,
      );
}
