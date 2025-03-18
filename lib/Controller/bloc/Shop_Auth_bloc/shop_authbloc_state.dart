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